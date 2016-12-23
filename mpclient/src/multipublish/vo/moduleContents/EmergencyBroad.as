package multipublish.vo.moduleContents
{
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import flashx.textLayout.factory.StringTextLineFactory;
	
	import multipublish.utils.VOUtil;
	import multipublish.vo.contents.Content;
	
	public final class EmergencyBroad extends Content
	{
		
		/**
		 * 
		 * 应急播报。
		 * 
		 */
		
		public function EmergencyBroad($data:Object=null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var urls:Array = getProperty("url", Array);
			for each (var url:String in urls)
			{
				if (!StringUtil.isEmpty(url))
				{
					wt::registCache(url);
					wt::content.push(CacheUtil.extractURI(url, PathConsts.PATH_FILE));
				}
			}
		}
		
		/**
		 * 
		 * 标题。
		 * 
		 */
		public function get moduleTitle():String
		{
			return getProperty("title", String);
		}
		
		
		public function get moduleContent():String
		{
			return getProperty("content", String);
		}
		
		
		public function get titleFont():uint
		{
			return getProperty("titleFont", uint);
		}
		
		public function get contentFont():uint
		{
			return getProperty("contentFont", uint);
		}
		
		
		public function get useBcg():Boolean
		{
			return getProperty("isBcg", Boolean);
		}
		
		
		public function get timeLength():uint
		{
			return getProperty("timeLength", uint);
		}
		
		public function get contents():Array
		{
			return wt::content;
		}
		
		wt var content:Array = new Array; 
	}
}