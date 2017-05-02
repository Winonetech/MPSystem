package multipublish.tools
{
	import cn.vision.core.VSObject;
	import cn.vision.queue.SequenceQueue;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.commands.steps.FinanceUpdate;

	public final class FinanceDataUdtController extends VSObject
	{
		public function FinanceDataUdtController()
		{
			timer.addEventListener(TimerEvent.TIMER, updata_timerHandler);
			timer.start();

			updata_timerHandler();
		}
		
		
		private function updata_timerHandler($e:TimerEvent = null):void
		{
			queue.execute(new FinanceUpdate);
		}
		
		
		/**
		 * @private
		 */
		private const DELAY:uint = 30;
		
		/**
		 * @private
		 */
		private var timer:Timer = new Timer(DELAY * 1000);
		
		/**
		 * @private
		 */
		private var queue:SequenceQueue = new SequenceQueue;
		
	}
}