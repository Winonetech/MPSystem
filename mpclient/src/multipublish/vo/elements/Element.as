package multipublish.vo.elements
{
	
	/**
	 * 
	 * 排版元素，可以是以下类型：<br>
	 * 1.广告，需指定文件夹；<br>
	 * 2.布局，排版；<br>
	 * 3.办公文档模式；<br>
	 * 4.普通播放模式（视频，图片，SWF混播）；<br>
	 * 5.文件夹缩略图浏览模式（视频，图片，SWF）；<br>
	 * 6.时间轴模式；<br>
	 * 7.网址。<br>
	 * 
	 */
	
	
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.interfaces.IThumbnail;
	
	
	public class Element extends VO implements IThumbnail
	{
		
		/**
		 * 
		 * <code>Element</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Element($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @hnheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			var list:* = data["bindid"];
			if (list)
			{
				mp::id = getProperty("bindid");
			}
			else
			{
				list = data["folder"];
				if (list)
				{
					mp::id         = XMLUtil.convert(list["id"]);
					mp::type       = XMLUtil.convert(list["type"], uint);
					var tmb:String = XMLUtil.convert(list["thumbnailpath"]);
					mp::thumbnail  = CacheUtil.extractURI(tmb, PathConsts.PATH_FILE);
					wt::registCache(tmb);
					
					registThumbnail();
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
		 * @inheritDoc
		 */
		
		override public function get id():String
		{
			return mp::id;
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
		 * @inheritDoc
		 */
		[Bindable]
		public function get thumbnail():String
		{
			return mp::thumbnail;
		}
		
		/**
		 * @private
		 */
		public function set thumbnail($value:String):void
		{
			mp::thumbnail = $value;
		}
		
		
		/**
		 * 
		 * 元素类别。
		 * 
		 */
		
		public function get type():uint
		{
			return mp::type;
		}
		
		
		/**
		 * 
		 * 层级关系
		 * 
		 */
		
		public var level:uint;
		
		
		/**
		 * @private
		 */
		mp var id:String;
		
		/**
		 * @private
		 */
		mp var thumbnail:String;
		
		/**
		 * @private
		 */
		mp var type:uint;
		
	}
}