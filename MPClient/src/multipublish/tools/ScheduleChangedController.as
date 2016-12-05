package multipublish.tools
{
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
			timer.addEventListener(TimerEvent.TIMER, changed_timerHandler);
			timer.start();
			
			changed_timerHandler();
		}
		
		
		private function changed_timerHandler($e:TimerEvent = null):void
		{
			if (compareSchedule())  presenter.initializeModule(null, true);
		}
		
		
		private function compareSchedule():Boolean
		{
			var file:File = File.applicationDirectory.resolvePath(DataConsts.PATH_SCHEDULE);   //排期文件.xml
			var fs:FileStream = new FileStream;
			var str:String;
			fs.open(file, FileMode.READ);
			str = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			
			if (!last)
			{
				last = str;
				return false;
			}
			
			if (last != str)
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
		private const DELAY:uint = 5;
		
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