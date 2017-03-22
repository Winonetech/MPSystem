package multipublish.utils
{
	import multipublish.core.MPCConfig;

	public class URLUtil
	{
		public static function buildFTP($path:String):String
		{
			if ($path)
			{
				$path.replace("\\", "/");
				if ($path.indexOf("ftp://") == -1)
				{
					if ($path.charAt(0) == "/") $path = $path.substr(1);
					var result:String = "ftp://" + config.ftpUserName + ":" + config.ftpPassWord + "@" + config.ftpHost + ":" + config.ftpPort + "/" + $path;
				}
				else
				{
					result = $path;
				}
			}
			return result;
			
		}
		
		private static var config:MPCConfig = MPCConfig.instance;
	}
}