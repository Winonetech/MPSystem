package multipublish.vo.contents
{
	
	/**
	 * 
	 * 图片格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.utils.VOUtil;
	
	
	public final class Picture extends Content
	{
		
		/**
		 * 
		 * <code>Picture</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Picture(
			$data:Object = null, 
			$name:String = "picture", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function customParse():void
		{
			setProperty("contentType", "image");
			
			var url:String = getProperty("contentSource");
			wt::registCache(url);
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
		}
		
		
		/**
		 * 
		 * 内容时长，秒。
		 * 
		 */
		
		public function get duration():uint
		{
			return getProperty("timeLength", uint);
		}
		
		
		/**
		 * 
		 * 图片地址。
		 * 
		 */
		
		public function get content():String
		{
			return mp::content;
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}