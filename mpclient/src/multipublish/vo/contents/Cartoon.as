package multipublish.vo.contents
{
	
	/**
	 * 
	 * FLASH动画格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import flash.filesystem.File;
	
	import multipublish.core.mp;
	import multipublish.interfaces.IThumbnail;
	
	
	public final class Cartoon extends Content
	{
		
		/**
		 * 
		 * <code>Picture</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Cartoon($data:Object = null)
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
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			wt::registCache(url);
		}
		
		
		/**
		 * 
		 * 图片地址。
		 * 
		 */
		
		override public function get content():String
		{
			var str:String = (mp::content as String).split("://").shift() == "file" 
				? File.applicationDirectory.resolvePath("cache\\content\\" +
					(mp::content as String).split("\\").pop()).nativePath : mp::content;
			return str;
		}
		
		
		/**
		 * 
		 * 时间长度。
		 * 
		 */
		
		public function get time():uint
		{
			return getProperty("timelength", uint);
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}