package multipublish.vo.contents
{
	
	/**
	 * 
	 * 视频格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.utils.VOUtil;
	
	
	public final class Record extends Content
	{
		
		/**
		 * 
		 * <code>Record</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Record(
			$data:Object = null, 
			$name:String = "record", 
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
			setProperty("contentType", "video");
			
			var url:String = getProperty("contentSource");
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			
			wt::registCache(url);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent(value:VO):void
		{
			super.parent = value;
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
		 * 播放次数。
		 * 
		 */
		
		public function get playTimes():uint
		{
			return getProperty("playTimes", uint);
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