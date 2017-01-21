package multipublish.vo.programs
{
	
	/**
	 * 
	 * 版面元素数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	import com.winonetech.utils.ConvertUtil;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	
	public final class Component extends VO
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Component(
			$data:Object = null, 
			$name:String = "component", 
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
			
			mp::background = getProperty("backgroundPic");
			if(!StringUtil.isEmpty(mp::background))
			{
				wt::registCache(mp::background);
				mp::background = CacheUtil.extractURI(mp::background, PathConsts.PATH_FILE);
			}
			
			mp::backgroundAlpha = getProperty("backgroundAlpha", Number);
			if (mp::backgroundAlpha > 1)
				mp::backgroundAlpha = mp::backgroundAlpha * .01;
		}
		
		
		/**
		 * 
		 * 添加内容。
		 * 
		 */
		
		mp function addContent($content:Content):void
		{
			if ($content && contents.indexOf($content) == -1)
			{
				ArrayUtil.push(contents, $content);
				//$content.parent = this;
			}
		}
		
		
		/**
		 * 
		 * 删除内容。
		 * 
		 */
		
		mp function delContent($content:Content):void
		{
			var index:int = contents.indexOf($content);
			if (index!= -1) 
			{
				contents.splice(index, 1);
				$content.parent = null;
			}
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
		 * 是否允许交互。
		 * 
		 */
		
		public function get interactable():Boolean
		{
			return getProperty("interactEnabled", Boolean);
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
		 * @private
		 */
		public function set w($value:Number):void
		{
			setProperty("width", $value);
		}
		
		
		/**
		 * 
		 * 点击链接。
		 * 
		 */
		
		public function get code():String
		{
			return getProperty("componentTypeCode");
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
		 * @private
		 */
		public function set x($value:Number):void
		{
			setProperty("coordX", $value);
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
		 * @private
		 */
		public function set y($value:Number):void
		{
			setProperty("coordY", $value);
		}
		
		
		/**
		 * 
		 * 链接至页面ID。
		 * 
		 */
		
		public function get linkID():String
		{
			return getProperty("linkId");
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
		 * 链接的页面ID。
		 * 
		 */
		
		public function get background():String
		{
			return mp::background;
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
		 * 背景颜色。
		 * 
		 */
		
		public function get backgroundColor():uint
		{
			var temp:String = getProperty("backgroundColor");
			return temp ? ConvertUtil.touint(temp) : 0xFFFFFF;
		}
		
		
		/**
		 * 
		 * 获取过渡方式，左右过渡或上下过渡。
		 * 上下为false 左右为true。
		 * 
		 */
		
		public function get transition():Boolean
		{
			return getProperty("transition") == "upDown" ? false : true;
		}
		
		
		/**
		 * 
		 * 如果是资讯组件，是否显示图片。
		 * 
		 */
		
		public function get noImage():Boolean
		{
			return getProperty("titleShowType") == "2";
		}
		
		
		/**
		 * 
		 * 内容集合。
		 * 
		 */
		
		public function get contents():Vector.<Content>
		{
			return mp::contents;
		}
		
		
		public function get config():MPCConfig
		{
			return MPCConfig.instance;
		} 
		
		/**
		 * @private
		 */
		mp var contents:Vector.<Content> = new Vector.<Content>;
		
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