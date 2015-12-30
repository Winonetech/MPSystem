package multipublish.tools
{
	
	/**
	 * 
	 * 文件下载进度上报器。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.ParallelQueue;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.RegexpUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.core.MPCConfig;
	
	
	public final class Reporter extends VSObject
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Reporter()
		{
			super();
			
			initialize();
		}
		
		
		/**
		 * 
		 * 开始上报进度。
		 * 
		 */
		
		public function start():void
		{
			if(!reporting)
			{
				reporting = true;
				timer = new Timer(5000);
				timer.addEventListener(TimerEvent.TIMER, handlerTimer);
				timer.start();
			}
		}
		
		
		/**
		 * 
		 * 停止上报进度。
		 * 
		 */
		
		public function stop():void
		{
			if (reporting)
			{
				reporting = false;
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, handlerTimer);
				timer = null;
			}
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			queue.addEventListener(QueueEvent.STEP_START, handlerCacheStart);
			queue.addEventListener(QueueEvent.STEP_END, handlerCacheEnd);
		}
		
		
		/**
		 * @private
		 */
		private function handlerCacheStart($e:QueueEvent):void
		{
			var cache:Cache = $e.command as Cache;
			REPORTABLE[cache] =!cache.exist;
			if (REPORTABLE[cache])
			{
				var name:String = cache.saveURL.split("/").pop();
				var data:String = name + ";2";
				var memo:String = name + (cache.reloadCount == 0 ? "开始下载" : "再次下载");
				
				LogSQLite.log(
					TypeConsts.FILE, 
					EventConsts.EVENT_DOWNLOADING_START, name,
					RegexpUtil.replaceTag(MPTipConsts.RECORD_CACHE_REPORT, memo));
				
				service.report(data);//发送2，开始下载。
			}
		}
		
		/**
		 * @private
		 */
		private function handlerCacheEnd($e:QueueEvent):void
		{
			var cache:Cache = $e.command as Cache;
			
			var exist:Boolean = cache.exist;
			var name:String = cache.saveURL.split("/").pop();
			var data:String = name + (exist ? ";3" : ";4");
			var memo:String = name + (exist ? " 下载完成" : " 下载失败");
			if(!exist) memo += "，" + cache.message;
			
			LogSQLite.log(
				TypeConsts.FILE,
				EventConsts.EVENT_DOWNLOADING_END, name,
				RegexpUtil.replaceTag(MPTipConsts.RECORD_CACHE_REPORT, memo));
			
			service.report(data);//发送3,4，完成下载。
			delete REPORTABLE[cache];
		}
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			for each (var cache:Cache in Cache.executingCaches)
			{
				var s:Number = .01 * uint(100 * cache.speed);
				var p:Number = .01 * uint(100 * cache.percent);
				var n:String = cache.saveURL.split("/").pop();
				service.report(n + "," + p + "," + s + "kb/s", false);
			}
		}
		
		
		/**
		 * @private
		 */
		private function get queue():ParallelQueue
		{
			return Cache.queue;
		}
		
		/**
		 * @private
		 */
		private function get service():MPService
		{
			return MPCConfig.instance.service;
		}
		
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var reporting:Boolean;
		
		
		/**
		 * @private
		 */
		private const REPORTABLE:Dictionary = new Dictionary;
		
	}
}