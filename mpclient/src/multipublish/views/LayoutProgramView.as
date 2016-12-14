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
	import multipublish.vo.programs.Program;
	
	import spark.components.Group;
	
	
	public final class LayoutProgramView extends ProgramView
	{
		
		/**
		 * 
		 * <code>ProgramView</code>构造函数。
		 * 
		 */
		
		public function LayoutProgramView()
		{
			super();
			
			initializeEnvironment();
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
				
				container.addElement(view = new LayoutView);
				view.width  = program.width;
				view.height = program.height;
				view.data   = program.layout; 
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
		private var view:LayoutView;
		
	}
}