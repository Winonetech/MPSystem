package multipublish.vo.elements
{
	
	/**
	 * 
	 * 排版元素数据结构。
	 * 
	 */
	
	
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.consts.ArrangeBackgroundModeConsts;
	import multipublish.core.mp;
	
	
	public final class Arrange extends Element
	{
		
		/**
		 * 
		 * <code>Arrange</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Arrange($data:Object = null)
		{
			super($data);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 添加一个子元素。
		 * 
		 */
		
		public function addElement($icon:ArrangeIcon):void
		{
			$icon.parent = this;
			$icon.level = level + 1;
			ArrayUtil.push(icons, $icon);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var list:* = data["layout"];
			if (list)
			{
				mp::id = list["id"];
				mp::summary = list["name"];
				mp::backgroundMode = XMLUtil.convert(list["items"]["bgmode"], uint);
				var pre:String = XMLUtil.convert(data["thumbnailurl"]);
				var tmb:String = pre + XMLUtil.convert(list["thumbnailpath"]);
				mp::thumbnail  = CacheUtil.extractURI(tmb, PathConsts.PATH_FILE);
				wt::registCache(tmb);
				if (backgroundMode == ArrangeBackgroundModeConsts.IMAGE)
				{
					var bgi:String = pre + XMLUtil.convert(list["items"]["bg"]);
					mp::backgroundImage = CacheUtil.extractURI(bgi, PathConsts.PATH_FILE);
					wt::registCache(bgi);
				}
				else
				{
					mp::backgroundColor = XMLUtil.convert(list["items"]["bg"], uint);
				}
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function toString():String
		{
			return "[Arrange:{" + "vid:" + vid + ", id:" + id + ", backgroundImage:" + backgroundImage + "}]";
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::icons = new Vector.<ArrangeIcon>;
		}
		
		
		/**
		 * 
		 * summary
		 * 
		 */
		
		public function get summary():String
		{
			return mp::summary;
		}
		
		
		/**
		 * 
		 * backgroundColor
		 * 
		 */
		
		public function get backgroundColor():uint
		{
			return mp::backgroundColor;
		}
		
		
		/**
		 * 
		 * backgroundImage
		 * 
		 */
		
		public function get backgroundImage():String
		{
			return mp::backgroundImage;
		}
		
		
		/**
		 * 
		 * backgroundMode
		 * 
		 */
		
		public function get backgroundMode():uint
		{
			return mp::backgroundMode;
		}
		
		
		/**
		 * 
		 * 子元素集合。
		 * 
		 */
		
		public function get icons():Vector.<ArrangeIcon>
		{
			return mp::icons;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set thumbnail($value:String):void
		{
			mp::thumbnail = $value;
		}
		
		
		/**
		 * 
		 * id
		 * 
		 */
		
		override public function get id():String
		{
			return mp::id;
		}
		
		
		/**
		 * 
		 * 广告。
		 * 
		 */
		
		public var advertise:Advertise;
		
		
		/**
		 * @private
		 */
		mp var icons:Vector.<ArrangeIcon>;
		
		
		/**
		 * @private
		 */
		mp var backgroundColor:uint;
		
		/**
		 * @private
		 */
		mp var backgroundImage:String;
		
		/**
		 * @private
		 */
		mp var backgroundMode:uint;
		
		/**
		 * @private
		 */
		mp var id:String;
		
		/**
		 * @private
		 */
		mp var summary:String;
		
	}
}