package multipublish.vo.programs
{
	import cn.vision.collections.Map;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.vo.MPVO;
	
	
	public class Sheet extends MPVO
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Sheet(
			$data:Object = null, 
			$name:String = "sheet", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			mp::background = getProperty("background");
			if(!StringUtil.isEmpty(mp::background))
			{
				wt::registCache(mp::background);
				mp::background = CacheUtil.extractURI(mp::background, PathConsts.PATH_FILE);
			}
			
			mp::backgroundAlpha = Number(data["backgroundAlpha"]);
			mp::backgroundAlpha = isNaN(mp::backgroundAlpha) ? 1 : mp::backgroundAlpha;
			if (mp::backgroundAlpha > 1)
				mp::backgroundAlpha = mp::backgroundAlpha * .01;
		}
		
		
		/**
		 * 
		 * 添加组件。
		 * 
		 */
		
		mp function addComponent($component:Component):void
		{
			if(!componentsMap[$component.id])
			{
				componentsMap[$component.id] = $component;
				ArrayUtil.push(componentsArr, $component);
			}
		}
		
		
		/**
		 * 
		 * 删除组件。
		 * 
		 */
		
		mp function delComponent($component:Component):void
		{
			if ($component)
			{
				delete componentsMap[$component.id];
				if (componentsArr[$component.order] == $component)
					componentsArr.splice($component.order, 1);
				
				mp::updateComponentsOrder();
			}
		}
		
		
		/**
		 * 
		 * 更新组件顺序。
		 * 
		 */
		
		mp function updateComponentsOrder():void
		{
			componentsArr.sortOn("order", Array.NUMERIC);
			var l:uint = componentsArr.length;
			for (var i:uint = 0; i < l; i++) componentsArr[i].order = i;
		}
		
		
		/**
		 * 
		 * 名称。
		 * 
		 */
		
		public function get label():String
		{
			return getProperty("label");
		}
		
		/**
		 * @private
		 */
		public function set label($value:String):void
		{
			setProperty("label", $value);
		}
		
		
		/**
		 * 
		 * 背景图片。
		 * 
		 */
		
		public function get background():String
		{
			return mp::background;
		}
		
		
		/**
		 * 
		 * 背景颜色。
		 * 
		 */
		
		public function get backgroundColor():uint
		{
			return getProperty("backgroundColor", uint);
		}
		
		
		/**
		 * 
		 * 背景透明度。
		 * 
		 */
		
		public function get backgroundAlpha():Number
		{
			return mp::backgroundAlpha;
		}
		
		
		/**
		 * 
		 * h。
		 * 
		 */
		
		public function get h():Number
		{
			var r:Number = getProperty("height", Number);
			return isNaN(r) || r < 0 ? config.height : r;
		}
		
		/**
		 * @private
		 */
		public function set h($value:Number):void
		{
			setProperty("height", $value);
		}
		
		
		/**
		 * 
		 * w。
		 * 
		 */
		
		public function get w():Number
		{
			var r:Number = getProperty("width", Number);
			return isNaN(r) || r < 0 ? config.width : r;
		}
		
		
		/**
		 * 
		 * x。
		 * 
		 */
		
		public function get x():Number
		{
			var r:Number = getProperty("coordX", Number);
			return isNaN(r) || r < 0 ? 0 : r;
		}
		
		
		/**
		 * 
		 * y。
		 * 
		 */
		
		public function get y():Number
		{
			var r:Number = getProperty("coordY", Number);
			return isNaN(r) || r < 0 ? 0 : r;
		}
		
		
		/**
		 * 
		 * 元素数组。
		 * 
		 */
		
		public function get componentsArr():Array
		{
			return mp::componentsArr;
		}
		
		
		/**
		 * 
		 * 元素集合。
		 * 
		 */
		
		public function get componentsMap():Map
		{
			return mp::componentsMap;
		}
		
		
		public function get config():MPCConfig
		{
			return MPCConfig.instance;
		} 
		
		/**
		 * 
		 * 是否选中。
		 * 
		 */
		
		public var selected:Boolean;
		
		
		/**
		 * @private
		 */
		mp var componentsArr:Array = [];
		
		/**
		 * @private
		 */
		mp var componentsMap:Map = new Map;
		
		/**
		 * @private
		 */
		mp var background:String;
		
		/**
		 * @private
		 */
		mp var backgroundAlpha:Number;
		
	}
}