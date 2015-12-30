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
	import multipublish.core.mp;
	import multipublish.vo.programs.Layout;
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
				( container.width > 0 && container.height > 0)
				?(container.width / container.height < width / height 
					? height / container.height
					: width  / container.width) : 1;
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
			
			if (layouts.length)
			{
				for each (var layout:LayoutView in layouts)
				{
					layout.addEventListener(ControlEvent.STOP, handlerLayoutEnd, false, 0, true);
					layout.play();
				}
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
			count = 0;
			for each (var layout:LayoutView in layouts)
			{
				layout.removeEventListener(ControlEvent.STOP, handlerLayoutEnd);
				layout.stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			layouts.length = count = 0;
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
				for each (var child:Layout in program.layouts)
				{
					var layout:LayoutView = new LayoutView;
					layout.data = child;
					layouts.push(layout);
					container.addElement(layout);
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerLayoutEnd($e:ControlEvent):void
		{
			layout.removeEventListener(ControlEvent.STOP, handlerLayoutEnd);
			if (++count >= layouts.length) stop();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			addElement(container = new Group);
			container.horizontalCenter = 0;
			container.verticalCenter   = 0;
		}
		
		
		/**
		 *  
		 * 布局视图集合。
		 * 
		 */
		
		private function get layouts():Vector.<LayoutView>
		{
			return mp::layouts || (mp::layouts = new Vector.<LayoutView>);
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
		private var count:uint;
		
		
		/**
		 * @private
		 */
		mp var layouts:Vector.<LayoutView>;
		
	}
}