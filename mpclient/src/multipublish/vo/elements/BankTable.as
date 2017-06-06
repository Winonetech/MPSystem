package multipublish.vo.elements
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public final class BankTable extends Element
	{
		public function BankTable($data:Object = null)
		{
			super($data);
			
			
		}
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			
		}
		
		private function initTimer():void
		{
			timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, checkUpdate_timerHandler);
			timer.start();
		}
		
		private function checkUpdate_timerHandler(e:TimerEvent):void
		{
			
		}
		
		
		private var timer:Timer;
		
	}
}