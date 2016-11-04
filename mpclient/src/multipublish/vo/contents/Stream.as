package multipublish.vo.contents
{
	public final class Stream extends Content
	{
		public function Stream($data:Object = null)
		{
			super($data);
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