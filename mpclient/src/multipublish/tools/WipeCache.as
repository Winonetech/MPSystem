package multipublish.tools
{
	
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.tools.Cache;
	
	import flash.filesystem.File;
	
	import multipublish.consts.ContentConsts;
	import multipublish.core.MPCConfig;
	import multipublish.utils.CacheSizeUtil;
	
	/**
	 * 
	 * 缓存清理器。
	 * 
	 */
	
	public class WipeCache
	{
		
		/**
		 * @private 
		 */
		public static function wipeNormalCache():void
		{
			var file:File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE);
			var list:Array = file.getDirectoryListing();
			var filter:Function = function($item:*, $index:int, $array:Array):Boolean
			{
				return $item.name != "epaper" && $item.name != "channel";
			};
			list = list.filter(filter, null);
			
			if (CacheSizeUtil.getSize(file) > SIZE) deleteFile(list);
		}
		
		
		/**
		 * @private
		 * 
		 * @param $array:Array 需要删除文件数组。 
		 * 
		 */
		private static function deleteFile($array:Array):void
		{
			for each (var file:File in $array)
			{
				var fs:File = new File(file.nativePath);
				if (fs.isDirectory)
				{
					var list:Array = fs.getDirectoryListing();
					
					deleteFile(list);
					
					if (list.length == 0) fs.deleteDirectory();
				}
				else if (compareDate(fs))
				{
					var arr:Array = fs.url.split(PathConsts.PATH_FILE);
					if (!Cache.used(PathConsts.PATH_FILE + arr[1]))	fs.deleteFile();
				}
			}
		}
		
		
		/**
		 * 
		 * 删除过期电子报。
		 * @param $daysKeep:uint 最大保存天数。
		 * @param $content:String 相对路径。
		 * 
		 */
		public static function wipeEpaperCache($daysKeep:uint, $content:String):void
		{
			var file:File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE);
			var fs:File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE + File.separator + $content);
			var f :File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE + File.separator + "epaper" + File.separator);
			if (CacheSizeUtil.getSize(file) > SIZE)
			{
				if (f.exists && fs.exists)
				{
					var list:Array = f.getDirectoryListing();
					
					for (var i:uint = 0; i < list.length; i++)
					{
						var keep:uint;
						var subfile:File = new File((list[i] as File).nativePath);
						if (subfile.exists && !subfile.type && subfile.isDirectory)
						{
							keep = subfile.name == fs.name ? $daysKeep : DAYSKEEP;
							deleteEPFile(keep, subfile);
						}
					}
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private static function deleteEPFile($daysKeep:uint, fs:File):void
		{
			var result:Date = new Date;
			result.date -= $daysKeep;
			var list:Array = fs.getDirectoryListing();
			for (var j:uint = 0; j < list.length; j++)
			{
				var file:File = new File((list[j] as File).nativePath);
				if (file.exists)
				{
					if (file.type) file.deleteFile();
					else
					{
						var temp:String = (file.name as String).replace(/-/g, "/");
						if (Date.parse(temp) < result.time)
						{
							if (file.isDirectory) file.deleteDirectory(true);
						}
					}
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private static function compareDate(file:File):Boolean
		{
			var result:Date = new Date;
			result.date    -= -1//DAYSKEEP;
			return file.modificationDate < result;
		}
		
		
		private static function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		/**
		 * @private
		 */
		private static const SIZE:Number = 0;//config.maxCacheKeep * 1024 * 1024 * 1024;
		
		/**
		 * @private
		 */
		private static const DAYSKEEP:uint = config.maxCachedaysKeep;
	}
}