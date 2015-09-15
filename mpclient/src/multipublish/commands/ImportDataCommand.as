package multipublish.commands
{
	import cn.vision.utils.FileUtil;
	
	import com.coltware.airxzip.ZipEntry;
	import com.coltware.airxzip.ZipFileReader;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	/**
	 * 
	 * 导入节目包。
	 * 
	 */
	
	
	public final class ImportDataCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ImportDataCommand</code>构造函数。
		 * 
		 */
		
		public function ImportDataCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			importData();
		}
		
		
		/**
		 * @private
		 */
		private function importData():void
		{
			var url:String = "";
			file = new File;
			file.nativePath = FileUtil.resolvePathDesktop(url);
			file.addEventListener(Event.SELECT, handlerFileSelect);
			file.addEventListener(Event.CANCEL, handlerFileCancel);
			file.browseForOpen("", [new FileFilter("Wop", "*.wop")]);
		}
		
		/**
		 * @private
		 */
		private function handlerFileSelect($e:Event):void
		{
			var reader:ZipFileReader = new ZipFileReader;
			reader.open(file);
			var entries:Array = reader.getEntries();
			for (var t:int = 0; t < entries.length; t++)
			{
				var entry:ZipEntry = entries[t] as ZipEntry;
				if(!entry.isDirectory())
				{
					try
					{
						var temp:File = new File(File.applicationDirectory.resolvePath(entry.getFilename()).nativePath);
						var stream:FileStream = new FileStream;
						stream.open(temp, FileMode.WRITE);
						stream.writeBytes(reader.unzip(entry));
						stream.close();
					}
					catch(e:Error) {}
				}
			}
			reader.close();
			
			config.importData = true;
			
			commandEnd();
		}
		
		/**
		 * @private
		 */
		private function handlerFileCancel($e:Event):void
		{
			config.importData = false;
			config.cache = false;
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private var file:File;
		
	}
}