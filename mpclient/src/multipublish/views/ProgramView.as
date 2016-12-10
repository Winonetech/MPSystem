package multipublish.views
{
	
	/**
	 * 
	 * 节目视图。
	 * 
	 */
	
	
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.utils.ContentUtil;
	import multipublish.views.moduleContents.AskPaperView;
	import multipublish.views.moduleContents.EmergencyBroadView;
	import multipublish.views.moduleContents.NoticeView;
	import multipublish.vo.programs.Program;
	
	import spark.components.Group;
	
	
	public final class ProgramView extends MPView
	{
		
		/**
		 * 
		 * <code>ProgramView</code>构造函数。
		 * 
		 */
		
		public function ProgramView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * 
		 * 自适应父容器尺寸。
		 * 
		 */
		
		public function autofitScale():void
		{
			container.scaleX = container.scaleY = 
				 (container.width > 0 && container.height > 0)
					?(container.width / container.height < width / height 
						? height / container.height
						: width  / container.width) 
					: 1;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			LogSQLite.log(
				TypeConsts.FILE,
				EventConsts.EVENT_START_PLAYING, program.summary,
				log(MPTipConsts.RECORD_PROGRAM_PLAY, program));
			
			if (view)
			{
				view.addEventListener(ControlEvent.STOP, handlerLayoutEnd);
				view.play();
			}
			else
			{
				stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			if (view)
			{
				view.removeEventListener(ControlEvent.STOP, handlerLayoutEnd);
				view.stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			if (view) 
			{
				view.reset();
				view = null;
			}
			program = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		override protected function resolveData():void
		{
			program = data as Program;
			if (program)
			{
				log(MPTipConsts.RECORD_PROGRAM_DATA, data);
				
				container.width  = program.width;
				container.height = program.height;
				
				
				autofitScale();
				
				container.addElement(view = new (ContentUtil.getModuleView(program.moduleType)));
				view.width  = program.width;
				view.height = program.height;
				view.data   = program.moduleType
					? program.moduleContents 
					: program.layout; 
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerLayoutEnd($e:ControlEvent):void
		{
			stop();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			mouseEnabled = false;
			addElement(container = new Group);
			container.mouseEnabled = false;
			//container.horizontalCenter = 0;
			container.verticalCenter = 0;
		}
		
		/**
		 * @private
		 */
		private var container:Group;
		
		/**
		 * @private
		 */
		private var program:Program;
		
		/**
		 * @private
		 */
		private var view:*;
		
	}
}