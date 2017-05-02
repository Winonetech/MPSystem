package multipublish.commands
{
	
	/**
	 * 
	 * 导出节目包。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.events.QueueEvent;
	import cn.vision.queue.ParallelQueue;
	import cn.vision.utils.FileUtil;
	
	import com.coltware.airxzip.ZipFileWriter;
	import com.winonetech.components.progress.ProgressView;
	import com.winonetech.tools.Cache;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class ExportDataCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ExportDataCommand</code>构造函数。
		 * 
		 */
		
		public function ExportDataCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			exportData();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function exportData():void
		{
			var schedules:Map = store.retrieveMap(Schedule);
			if (schedules && schedules.length)
			{
				view.guild.onExport = makeOfflinePackage;
				queue.executing
					? waitForDownloadComplete()
					: makeOfflinePackage();
			}
			else
			{
				config.state = ClientStateConsts.BROD_NOPR;
			}
		}
		
		/**
		 * @private
		 */
		private function waitForDownloadComplete():void
		{
			queue.addEventListener(QueueEvent.QUEUE_END, handlerQueueEnd);
			view.application.removeElement(view.guild);
			view.application.addElement(view.progress = new ProgressView);
			view.progress.data = Cache.caches;
			view.progress.play();
		}
		
		/**
		 * @private
		 */
		private function makeOfflinePackage():void
		{
			config.state = ClientStateConsts.EXPORT_DATA;
			var date:Date = new Date;
			var url:String = "Program Package_" + date.fullYear + "-" + (date.month + 1) + "-" + date.date + ".wop";
			file = new File;
			file.nativePath = FileUtil.resolvePathDesktop(url);
			file.addEventListener(Event.SELECT, handlerFileSelect);
			file.addEventListener(Event.CANCEL, handlerFileCancel);
			file.browseForSave("保存wop文件包");
		}
		
		/**
		 * @private
		 */
		private function addFile($file:File, writer:ZipFileWriter, dir:String = ""):void
		{
			var dir:String = (dir == "") ? dir : dir + "/";
			if ($file.isDirectory)
			{
				writer.addDirectory(dir + $file.name);
				var arr:Array = $file.getDirectoryListing();
				for each (var temp:File in arr)
				{
					addFile(temp, writer, dir + $file.name);
				}
			}
			else
			{
				if (Cache.used(dir + $file.name))
					writer.addFile($file, dir + $file.name);
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerQueueEnd($e:QueueEvent):void
		{
			queue.removeEventListener(QueueEvent.QUEUE_END, handlerQueueEnd);
			view.application.removeElement(view.progress);
			view.application.addElement(view.guild);
			view.progress = null;
			makeOfflinePackage();
		}
		
		/**
		 * @private
		 */
		private function handlerFileSelect($e:Event):void
		{
			var s:String = file.nativePath;
			file.nativePath = (s.substr(-4) == ".wop") ? s : (s + ".wop");
			var writer:ZipFileWriter = new ZipFileWriter;
			writer.open(file);
			var temp:File = File.applicationDirectory.resolvePath("cache");
			addFile(temp, writer);
			writer.close();
		}
		
		/**
		 * @private
		 */
		private function handlerFileCancel($e:Event):void
		{
			file = null;
			view.guild.onExport = makeOfflinePackage;
		}
		
		
		/**
		 * @private
		 */
		private function get queue():ParallelQueue
		{
			return Cache.queue;
		}
		
		
		/**
		 * @private
		 */
		private var file:File;
		
	}
}