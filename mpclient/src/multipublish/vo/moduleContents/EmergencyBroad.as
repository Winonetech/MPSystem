package multipublish.vo.moduleContents
{
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import cn.vision.utils.StringUtil;
	
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
		
		public function EmergencyBroad(
			$data:Object = null, 
			$name:String = "emergencyBroad", 
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
			
			var urls:Array = getProperty("url", Array);
			for each (var url:String in urls)
			{
				if (!StringUtil.empty(url))
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
		
		
		public function get titleColor():uint
		{
			return getProperty("titleColor", uint);
		}
		
		
		public function get bgColor():uint
		{
			return uint(getProperty("bgColor", uint));
		}
		
		public function get contentColor():uint
		{
			return getProperty("contentColor", uint);
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