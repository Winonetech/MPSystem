package multipublish.vo.contents
{
	
	/**
	 * 
	 * 视频格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import flash.filesystem.File;
	
	import multipublish.core.mp;
	
	
	public final class Record extends Content
	{
		
		/**
		 * 
		 * <code>Record</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Record($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("getcontents");
			var temp:String = url.split(":").shift();
			if (temp == "file")
			{
				var str:String = (url.split(":\\\\").pop() as String).split("\\").pop();
				var temp1:String = File.applicationDirectory.resolvePath("cache\\content\\" + str).nativePath;
			}
			var temp2:String = (temp == "file") ? temp1 : CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			mp::content = temp2;
			wt::registCache(url);
		}
		
		
		/**
		 * 
		 * 图片地址。
		 * 
		 */
		
		override public function get content():String
		{
			return mp::content;
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}