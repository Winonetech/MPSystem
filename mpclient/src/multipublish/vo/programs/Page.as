package multipublish.vo.programs
{
	
	/**
	 * 
	 * 页面版面数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.MathUtil;
	
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Button;
	
	
	public final class Page extends Sheet
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Page($data:Object = null, $name:String = "page")
		{
			super($data, $name);
		}
		
		
		/**
		 * 
		 * 添加子项。
		 * 
		 */
		
		mp function addPage($page:Page):void
		{
			if(!pagesMap[$page.id])
			{
				pagesMap[$page.id] = $page;
				pagesArr.push($page);
				$page.mp::father = this;
				
				mp::updatePagesOrder();
			}
		}
		
		
		/**
		 * 
		 * 删除子项。
		 * 
		 */
		
		mp function delPage($page:Page):void
		{
			if (pagesMap[$page.id])
			{
				delete pagesMap[$page.id];
				if (pagesArr[$page.order] == $page)
					pagesArr.splice($page.order, 1);
				$page.mp::father = null;
				
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
		 * 是否允许渐变缓动。
		 * 
		 */
		
		public function get tweenable():Boolean
		{
			return getProperty("tweenEnabled", Boolean);
		}
		
		
		/**
		 * 
		 * 顺序。
		 * 
		 */
		
		public function get order():uint
		{
			return getProperty("order", uint);
		}
		
		/**
		 * @private
		 */
		public function set order($value:uint):void
		{
			setProperty("order", $value);
		}
		
		
		/**
		 * 
		 * 是否为首页。
		 * 
		 */
		
		public function get home():Boolean
		{
			return getProperty("home", Boolean);
		}
		
		
		/**
		 * 
		 * 页面层级。
		 * 
		 */
		
		public function get level():uint
		{
			if (mp::level== 0)
			{
				mp::level = 1;
				var temp:Page = father;
				while (temp)
				{
					temp = temp.father;
					mp::level += 1;
				}
			}
			return mp::level;
		}
		
		
		/**
		 * 
		 * 父级页面数据结构引用。
		 * 
		 */
		
		public function get father():Page
		{
			return mp::father;
		}
		
		
		/**
		 * 
		 * 子页面数组。
		 * 
		 */
		
		public function get pagesArr():Array
		{
			return mp::pagesArr;
		}
		
		
		/**
		 * 
		 * 子页面集合。
		 * 
		 */
		
		public function get pagesMap():Map
		{
			return mp::pagesMap;
		}
		
		
		/**
		 * 
		 * 关联的按钮。
		 * 
		 */
		
		public var button:Button;
		
		
		/**
		 * @private
		 */
		mp var level:uint = 0;
		
		/**
		 * @private
		 */
		mp var father:Page;
		
		/**
		 * @private
		 */
		mp var pagesArr:Array = [];
		
		/**
		 * @private
		 */
		mp var pagesMap:Map = new Map;
		
	}
}