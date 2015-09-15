package multipublish.consts
{
	
	/**
	 * 
	 * FileURLType定义了常用相对路径的uint值，与FileSaver结合使用，包含：<br>
	 * 值为0，代表应用程序路径；<br>
	 * 值为1，代表应用程序存储路径；<br>
	 * 值为2，代表桌面路径；<br>
	 * 值为3，代表缓存路径；<br>
	 * 值为3，代表文档路径；<br>
	 * 值为4，代表用户路径；<br>
	 * 值为5，代表绝对路径。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class FileURLType extends NoInstance
	{
		
		/**
		 * 
		 * 绝对路径类型。
		 * 
		 */
		
		public static const ABSOLUTE:uint = 6;
		
		
		/**
		 * 
		 * 应用程序目录。
		 * 
		 * @see flash.filesystem.File.applicationDirectory
		 * 
		 */
		
		public static const APPLICATION:uint = 0;
		
		
		/**
		 * 
		 * 应用程序存储目录。
		 * 
		 * @see flash.filesystem.File.applicationStorageDirectory
		 * 
		 */
		
		public static const APPLICATION_STORAGE:uint = 1;
		
		
		/**
		 * 
		 * 缓存目录。
		 * 
		 * @see flash.filesystem.File.cacheDirectory
		 * 
		 */
		
		public static const CACHE:uint = 2;
		
		
		/**
		 * 
		 * 桌面目录。
		 * 
		 * @see flash.filesystem.File.desktopDirectory
		 * 
		 */
		
		public static const DESKTOP:uint = 3;
		
		
		/**
		 * 
		 * 文档目录。
		 * 
		 * @see flash.filesystem.File.documentsDirectory
		 * 
		 */
		
		public static const DOCUMENTS:uint = 4;
		
		
		/**
		 * 
		 * 用户目录。
		 * 
		 * @see flash.filesystem.File.userDirectory
		 * 
		 */
		
		public static const USER:uint = 5;
		
	}
}