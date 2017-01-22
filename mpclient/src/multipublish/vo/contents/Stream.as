package multipublish.vo.contents
{
	
	/**
	 * 
	 * 流媒体。
	 * 
	 */
	
	public final class Stream extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Stream(
			$data:Object = null, 
			$name:String = "stream", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * 
		 * 流媒体路径，m3u8格式。
		 * 
		 */
		
		public function get content():String
		{
			return getProperty("contentSource");
		}
		
	}
}