package multipublish.tools
{
	
	/**
	 * 
	 * 时间控制器，用于控制在何时检测排期，精确到秒。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.utils.LogUtil;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.MPTipConsts;
	
	
	public final class Controller extends VSObject
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Controller()
		{
			super();
		}
		
		
		/**
		 * 
		 * 启动数据控制。
		 * 
		 * @param $handler:Function 数据控制回调函数。
		 * @param $time:Number (default = 30) 时间，以秒为单位。
		 * @param $args 回调函数的参数。
		 * 
		 */
		
		public function registControlUsecache($handler:Function, $time:Number = 30, ...$args):void
		{
			LogUtil.logTip(MPTipConsts.RECORD_CACHE_WAIT, $time);
			
			usecacheHandler = $handler;
			usecacheArgs = $args;
			if(!usecackeTimer)
			{
				usecackeTimer = new Timer(1000, $time);
				usecackeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerUsecache);
				usecackeTimer.start();
			}
		}
		
		
		/**
		 * 
		 * 清除节目播放时间控制。
		 * 
		 */
		
		public function removeControlAllBroadcast():void
		{
			broadcastCache = {};
		}
		
		
		/**
		 * 
		 * 清除截图时间控制。
		 * 
		 */
		
		public function removeControlAllShotcut():void
		{
			shotcutCache = {};
		}
		
		
		/**
		 * 
		 * 清除关机时间控制。
		 * 
		 */
		
		public function removeControlAllShutdown():void
		{
			shutdownCache = {};
		}
		
		
		
		/**
		 * 
		 * 注册节目播放时间点，在该时间点下执行回调。
		 * 
		 * @param $time:Date 时间，精确到秒。
		 * @param $handler:Function 调用函数。
		 * @param $args 方法所需参数。
		 * 
		 */
		
		public function registControlBroadcast($time:Date, $handler:Function = null, ...$args):void
		{
			if(!commanTimer)
			{
				commanTimer = new Timer(1000);
				commanTimer.addEventListener(TimerEvent.TIMER, handlerComman);
				commanTimer.start();
			}
			var note:String = getNote($time);
			broadcastCache = broadcastCache || {};
			broadcastCache[note] = {handler:$handler, args:$args};
		}
		
		
		/**
		 * 
		 * 注册关机时间点，在该时间点下执行回调。
		 * 
		 * @param $time:Date 时间，精确到秒。
		 * @param $handler:Function 调用函数。
		 * @param $args 方法所需参数。
		 * 
		 */
		
		public function registControlShutdown($time:Date, $handler:Function = null, ...$args):void
		{
			if(!commanTimer)
			{
				commanTimer = new Timer(1000);
				commanTimer.addEventListener(TimerEvent.TIMER, handlerComman);
				commanTimer.start();
			}
			var note:String = getNote($time, true);
			shutdownCache = shutdownCache || {};
			shutdownCache[note] = {handler:$handler, args:$args};
		}

		
		/**
		 * 
		 * 注册截图时间点，在该时间点下执行回调。
		 * 
		 * @param $time:Date 时间，精确到秒。
		 * @param $handler:Function 调用函数。
		 * @param $args 方法所需参数。
		 * 
		 */
		
		public function registControlShotcut($time:Date, $handler:Function = null, ...$args):void
		{
			if(!commanTimer)
			{
				commanTimer = new Timer(1000);
				commanTimer.addEventListener(TimerEvent.TIMER, handlerComman);
				commanTimer.start();
			}
			var note:String = getNote($time, true);
			shotcutCache = shotcutCache || {};
			shotcutCache[note] = {handler:$handler, args:$args};
		}
		
		
		/**
		 * 
		 * 停止数据控制。
		 * 
		 */
		
		public function removeControlUsecache():void
		{
			if (usecackeTimer)
			{
				usecackeTimer.stop();
				usecackeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, handlerUsecache);
				usecackeTimer = null;
			}
		}
		
		
		/**
		 * 解析成 星期/时/分/秒
		 * @param $day:是否需要解析星期
		 */
		
		private function getNote($date:Date, $day:Boolean = false):String
		{
			return ($day ? $date.day + "/" : "") + $date.hours + "/" + $date.minutes + "/" + $date.seconds;
		}
		
		
		/**
		 * @private
		 */
		private function handlerComman($e:TimerEvent):void
		{
			var now:Date = new Date;
			var note:String = getNote(now);
			var broadcast:Object = broadcastCache ? broadcastCache[note] : null;
			if (broadcast && broadcast.handler)
				broadcast.handler.apply(null, broadcast.args);
			
			note = getNote(now, true);
			var shutdown:Object = shutdownCache ? shutdownCache[note] : null;
			if (shutdown && shutdown.handler)
				shutdown.handler.apply(null, shutdown.args);
			
			var shotcut:Object = shotcutCache ? shotcutCache[note] : null;
			if (shotcut && shotcut.handler)
				shotcut.handler.apply(null, shotcut.args);
		}
		
		/**
		 * @private
		 */
		private function handlerUsecache($e:TimerEvent):void
		{
			LogUtil.logTip(MPTipConsts.RECORD_CACHE_USE, usecackeTimer);
			
			usecacheHandler && usecacheHandler.apply(null, usecacheArgs);
		}
		
		
		/**
		 * @private
		 */
		private var usecacheHandler:Function;
		
		/**
		 * @private
		 */
		private var usecacheArgs:Array;
		
		/**
		 * @private
		 */
		private var usecackeTimer:Timer;
		
		/**
		 * @private
		 */
		private var commanTimer:Timer;
		
		/**
		 * @private
		 */
		private var broadcastCache:Object;
		
		/**
		 * @private
		 */
		private var shutdownCache:Object;
		
		/**
		 * @private
		 */
		private var shotcutCache:Object;
		
	}
}