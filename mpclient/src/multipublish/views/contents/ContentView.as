package multipublish.views.contents
{
	
	/**
	 * 
	 * 内容视图基类。
	 * 
	 */
	
	
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.views.MPView;
	import multipublish.vo.contents.Content;
	
	
	public class ContentView extends MPView
	{
		
		/**
		 * 
		 * <code>ContentViev</code>构造函数。
		 * 
		 */
		
		public function ContentView()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
//			LogSQLite.log(
//				TypeConsts.FILE,
//				EventConsts.EVENT_START_PLAYING,
//				content.content.split("/").pop(),
//				log(MPTipConsts.RECORD_CONTENT_PLAY, content));
			
			if(!timer && content.duration)
			{
				timer = new Timer(1000, content.duration);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
				timer.start();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
				timer = null;
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			content = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			content = data as Content;
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			stop();
		}
		
		
		/**
		 * @private
		 */
		[Bindable]
		protected var content:Content;
		
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
	}
}