package multipublish.consts
{
	/**
	 * 
	 * 定义日志事件类型。
	 * 
	 */
	
	public final class EventConsts
	{
		
		//--------------------------------------------------------------
		//
		// 播放明细报表。
		//
		//--------------------------------------------------------------
		
		
		/**
		 * 
		 * 开始播放。
		 * 
		 */
		
		public static var EVENT_START_PLAYING:String = "STARTPLAYING";
		
		
		/**
		 * 
		 * 加载出错。
		 * 
		 */
		
		public static var EVENT_LOAD_ERROR:String = "LOAD_ERROR";
		
		
		//--------------------------------------------------------------
		//
		// 终端素材报表。
		//
		//--------------------------------------------------------------
		
		
		/**
		 * 
		 * 开始下载。
		 * 
		 */
		
		public static var EVENT_DOWNLOADING_START:String = "STARTDOWNLOADING";
		
		
		/**
		 * 
		 * 结束下载。
		 * 
		 */
		
		public static var EVENT_DOWNLOADING_END:String = "ENDDOWNLOADING";
		
		
		//--------------------------------------------------------------
		//
		// 终端状态报表。
		//
		//--------------------------------------------------------------
		
		
		/**
		 * 
		 * 关闭终端。
		 * 
		 */
		
		public static var EVENT_PC_SHUTDOWN:String = "PCSHUTDOWN";
		
		
		/**
		 * 
		 * 重启终端。
		 * 
		 */
		
		public static var EVENT_PC_REBOOT:String = "PCREBOOT";
		
		
		/**
		 * 
		 * 重启播放器。
		 * 
		 */
		
		public static var EVENT_PLAYER_START:String = "PLAYERSTART";
		
		
		/**
		 * 
		 * 更新排期。
		 * 
		 */
		
		public static var EVENT_UPDATE_SCHEDULE:String = "UPDATESCHEDULE";
		
		
		/**
		 * 
		 * 截屏。
		 * 
		 */
		
		public static var EVENT_TAKE_SCREENSHOT:String = "TAKESCREENSHOT";
		
		
		/**
		 * 
		 * 日志上传。
		 * 
		 */
		
		public static var EVENT_UPLOAD_LOG:String= "UPLOADLOG";
		
		
		/**
		 * 
		 * 日志上传完毕。
		 * 
		 */
		
		public static var EVENT_LOG_UPLOADED:String = "LOGUPLOADED";
		
		
		/**
		 * 
		 * 时间同步。
		 * 
		 */
		
		public static var EVENT_SYNC_SERVER_TIME:String= "SYNSERVERTIME";
		
		
		/**
		 * 
		 * 调整音量。
		 * 
		 */
		
		public static var EVENT_ADJUST_VOL:String= "ADJUSTVOLUME";
		
	}
}