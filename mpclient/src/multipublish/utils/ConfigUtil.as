package multipublish.utils
{
	
	
	import cn.vision.core.NoInstance;
	import cn.vision.utils.LogUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.URLConsts;
	
	public final class ConfigUtil extends NoInstance
	{
		
		/**
		 * 
		 * config文件备份。
		 * 
		 */
		
		public static function backupConfig():void
		{
			if (source.exists)
			{
				try
				{
					source.copyTo(backup, true);
				}
				catch (e:Error)
				{
					LogUtil.log(e.message);
				}
			}
			else
				LogUtil.log("config.ini文件不存在...");
		}
		
		
		/**
		 * 
		 * config文件还原。
		 * 
		 */
		
		public static function restoreConfig():void
		{
			if (backup.exists)
			{
				try
				{
					backup.copyTo(source, true);
				}
				catch (e:Error)
				{
					LogUtil.log(e.message);
				}
			}
			else
				LogUtil.log("备份文件不存在...");
		}
		
		private static var source:File = new File(File.applicationDirectory.resolvePath(URLConsts.NATIVE_CONFIG).nativePath);
		
		private static var backup:File = new File(File.applicationDirectory.resolvePath(URLConsts.BACKUP_CONFIG).nativePath);
		
	}
}