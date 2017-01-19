package multipublish.tools
{
	import cn.vision.core.VSObject;
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.SequenceQueue;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.commands.steps.FinanceUpdate;
	import multipublish.core.MPCPresenter;

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
//			queue = new SequenceQueue;
//			queue.addEventListener(QueueEvent.QUEUE_END, queueEndHandler);
			queue.execute(new FinanceUpdate);
//			presenter.initializeModule(null, true);
		}
		
		
		/**
		 * @private
		 */
		private function queueEndHandler($e:QueueEvent):void
		{
//			queue.removeEventListener(QueueEvent.QUEUE_END, queueEndHandler);
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
		private function get presenter():MPCPresenter
		{
			return MPCPresenter.instance;
		}
		
		/**
		 * @private
		 */
		private var queue:SequenceQueue = new SequenceQueue;
		
	}
}