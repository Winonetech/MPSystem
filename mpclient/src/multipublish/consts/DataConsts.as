package multipublish.consts
{
	
	/**
	 * 
	 * 定义了一些缓存路径。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class DataConsts extends NoInstance
	{
		
		/**
		 * 
		 * 文件夹缓存路径。
		 * 
		 */
		
		public static const PATH_FOLDER:String = "cache/folder/folder";
		
		
		/**
		 * 
		 * 节目缓存路径。
		 * 
		 */
		
		public static const PATH_PROGRAM:String = "cache/program/program";
		
		
		/**
		 * 
		 * 排期缓存路径。
		 * 
		 */
		
		public static const PATH_SCHEDULE:String = "cache/schedule/schedule.xml";
		
		
		/**
		 * 
		 * 排版缓存路径。
		 * 
		 */
		
		public static const PATH_TYPESET:String = "cache/typeset/typeset";
		
		/**
		 * 
		 * 存放当前在播节目。 
		 * 
		 */
		
		public static const CURR_PROG:String = "current/current_program.xml";
		
		
		/**
		 * 
		 * 播放日志记录。 
		 * 
		 */
		
		public static const PROG_LOG:String = "current/playlog/playlog_";
		
		
		/**
		 * 
		 * 暂停 恢复记录。 
		 * 
		 */
		
		public static const PAUSE_CFG:String = "current/pause.config";
		
		
	}
}