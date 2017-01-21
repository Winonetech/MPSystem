package multipublish.vo.contents
{
	
	/**
	 * 
	 * 内容数据结构基类，可以是以下类型：<br>
	 * 1.自由排版格式；<br>
	 * 2.相册格式；<br>
	 * 3.跑马灯格式；<br>
	 * 4.图片格式；<br>
	 * 5.视频格式；<br>
	 * 6.二维码格式。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	
	use namespace wt;
	
	
	public class Content extends VO
	{
		
		/**
		 * 
		 * <code>Content</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Content(
			$data:Object = null, 
			$name:String = "content", 
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
			
			mp::backgroundAlpha = getProperty("backgroundAlpha", Number);
			if (mp::backgroundAlpha > 1)
				mp::backgroundAlpha = mp::backgroundAlpha * .01;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent($value:VO):void
		{
			if (parent) parent.wt::delChild(this);
			wt::parent = $value;
			if (parent) parent.wt::addChild(this);
		}
		
		
		/**
		 * 
		 * 标题名称。
		 * 
		 */
		
		public function get title():String
		{
			return getProperty("contentName") || "";
		}
		
		
		/**
		 * 
		 * 内容类型。
		 * 
		 */
		
		public function get type():String
		{
			return getProperty("contentType");
		}
		
		
		/**
		 * 
		 * 引用该内容的组件ID。
		 * 
		 */
		
		public function get componentID():String
		{
			return getProperty("componentId");
		}
		
		
		/**
		 * 
		 * 链接的页面ID。
		 * 
		 */
		
		public function get pageID():String
		{
			return getProperty("pageId");
		}
		
		
		/**
		 * 
		 * 链接的页面ID。
		 * 
		 */
		
		public function set pageID($value:String):void
		{
			return setProperty("pageId", $value);
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
			return getProperty("backgroundColor", uint);
		}
		
		
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