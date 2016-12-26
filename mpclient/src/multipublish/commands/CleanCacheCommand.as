package multipublish.commands
{
	import cn.vision.consts.state.CommandStateConsts;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.tools.Controller;
	import multipublish.tools.WipeCache;
	
	import spark.components.WindowedApplication;

	
	
	/**
	 * 
	 * 清理缓存命令。
	 * 
	 */
	
	public final class CleanCacheCommand extends _InternalCommand
	{
		
		
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
			WipeCache.wipeNormalCache();
			timerRemove();
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
			
			config.controller.registControlUsecache(presenter.cleanCahce, 86400 * NEXT_DAY);      //一天有86400秒。
		}
		
		private var timer:Timer;
		
		private var app:WindowedApplication;
		
		private const GAP_TIME:uint = 60;
		
		private const NEXT_DAY:uint = 5;
	}
}