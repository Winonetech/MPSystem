package multipublish.commands
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.tools.WipeCache;
	
	import spark.components.WindowedApplication;

	
	/**
	 * 
	 * 清理缓存命令。
	 * 
	 */
	
	public final class CleanCacheCommand extends _InternalCommand
	{
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function CleanCacheCommand()
		{
			super();
			
			app = config.view.application;
			
			timerStart();
		}
		
		
		override public function execute():void
		{
			commandStart();
			
			clean();
			
			commandEnd();
		}
		
		
		private function timer_handler(e:TimerEvent):void
		{
			if (config.view.main.data) //当无排期播放时，不执行清空缓存。
			{
				WipeCache.wipeNormalCache();
				timerRemove();
			}
		}
		
		
		private function timerRemove():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timer_handler);
				timer = null;
				
				app && app.removeEventListener(MouseEvent.CLICK, timerStart);
			}
		}
		
		
		private function timerStart(e:MouseEvent = null):void
		{
			if (!timer)
			{
				timer = new Timer(GAP_TIME * 1000);
				timer.addEventListener(TimerEvent.TIMER, timer_handler);
			}
			
			timer.reset();
			timer.start();
		}
		
		
		private function clean():void
		{
			app && app.addEventListener(MouseEvent.CLICK, timerStart);
			
//			config.controller.registControlCleanCache(presenter.cleanCache, 86400 * NEXT_DAY);
		}
		
		private var timer:Timer;
		
		private var app:WindowedApplication;
		
		private const GAP_TIME:uint = 60;
		
		private const NEXT_DAY:uint = 5; 
	}
}