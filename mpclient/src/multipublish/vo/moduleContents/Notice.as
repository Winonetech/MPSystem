package multipublish.vo.moduleContents
{
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	public final class Notice extends Content
	{
		
		/**
		 * 
		 * 告示通知。
		 * 
		 */
		
		public function Notice($data:Object=null)
		{
			super($data);
		}
		
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("url", String);
			
			if (!StringUtil.isEmpty(url))
			{
				wt::registCache(url); 
				mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			}
		}
		
		/**
		 * 
		 * 标题。
		 * 
		 */
		
		public function get noticeTitle():String
		{
			return getProperty("title", String);
		}
		
		
		/**
		 * 
		 * 公告内容。
		 * 
		 */
		
		public function get content():String
		{
			return getProperty("content", String);
		}
		
		
		
		/**
		 * 
		 * 播放时长。
		 * 
		 */
		
		public function get timeLength():uint
		{
			return getProperty("timeLength", uint);
		}
		

		
		/**
		 * 
		 * 标题大小。
		 * 
		 */
		
		public function get titleFont():uint
		{
			return getProperty("titleFont", uint);
		}
		
		
		/**
		 * 
		 * 内容大小。
		 * 
		 */
		
		public function get contentFont():uint
		{
			return getProperty("contentFont", uint);
		}
		
		
		/**
		 * 
		 * 背景颜色。
		 * 
		 */
		
		public function get bgColor():String
		{
			return getProperty("bgColor", String);
		}
		
		
		/**
		 * 
		 * 标题字体颜色。
		 * 
		 */
		
		public function get titleColor():uint
		{
			return getProperty("titleColor", String);
		}
		
		
		/**
		 * 
		 * 内容字体颜色。
		 * 
		 */
		
		public function get contentColor():uint
		{
			return getProperty("contentColor", String);
		}
		
		
		
		
		
		public function get picPath():String
		{
			return mp::content;
		}
		
		mp var content:String;
		
	}
}