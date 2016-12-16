package multipublish.views
{
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.core.mp;
	import multipublish.utils.ContentUtil;
	import multipublish.views.moduleContents.ModuleView;
	import multipublish.vo.contents.Content;
	import multipublish.vo.programs.Program;
	
	import spark.components.Group;

	public class ProgramView extends MPView
	{
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
			
			if (currentView)
			{
				currentView.addEventListener(ControlEvent.STOP, handlerLayoutEnd);
				currentView.play();
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
			if (currentView)
			{
				currentView.removeEventListener(ControlEvent.STOP, handlerLayoutEnd);
				currentView.stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			if (currentView) 
			{
				currentView.reset();
				currentView = null;
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
				
				var tempW:Number = program.width  || 980;
				var tempH:Number = program.height || 540;
				
				container.width  = tempW;
				container.height = tempH;
				
				
				autofitScale();
				
				container.addElement(currentView = new (program.moduleType ? ModuleView : LayoutView));
				
				currentView.width  = tempW;
				currentView.height = tempH;
				currentView.addEventListener(ControlEvent.READY, handlerReady);
				currentView.data   = program.moduleType ? program.module : program.layout; 
			}
		}
		
		
		private function handlerReady($e:ControlEvent):void
		{
			var temp:MPView = $e.target as MPView;
			temp.removeEventListener(ControlEvent.READY, handlerReady);
			
			dispatchReady();
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
		
		private var readyCount:uint;
		
		
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
		private var currentView:MPView;
	}
}