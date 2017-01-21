package multipublish.tools
{
	import cn.vision.core.VSEventDispatcher;
	import cn.vision.pattern.queue.ParallelQueue;
	
	import com.winonetech.tools.Cache;
	
	public final class Downloader extends VSEventDispatcher
	{
		public function Downloader()
		{
			super();
		}
		
		public function start():void
		{
			
		}
		
		public function clear():void
		{
			
		}
		
		
		public function get queueWait():ParallelQueue
		{
			return Cache.queue;
		}
		
		public function get queueUnwait():ParallelQueue
		{
			return Cache.queue_sp;
		}
		
		
		
	}
}