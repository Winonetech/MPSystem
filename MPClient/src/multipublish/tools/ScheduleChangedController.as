package multipublish.tools
{
	import cn.vision.utils.FileUtil;
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Timer;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCPresenter;

	public class ScheduleChangedController
	{
		public function ScheduleChangedController()
		{
			execute();
		}
		
		private function execute():void
		{
			if (!config.isCommunicate && timer && !timer.running) 
			{
				timer.addEventListener(TimerEvent.TIMER, changed_timerHandler);
				timer.start();
				
				changed_timerHandler();
			}
		}
		
		private function changed_timerHandler($e:TimerEvent = null):void
		{
			if (!config.isCommunicate && compareSchedule())  presenter.initializeModule(null, true);
		}
		
		private function compareSchedule():Boolean
		{
			var str:String = FileUtil.readUTF(FileUtil.resolvePathApplication(DataConsts.PATH_SCHEDULE));
			
			if (!last)
			{
				last = str;
				return false;
			}
			else if (last != str)
			{
				last = str;
				return true;
			}
			
			return false;
			
		}
		
		
		/**
		 * @private
		 */
		private var last:String;
		
		/**
		 * @private
		 */
		private const DELAY:uint = config.scheduleGap || 1;
		
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
		private function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
	}
}