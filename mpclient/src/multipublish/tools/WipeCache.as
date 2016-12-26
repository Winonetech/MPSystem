package multipublish.tools
{
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.FileUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.tools.Cache;
	
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.ContentConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.URLConsts;
	import multipublish.core.MDProvider;
	import multipublish.vo.contents.EPaper;
	
	import org.gestouch.core.gestouch_internal;

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
				return $item.name != "epaper" && $item.name != "channel" && $item.name != "website";
			};
			list = list.filter(filter, null);
			
			deleteFile(list);
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
			var fs:File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE + File.separator + $content);
			if (!fs.exists) return;
			var list:Array = fs.getDirectoryListing();
			var result:Date = new Date;
			result.date -= 4;
			for (var j:uint = 0; j < list.length; j++)
			{
				var file:File = new File((list[j] as File).nativePath);
				var temp:String = (file.name.split(".").shift() as String).replace(/-/g, "/");
				if (Date.parse(temp) < result.time)
				{
					if (file.exists && file.isDirectory) file.deleteDirectory(true);
				}
			}
		}
		
		
		/**
		 * 
		 * 删除过期静态站点。
		 * 
		 */
		public static function wipeHTMLWebCache():void
		{
			var fs:File = File.applicationDirectory.resolvePath(PathConsts.PATH_FILE + File.separator + "website");
			var list:Array = fs.getDirectoryListing();
			for each (var item:File in list)
			{
				var url:String = fs.url + File.separator + item.name + ".zip";
				if (!Cache.used(url)) deleteHTMLFile(item);
			}
		}
		
		
		/**
		 * @private
		 */
		private static function deleteHTMLFile(file:File):void
		{
			if (file.exists)
			{
				var fs:File = new File(file.nativePath);
				if (compareDate(fs)) fs.deleteDirectory(true);
			}
			
			
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
		private static function compareDate(file:File):Boolean
		{
			var result:Date = new Date;
			result.date    -= ContentConsts.DAYSKEEP;
			return file.modificationDate < result;
		}
	}
}