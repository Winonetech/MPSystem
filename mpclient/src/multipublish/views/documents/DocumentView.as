package multipublish.views.documents
{
	
	/**
	 * 
	 * 文件视图基类。
	 * 
	 */
	
	
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.core.mp;
	import multipublish.views.MPView;
	import multipublish.vo.documents.Document;
	
	
	[Event(name="ready", type="com.winonetech.events.ControlEvent")]
	
	
	public class DocumentView extends MPView
	{
		
		/**
		 * 
		 * <code>DocumentView</code>构造函数。
		 * 
		 */
		
		public function DocumentView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			LogSQLite.log(
				TypeConsts.FILE,
				EventConsts.EVENT_START_PLAYING,
				media.path.split("/").pop(),
				log(MPTipConsts.RECORD_DOCUMENT_PLAY, media));
			
			timer.start();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			media = null;
		}
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			timer.reset();
			timer.stop();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			media = data as Document;
		}
		
		
		/**
		 * 
		 * 定时器结束时回调。
		 * 
		 */
		
		protected function completeTime():void
		{
			stop();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			completeTime();
		}
		
		
		/**
		 * 
		 * 文件播放时间。
		 * 
		 */
		
		public function get time():uint
		{
			return timer.repeatCount;
		}
		
		/**
		 * @private
		 */
		public function set time($value:uint):void
		{
			if ($value > config.maxDurationTime) $value = config.maxDurationTime;
			if ($value!= time) timer.repeatCount = $value;
		}
		
		
		/**
		 * 
		 * 是否自动循环。
		 * 
		 */
		
		[Bindable]
		public var loop:Boolean;
		
		
		/**
		 * @private
		 */
		[Bindable]
		protected var media:Document;
		
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		
		/**
		 * @private
		 */
		mp var time:Number = 0;
		
	}
}