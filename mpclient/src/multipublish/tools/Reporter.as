package multipublish.tools
{
	
	/**
	 * 
	 * 文件下载进度上报器。
	 * 可能的状态有: 
	 * <br>2 -> 开始下载;
	 * <br>3 -> 下载成功;
	 * <br>4 -> 下载失败;
	 *
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.events.QueueEvent;
	import cn.vision.queue.ParallelQueue;
	
	import com.winonetech.tools.Cache;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import multipublish.core.MPCConfig;
	import multipublish.utils.ReportUtil;
	
	
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
			
			queue_sp.addEventListener(QueueEvent.STEP_START, handlerCacheStart);
			queue_sp.addEventListener(QueueEvent.STEP_END, handlerCacheEnd);
		}
		
		
		/**
		 * @private
		 */
		private function handlerCacheStart($e:QueueEvent):void
		{
			var cache:Cache = $e.command as Cache;
			if (ReportUtil.responsable(cache))
			{
				REPORTABLE[cache] =!cache.exist;
				if (REPORTABLE[cache])
				{
					var name:String = cache.isEpaper ? cache.saveURL : cache.saveURL.split("/").pop();
					var data:String = name + ";2";
					var memo:String = name + (cache.reloadCount == 0 ? "开始下载" : "再次下载");
					
					/*LogSQLite.log(
						TypeConsts.FILE, 
						EventConsts.EVENT_DOWNLOADING_START, name,
						RegexpUtil.replaceTag(MPTipConsts.RECORD_CACHE_REPORT, memo));*/
					
					service.report(data);//发送2，开始下载。
				}
			}
		}
		
		/**
		 * @private
		 */
		private function handlerCacheEnd($e:QueueEvent):void
		{
			var cache:Cache = $e.command as Cache;
			
			//两种情况不需要上报进度
			//1.报纸文件，且已经下载过的。
			//2.不存在的报纸文件。
			if (ReportUtil.responsable(cache) || 
				(cache.exist && REPORTABLE[cache]))
			{
				var exist:Boolean = cache.exist;
				var name:String = cache.isEpaper ? cache.saveURL : cache.saveURL.split("/").pop();
				var data:String = name + (exist ? ";3" : ";4");
				var memo:String = name + (exist ? " 下载完成" : " 下载失败");
				if(!exist) 
				{
					memo += "," + cache.message;
					data += ";" + cache.code + ";" + cache.message;
				}
				
				/*LogSQLite.log(
					TypeConsts.FILE,
					EventConsts.EVENT_DOWNLOADING_END, name,
					RegexpUtil.replaceTag(MPTipConsts.RECORD_CACHE_REPORT, memo));*/
				
				service.report(data);//发送3,4，完成下载。
				delete REPORTABLE[cache];
			}
		}
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			for each (var cache:Cache in Cache.executingCaches)
			{
				if(!(cache.extra && cache.extra.response == false))
				{
					var s:Number = .01 * uint(100 * cache.speed);
					var p:Number = .01 * uint(100 * cache.percent);
					var n:String = cache.isEpaper ? cache.saveURL : cache.saveURL.split("/").pop();
					service.report(n + "," + p + "," + s + "kb/s", false);
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function get queue():ParallelQueue
		{
			return Cache.queue;
		}
		
		
		private function get queue_sp():ParallelQueue
		{
			return Cache.queue_sp;
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