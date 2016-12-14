package multipublish.utils
{
	import cn.vision.core.NoInstance;
	import cn.vision.system.VSFile;
	
	import com.coltware.airxzip.ZipEntry;
	import com.coltware.airxzip.ZipFileReader;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public final class ZipUtil extends NoInstance
	{
		
		/**
		 * 
		 * ZIP解压。
		 * 
		 * @param $file:VSFile 需要解压的ZIP压缩包。
		 * @param $path:String (default = null) 解压路径，默认为null，指向ZIP压缩包所在的路径。
		 * @param $charset:String (default = "utf-8") 文件名的字符集编码。
		 * 
		 */
		
		public static function unzipFile($file:VSFile, $path:String = null, $charset:String = "utf-8"):void
		{
			if ($file && $file.exists)
			{
				var reader:ZipFileReader = new ZipFileReader;
				reader.open($file);
				var entries:Array = reader.getEntries();
				if(!$path)
				{
					var join:Array = $file.nativePath.split("\\");
					join.pop();
					$path = join.join("\\") + "\\";
				}
				
				for (var t:int = 0; t < entries.length; t++)
				{
					var entry:ZipEntry = entries[t] as ZipEntry;
					if(!entry.isDirectory())
					{
						try
						{
							var fileName:String = $path + entry.getFilename($charset);
							var temp:VSFile = new VSFile(fileName);
							var stream:FileStream = new FileStream;
							stream.open(temp, FileMode.WRITE);
							stream.writeBytes(reader.unzip(entry));
							stream.close();
						}
						catch(e:Error) {}
					}
				}
				reader.close();
			}
		}
	}
}