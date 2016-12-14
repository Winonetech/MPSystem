package multipublish.vo.programs
{
	
	/**
	 * 
	 * 节目数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	
	import com.winonetech.core.VO;
	
	import multipublish.core.mp;
	
	
	public final class Program extends VO
	{
		
		/**
		 * 
		 * <code>Program</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Program($data:Object = null)
		{
			super($data);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 添加一个Layout。
		 * 
		 */
		
		public function addLayout(layout:Layout):void
		{
			layout.program = this;
			
			mp::layouts[layout.id] = layout;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::layouts = new Map;
		}
		
		
		/**
		 * 
		 * 摘要，描述。
		 * 
		 */
		
		public function get summary():String
		{
			return getProperty("title");
		}
		
		
		/**
		 * 
		 * 高度。
		 * 
		 */
		
		public function get height():Number
		{
			return getProperty("height", Number);
		}
		
		
		/**
		 * 
		 * 布局列表。
		 * 
		 */
		
		public function get layouts():Map
		{
			return mp::layouts;
		}
		
		
		/**
		 * 
		 * 宽度。
		 * 
		 */
		
		public function get width():Number
		{
			return getProperty("width", Number);
		}
		
		
		/**
		 * @private
		 */
		mp var layouts:Map;
		
		
		/**
		 * 
		 * 布局引用。
		 * 
		 */
		
		public var layout:Layout;
		
	}
}