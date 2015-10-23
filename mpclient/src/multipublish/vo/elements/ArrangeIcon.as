package multipublish.vo.elements
{
	
	/**
	 * 
	 * 排版按钮。
	 * 
	 */
	
	
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
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
			}
			else
			{
				list = data["folder"];
				if (list)
				{
					var tmb:String = XMLUtil.convert(list["thumbnailpath"]);
					mp::thumbnail  = CacheUtil.extractURI(tmb, PathConsts.PATH_FILE);
					wt::registCache(tmb);
					
					registThumbnail();
				}
				else
				{
					list = data["layout"];
					if (list)
					{
						var pre:String = XMLUtil.convert(data["thumbnailurl"]);
						tmb = pre + XMLUtil.convert(list["thumbnailpath"]);
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
		 * @inheritDoc
		 */
		
		override public function set parent($value:VO):void
		{
			super.parent = $value;
			
			registThumbnail();
		}
		
		
		/**
		 * 
		 * 对应的元素。
		 * 
		 */
		
		public var element:Element;
		
		
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
		mp var thumbnail:String;
		
		/**
		 * @private
		 */
		mp var time:uint;
		
	}
}