package multipublish.vo.programs
{
	
	/**
	 * 
	 * 布局数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ArrayUtil;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.vo.MPVO;
	import multipublish.vo.contents.Content;
	
	
	public final class Layout extends MPVO
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Layout(
			$data:Object = null, 
			$name:String = "layout", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 添加一个Page。
		 * 
		 */
		
		mp function addPage($page:Page):void
		{
			if(!pagesMap[$page.id])
			{
				pagesMap[$page.id] = $page;
				ArrayUtil.push(pagesArr, $page);
				mp::updatePagesOrder();
				
				if(!home && $page.home) home = $page;
			}
		}
		
		
		/**
		 * 
		 * 删除一个Page。
		 * 
		 */
		
		mp function delPage($page:Page):void
		{
			if (pagesMap[$page.id])
			{
				delete pagesMap[$page.id];
				if (pagesArr[$page.order] == $page)
					pagesArr.splice($page.order, 1);
				
				mp::updatePagesOrder();
			}
		}
		
		
		/**
		 * 
		 * 更新顺序。
		 * 
		 */
		
		mp function updatePagesOrder():void
		{
			pagesArr.sortOn("order", Array.NUMERIC);
			var l:uint = pagesArr.length;
			for (var i:uint = 0; i < l; i++) pagesArr[i].order = i;
		}
		
		
		/**
		 * 
		 * 页面数组。
		 * 
		 */
		
		public function get pagesArr():Array
		{
			return mp::pagesArr;
		}
		
		
		/**
		 * 
		 * 页面字典。
		 * 
		 */
		
		public function get pagesMap():Map
		{
			return mp::pagesMap;
		}
		
		
		/**
		 * 
		 * 子级对父级页面切换形式。
		 * 
		 */
		
		public function get b2t():String
		{
			return getProperty("b2t");
		}
		
		
		/**
		 * 
		 * 父级对子级页面切换形式。
		 * 
		 */
		
		public function get t2b():String
		{
			return getProperty("t2b");
		}
		
		
		/**
		 * 
		 * 同一级别页面切换形式。
		 * 
		 */
		
		public function get vis():String
		{
			return getProperty("vis");
		}
		
		
		/**
		 * 
		 * 广告引用。
		 * 
		 */
		
		public var ad:AD;
		
		
		/**
		 * 
		 * 首页引用。
		 * 
		 */
		
		public var home:Page;
		
		
		/**
		 * 
		 * 所有页面。
		 * 
		 */
		
		public var pagesTol:Map = new Map;
		
		
		/**
		 * @private
		 */
		mp var pagesArr:Array = [];
		
		/**
		 * @private
		 */
		mp var pagesMap:Map = new Map;
		
		
		//--------------------------------------------------
		// 不再支持的属性
		//--------------------------------------------------
		
		
		/**
		 * 
		 * 添加一个Content。
		 * 
		 */
		
		public function addContent(content:Content):void
		{
			if (contents.indexOf(content)== -1)
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
		 * 高度。
		 * 
		 */
		
		public function get height():Number
		{
			var h:Number = getProperty("height", Number);
			return h <= 0 ? config.height : h;
		}
		
		
		/**
		 * 
		 * 宽度。
		 * 
		 */
		
		public function get width():Number
		{
			var w:Number = getProperty("width", Number);
			return w <= 0 ? config.width : w;
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
		
		
		public function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		/**
		 * 
		 * 父级Program对象的引用。
		 * 
		 */
		
		public var program:Program;
		
		
		/**
		 * 
		 * 存储临时组按钮。
		 * 
		 */
		
		public var buttons:Array = [];
		
		
		/**
		 * @private
		 */
		mp var contents:Vector.<Content>;
		
	}
}