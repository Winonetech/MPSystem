package multipublish.tools
{
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.events.TimerEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Timer;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCPresenter;

	public class NativeService
	{
		public function NativeService()
		{
		}
		
		public function start():void
		{
			if (!timer)
			{
				timer = new Timer(5000);
				timer.addEventListener(TimerEvent.TIMER, handlerCommand);
				timer.start();
			}
		}
		private var lastSchedule:String;
		private function handlerCommand(event:TimerEvent):void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(DataConsts.PATH_SCHEDULE));
			if (file.exists)
			{
				var reader:FileStream = new FileStream;
				reader.open(file, FileMode.READ);
				var temp:String = reader.readUTFBytes(reader.bytesAvailable);
				if (temp && temp != lastSchedule && MPCConfig.instance.times != 1)
				{
					MPCPresenter.instance.initializeModule(null, true);
				}
				lastSchedule = temp;
				reader.close();
				reader = null;
			}
			file = null;
		}
		
		private var timer:Timer;
	}
}