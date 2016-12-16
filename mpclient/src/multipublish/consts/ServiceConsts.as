package multipublish.consts
{
	
	/**
	 * 
	 * 定义所有的终端指令常量。
	 * 
	 */
	
	import cn.vision.core.NoInstance;
	
	
	public final class ServiceConsts extends NoInstance
	{
		
		/**
		 * 
		 * 排期推送。<br>
		 * 默认值为“UPSC:”。
		 * 
		 */
		
		public static const RECEIVE_SCEDULE:String = "UPSC:";
		
		
		
		
		
		/**
		 * 
		 * 发送LED显示内容。<br>
		 * 默认值为“SLED:”。
		 * 
		 */
		
		public static const RECEIVE_LEDTEXT:String = "SLED:";
		
		
		/**
		 * 
		 * 接收、发送LED显示内容。<br>
		 * 默认值为“CLED:”。
		 * 
		 */
		
		public static const CONTROL_LED:String = "CLED:";
		
		
		/**
		 * 
		 * 节目推送。<br>
		 * 默认值为“UPSC:”。
		 * 
		 */
		
		public static const RECEIVE_PROGRAM:String = "UPPR:";
		
		
		/**
		 * 
		 * 终端上线。
		 * 默认值为“ONLI:”。
		 * 
		 */
		
		public static const FORWARD_ON_LINE:String = "ONLI:";
		
		
		/**
		 * 
		 * 终端离线。
		 * 默认值为“ONLI:”。
		 * 
		 */
		
		public static const FORWARD_OFF_LINE:String = "OFLI:";
		
		
		/**
		 * 
		 * 文件下载上报。
		 * 默认值为“FTPS:”。
		 * 
		 */
		
		public static const FILE_DOWNLOAD:String = "FTPS:";
		
		
		
		/**
		 * 
		 * 获取电子报。
		 * 默认值为“REEP:”。
		 * 
		 */
		
		public static const EPAPER_DOWNLOAD:String = "REEP:";
		
		
		/**
		 * 
		 * 上传日志。
		 * 默认值为“UPLG:”。
		 * 
		 */
		
		public static const UPLOAD_LOG:String = "UPLG:";
		
		
		/**
		 * 
		 * 上传报表。
		 * 默认值为“UPRT:”。
		 * 
		 */
		
		public static const UPLOAD_REPORT:String = "UPRT:";
		
		
		/**
		 * 
		 * 文件下载进度上报。
		 * 默认值为“PRGS:”。
		 * 
		 */
		
		public static const FILE_PROGRESS:String = "PRGS:";
		
		
		/**
		 * 
		 * 接受开始文件下载进度上报。
		 * 默认值为“DLPS:”。
		 * 
		 */
		
		public static const REPORT_FILE_START:String = "DLPS:";
		
		
		/**
		 * 
		 * 接受结束文件下载进度上报。
		 * 默认值为“DLPT:”。
		 * 
		 */
		
		public static const REPORT_FILE_END:String = "DLPT:";
		
		
		/**
		 * 
		 * 终端心跳。<br>
		 * 默认值为“HRBT:”。
		 * 
		 */
		
		public static const FORWARD_HEART_BEAT:String = "HRBT:";
		
		
		/**
		 * 
		 * 重启终端。<br>
		 * 默认值为“REBO:”。
		 * 
		 */
		
		public static const REBOOT_TERMINAL:String = "REBO:";
		
		
		/**
		 * 
		 * 重启播放器。<br>
		 * 默认值为“UIRE:”。
		 * 
		 */
		
		public static const RESTART_PLAYER:String = "UIRE:";
		
		
		/**
		 * 
		 * 声音设置。<br>
		 * 默认值为“VOLU:”。
		 * 
		 */
		
		public static const REGULATE_VOL:String = "VOLU:";
		
		
		/**
		 * 
		 * 设定关机时间。<br>
		 * 默认值为“SHDO:”。
		 * 
		 */
		
		public static const SET_SHUTDOWN_TIME:String = "SHDO:";
		
		
		/**
		 * 
		 * 收到截图。<br>
		 * 默认值为“SCRN:”。
		 * 
		 */
		
		public static const RECEIVE_SHOTCUT:String = "SCRN:";
		
		
		/**
		 * 
		 * 发送截图。<br>
		 * 默认值为“CAPT:”。
		 * 
		 */
		
		public static const SEND_SHOTCUT:String = "CAPT:";
		
		/**
		 * 
		 * 时间同步。<br>
		 * 默认值为“SYTI:”。
		 * 
		 */
		
		public static const LOCK_TIME:String = "SYTI:";
		
		
		/**
		 * 
		 * 下载申请。<br>
		 * 默认值为“DLRS:”。
		 * 
		 */		
		
		public static const DL_APPLY:String = "DLRS:";

		
		
		/**
		 * 
		 * 下载结束。<br>
		 * 默认值为“DLOV:”。
		 * 
		 */		
		
		public static const DL_OVER:String = "DLOV:";
		
		
		/**
		 * 
		 * 下载状态回馈。<br>
		 * 默认值为“DLIF:”。
		 * 
		 */		
		
		public static const DOWNLOAD_STATE:String = "DLIF:";
		
	}
}