package multipublish.utils
{
	import multipublish.core.MPCConfig;

	public class URLUtil
	{
		
		/**
		 * 
		 * 构建FTP URL。
		 * 
		 */
		
		public static function buildFTPURL($path:String):String
		{
			if ($path)
			{
				$path.replace("\\", "/");
				if ($path.indexOf("ftp://") == -1)
				{
					var result:String = "ftp://" + config.ftpUserName + ":" + config.ftpPassWord + "@" + config.ftpHost + ":" + config.ftpPort + "/" + $path;
				}
				else
				{
					result = $path;
				}
			}
			return result;
		}
		
		
		/**
		 * @private
		 */
		
		private static var config:MPCConfig = MPCConfig.instance;
		
	}
}