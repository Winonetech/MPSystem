package multipublish.utils
{
	
	/**
	 * 
	 * 获取cache文件夹大小。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	import flash.filesystem.File;
	
	public final class CacheSizeUtil extends NoInstance
	{
		
		public static function getSize(file:File):Number
		{
			var count:Number = 0.0;
			if (file.isDirectory)
			{
				var list:Array = file.getDirectoryListing();
				for each (var f:File in list)
				{
					count += getSize(f);
				}
			}
			else
			{
				count += file.size;
			}
			
			return count;
		}
	}
}