package multipublish.vo.elements
{
	
	/**
	 * 
	 * 排版按钮。
	 * 
	 */
	
	
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.consts.ArrangeLayoutTypeConsts;
	import multipublish.core.mp;
	
	
	public final class ArrangeIcon extends VO
	{
		
		/**
		 * 
		 * <code>Icon</code>构造函数。
		 * 
		 */
		
		public function ArrangeIcon($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var list:* = data["bindid"];
			if (list)
			{
				mp::bindID     = getProperty("bindid");
				mp::bindType   = getProperty("bindtype", uint);
				mp::iconX      = getProperty("xpos"    , Number);
				mp::iconY      = getProperty("ypos"    , Number);
				mp::iconWidth  = getProperty("width"   , Number);
				mp::iconHeight = getProperty("height"  , Number);
				mp::time       = getProperty("interval", uint);
				mp::tween      = getProperty("hasTween", Boolean);
				
				mp::layoutType = getProperty("layoutType");
				
				if (layoutType == ArrangeLayoutTypeConsts.CUSTOM_LAYOUT)
				{
					list = data["customInfo"];
					if (list)
					{
						mp::customX = ObjectUtil.convert(list["x"], Number);
						mp::customY = ObjectUtil.convert(list["y"], Number);
						mp::customW = ObjectUtil.convert(list["w"], Number);
						mp::customH = ObjectUtil.convert(list["h"], Number);
					}
				}
			}
			else
			{
				list = data["folder"];
				if (list)
				{
					var tmb:String = ObjectUtil.convert(list["thumbnailpath"]);
					mp::thumbnail  = CacheUtil.extractURI(tmb, PathConsts.PATH_FILE);
					wt::registCache(tmb);
					
					registThumbnail();
				}
				else
				{
					list = data["layout"];
					if (list)
					{
						var pre:String = ObjectUtil.convert(data["thumbnailurl"]);
						tmb = pre + ObjectUtil.convert(list["thumbnailpath"]);
						mp::thumbnail  = CacheUtil.extractURI(tmb, PathConsts.PATH_FILE);
						wt::registCache(tmb);
						
						registThumbnail();
					}
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function registThumbnail():void
		{
			parent && parent.wt::registCache(Cache.gain(thumbnail));
		}
		
		
		/**
		 * 
		 * 绑定ID
		 * 
		 */
		
		public function get bindID():String
		{
			return mp::bindID;
		}
		
		
		/**
		 * 
		 * 绑定类型
		 * 
		 */
		
		public function get bindType():uint
		{
			return mp::bindType;
		}
		
		
		/**
		 * 
		 * iconHeight
		 * 
		 */
		
		public function get iconHeight():Number
		{
			return mp::iconHeight;
		}
		
		
		/**
		 * 
		 * iconWidth
		 * 
		 */
		
		public function get iconWidth():Number
		{
			return mp::iconWidth;
		}
		
		
		/**
		 * 
		 * iconX
		 * 
		 */
		
		public function get iconX():Number
		{
			return mp::iconX;
		}
		
		
		/**
		 * 
		 * iconY
		 * 
		 */
		
		public function get iconY():Number
		{
			return mp::iconY;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function get id():String
		{
			return vid.toString();
		}
		
		
		/**
		 * 
		 * 排版布局类型。
		 * 
		 */
		
		public function get layoutType():String
		{
			return mp::layoutType;
		}
		
		
		/**
		 * 
		 * 自定义排版布局X。
		 * 
		 */
		
		public function get customX():Number
		{
			return mp::customX;
		}
		
		
		/**
		 * 
		 * 自定义排版布局Y。
		 * 
		 */
		
		public function get customY():Number
		{
			return mp::customY;
		}
		
		
		/**
		 * 
		 * 自定义排版布局W。
		 * 
		 */
		
		public function get customW():Number
		{
			return mp::customW;
		}
		
		
		/**
		 * 
		 * 自定义排版布局H。
		 * 
		 */
		
		public function get customH():Number
		{
			return mp::customH;
		}
		
		
		/**
		 * 
		 * 缩略图。
		 * 
		 */
		
		public function get thumbnail():String
		{
			return mp::thumbnail;
		}
		
		
		/**
		 * 
		 * 间隔时长。
		 * 
		 */
		
		public function get time():uint
		{
			return mp::time;
		}
		
		
		/**
		 * 
		 * 有无缓动。
		 * 
		 */
		
		public function get tween():Boolean
		{
			return mp::tween as Boolean;
		}
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent($value:VO):void
		{
			super.parent = $value;
			
			registThumbnail();
		}
		
		
		/**
		 * 
		 * 层级关系
		 * 
		 */
		
		public var level:uint;
		
		
		/**
		 * 
		 * 对应的元素。
		 * 
		 */
		
		public function get element():Element
		{
			return mp::element;
		}
		
		/**
		 * @private
		 */
		public function set element($value:Element):void
		{
			mp::element = $value;
			if (element is Arrange && !element.level) element.level = level;
		}
		
		
		/**
		 * @private
		 */
		mp var element:Element;
		
		/**
		 * @private
		 */
		mp var bindID:uint;
		
		/**
		 * @private
		 */
		mp var bindType:uint;
		
		/**
		 * @private
		 */
		mp var iconHeight:Number;
		
		/**
		 * @private
		 */
		mp var iconWidth:Number;
		
		/**
		 * @private
		 */
		mp var iconX:Number;
		
		/**
		 * @private
		 */
		mp var iconY:Number;
		
		/**
		 * @private
		 */
		mp var layoutType:String;
		
		/**
		 * @private
		 */
		mp var customX:Number;
		
		/**
		 * @private
		 */
		mp var customY:Number;
		
		/**
		 * @private
		 */
		mp var customW:Number;
		
		/**
		 * @private
		 */
		mp var customH:Number;
		
		/**
		 * @private
		 */
		mp var thumbnail:String;
		
		/**
		 * @private
		 */
		mp var time:uint;
		
		/**
		 * @private
		 */
		mp var tween:Boolean;
		
	}
}