package multipublish.consts
{
	
	/**
	 * 
	 * 定义了一些URL常量。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class URLConsts extends NoInstance
	{
		
		
		/**
		 * 
		 * 程序主入口。
		 * 
		 */
		
		public static const APPLICATION:String = "MPClient.exe";
		
		
		/**
		 * 
		 * 升级程序。
		 * 
		 */
		
		public static const UPDATER:String = "update.exe";
		
		
		/**
		 * 
		 * led启动。
		 * 
		 */
		
		public static const LED_LAUNCH:String = "led/launchLED.exe";
		
		
		/**
		 * 
		 * led程序。
		 * 
		 */
		
		public static const LED_PATH:String = "led/LedSendNew.exe";
		
		
		/**
		 * 
		 * led数据。
		 * 
		 */
		
		public static const LED_DATA:String = "led/playbill/LED滚动字幕.bill";
		
		
		/**
		 * 
		 * 多线程绘图工具路径。
		 * 
		 */
		
		public static const DRAW_WORKER:String = "assets/tools/DrawWorker.swf";
		
		
		/**
		 * 
		 * 获取终端路径。
		 * 
		 */
		
		public static const GET_TERNIMAL_NO:String = "/wos/terminals/getAndroidlNoAction.action";
		
		
		/**
		 * 
		 * 本地配置路径。
		 * 
		 */
		
		public static const NATIVE_CONFIG:String = "config.ini";
		
		
		/**
		 * 
		 * 重启工具路径。
		 * 
		 */
		
		public static const TOOL_REBOOT:String = "assets/tools/reboot.exe";
		
		
		/**
		 * 
		 * 关机工具路径。
		 * 
		 */
		
		public static const TOOL_SHUTDOWN:String = "assets/tools/shutdown.exe";
		
		
		/**
		 * 
		 * 时间同步工具路径。
		 * 
		 */
		
		public static const TOOL_SYNC:String = "assets/tools/timesync.exe";
		
		
		/**
		 * 
		 * 设置时间工具路径。
		 * 
		 */
		
		public static const TOOL_TIME:String = "assets/tools/time.bat";
		
	}
}