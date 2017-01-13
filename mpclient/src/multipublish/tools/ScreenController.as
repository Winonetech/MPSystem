package multipublish.tools
{
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.ScreenUtil;
	
	import flash.events.TimerEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import multipublish.core.MPCView;
	
	import spark.components.Alert;
	import spark.components.WindowedApplication;

	public class ScreenController
	{
		public function ScreenController()
		{
			timer.addEventListener(TimerEvent.TIMER, screen_timerHandler);
			timer.start();
			
			screen_timerHandler();
		}
		
		private function screen_timerHandler(e:TimerEvent = null):void
		{
			var r:Rectangle = getDebug() ? ScreenUtil.getMainScreenBounds() : ScreenUtil.getScreensBounds();
			
			var window:WindowedApplication = view.application;
			if (window)
			{
				if (window.nativeWindow.x !=0 || window.nativeWindow.y != 0 ||
				window.x != 0 || window.y != 0 || window.width != r.width || window.height != r.height)
				{
					window.width  = window.nativeWindow.width  = r.width;
					window.height = window.nativeWindow.height = r.height;
					window.x	  = window.nativeWindow.x 	   = 0;
					window.y      = window.nativeWindow.y 	   = 0;
				}
			}
		}
		
		private function getDebug():Boolean
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication("config.ini"));
			if (file.exists)
			{
				var stream:FileStream = new FileStream;
				stream.open(file, FileMode.READ);
				try
				{
					var xml:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
					
				}
				catch (o:Error)
				{
					Alert.show("读取配置文件出错！");
				}
				stream.close();
				if (xml)
				{
					return ObjectUtil.convert(xml.debug, Boolean);
				}
			}
			return false;
		}
		
		
		/**
		 * 
		 * 视图管理。
		 * 
		 */
		
		private function get view():MPCView
		{
			return MPCView.instance;
		}
		
		private var timer:Timer = new Timer(5000);
	}
}