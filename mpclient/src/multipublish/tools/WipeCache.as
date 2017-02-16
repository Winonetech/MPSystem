package multipublish.tools
{
	
	import com.winonetech.consts.PathConsts;
	
	import flash.filesystem.File;
	
	import multipublish.consts.ContentConsts;
	
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
			
			if (judge(file)) deleteFile(list);
		}
		
		
		/**
		 * @private
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
					fs.deleteFile();
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private static function judge(file:File):Boolean
		{
			var list:Array = file.getDirectoryListing();
			count = 0;
			return size(list) > SIZE;
		}
		
		
		/**
		 * @private
		 */
		private static function size($array:Array):Number
		{
			for each (var file:File in $array)
			{
				var fs:File = new File(file.nativePath);
				if (fs.isDirectory)
				{
					var list:Array = fs.getDirectoryListing();
					
					size(list);
				}
				else
				{
					count = count + fs.size;
				}
			}
			
			return count;
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
			var f :File = File.applicationDirectory.resolvePath(PathConsts.PATH_EPAPER);
			if (judge(file))
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
							keep = subfile.name == fs.name ? $daysKeep : ContentConsts.DAYSKEEP;
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
			result.date    -= ContentConsts.DAYSKEEP;
			return file.modificationDate < result;
		}
		
		
		/**
		 * @private
		 */
		private static const SIZE:Number = 2 * 1024 * 1024 * 1024;
		
		
		/**
		 * @private
		 */
		private static var count:Number = 0;
	}
}