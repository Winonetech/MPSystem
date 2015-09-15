package multipublish.vo.programs
{
	
	/**
	 * 
	 * 布局数据结构。
	 * 
	 */
	
	
	import com.winonetech.core.VO;
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	
	public final class Layout extends VO
	{
		
		/**
		 * 
		 * <code>Layout</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Layout($data:Object = null)
		{
			super($data);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 添加一个Content。
		 * 
		 */
		
		public function addContent(content:Content):void
		{
			if (contents.indexOf(content) == -1)
				contents[contents.length] = content;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::contents = new Vector.<Content>;
		}
		
		
		/**
		 * 
		 * 内容列表。
		 * 
		 */
		
		public function get contents():Vector.<Content>
		{
			return mp::contents;
		}
		
		
		/**
		 * 
		 * 能否拖动。
		 * 
		 */
		
		public function get dragable():Boolean
		{
			return getProperty("dragable", Boolean);
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
		 * 宽度。
		 * 
		 */
		
		public function get width():Number
		{
			return getProperty("width", Number);
		}
		
		
		/**
		 * 
		 * X。
		 * 
		 */
		
		public function get x():Number
		{
			return getProperty("x", Number);
		}
		
		
		/**
		 * 
		 * Y。
		 * 
		 */
		
		public function get y():Number
		{
			return getProperty("y", Number);
		}
		
		
		/**
		 * 
		 * 父级Program对象的引用。
		 * 
		 */
		
		public var program:Program;
		
		
		/**
		 * @private
		 */
		mp var contents:Vector.<Content>;
		
	}
}