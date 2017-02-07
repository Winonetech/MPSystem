package multipublish.vo.contents
{
	
	/**
	 * 
	 * 电子报格式。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.pattern.queue.SequenceQueue;
	import cn.vision.system.VSFile;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.core.mp;
	import multipublish.tools.ImageCompare;
	import multipublish.utils.EPaperUtil;
	import multipublish.utils.URLUtil;
	
	
	use namespace wt;
	
	
	[Bindable]
	public final class EPaper extends ResolveContent
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function EPaper(
			$data:Object = null, 
			$name:String = "epaper", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			//css
			getCss();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function update(...$args):void    //每秒监测。
		{
			var time:String = ObjectUtil.convert(new Date, String, "HH:MI:SS");
			if (!isNaN(Number($args[1]))) daysKeep = uint($args[1]);
			else useCache = true;
			if (time == getPaperTime || $args[0]) updateContents();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveContentSource($content:*):void
		{
			updateContents();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override wt function registCache(...$args):void
		{
			var l:uint = $args ? $args.length : 0;
			for (var i:int = 0; i < l; i++)
			{
				var item:* = $args[i];    //item存储下载的地址。
				var saveURL:String = CacheUtil.extractURI(item, PathConsts.PATH_FILE);   //电子书压缩包相对路径。
				var fzip:String = FileUtil.resolvePathApplication(saveURL);    //保存电子书压缩包的绝对路径。
				var path:String = EPaperUtil.mp::getPathByZipFile(fzip);     //解压路径。
				
				var file:VSFile = new VSFile(fzip);    //电子报压缩包文件。
				ArrayUtil.push(days, path);
				
				if(!EPaperUtil.mp::getDayInited(path))
				{
					LogUtil.log(title + "：未解析完毕，" + fzip);
					if (file.exists)     //存在则解压缩。
					{
						LogUtil.log(title + "：报纸压缩包存在，解压缩文件。");
						try
						{
							var errors:Array = EPaperUtil.mp::unzipFile(file, path);
						}
						catch (e:Error)
						{
							LogUtil.log(title + "：解压报纸文件出错，文件已损坏，路径：" + fzip);
						}
						if (errors)
						{
							LogUtil.log(title + "：解压以下文件出错，文件已损坏：\n");
							for each (var error:String in errors) LogUtil.log("\t" + error + "\n");
						}
					}
					else      //不存在则开始下载。
					{
						LogUtil.log(title + "：报纸压缩包不存在，" + fzip);
						
						if (EPaperUtil.mp::checkArchiveUnloadable(saveURL))
						{
							LogUtil.log(title + "：报纸文件在服务器上不存在，" + fzip);
						}
						else
						{
//							var date:String  = ObjectUtil.convert(new Date, String, "YYYY-MM-DD");
//							var temp:String  = saveURL.split("/").pop();
//							var save:String  = temp.split(".")[0];
//							var bool:Boolean = save == date;
							var cache:Cache = (item is String) ? Cache.cache(item, !useWait, cacheGroup) : item;   //Cache主要存放一些下载路径和安装路径。
							
//							if (bool) 
//							{
//								cache.extra = cache.extra || {};
//								cache.extra.response = (i == 0);
//								cache.addEventListener(CommandEvent.COMMAND_END, handler_spCacheEnd);
//							}
							if (!cach[cache.saveURL])
							{
								cache.extra = cache.extra || {};
								cache.extra.response = (i == 0);
								cache.addEventListener(CommandEvent.COMMAND_END, cache_endHandler);
								cach[cache.saveURL] = cache;
							}
						}
					}
				}
				else
				{
					LogUtil.log(title + "：已解析完毕：" + fzip);
					if (file.exists) file.deleteFile();
				}
			}
			
		}
		
		
		/**
		 * @private
		 */
		private function getCss():void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication("css.ini"));
			if (file.exists)
			{
				var stream:FileStream = new FileStream;
				stream.open(file, FileMode.READ);
				var temp:String = stream.readUTFBytes(stream.bytesAvailable);
				var obj:Object = ObjectUtil.convert(temp, Object);
				style = obj ? obj.epaper : null;
				stream.close();
			}
		}
		
		/**
		 * @private
		 */
		private function updateContents():void
		{
			LogUtil.log(title + "：获取报纸数据", content);
			tip = {};
			tip.title = "提示";
			tip.message = title + "：正在加载处理报纸，请稍后...";
			
			resolved = false;
			days.length = papers.length = 0;
			images.clear();
			retrys.clear();
			reslvd = {};
			
			//获取从当天开始，往前 daysKeep天的报纸
			var date:Date = new Date;
			var urls:Array = [];        //根据daysKeep得到的需要天数的报纸。存放的是 FTP的地址。
			var pre:String = URLUtil.buildFTPURL(content);
			if (pre.substr(-1) != "/") url += "/";
			for (var i:int = 0; i < daysKeep; i++)
			{
				var url:String = pre + ObjectUtil.convert(date, String, "YYYY-MM-DD") + ".zip";
				ArrayUtil.push(urls, url);
				date.date -= 1;
			}
			
			wt::registCache.apply(this, urls);
			//如果没有需要下载的报纸文件，开始解析报纸数据。
			
			if (cach.length == 0) 
			{
				LogUtil.log(title + "：更新报纸信息，解析数据");
				resolveData();
			}
			else
			{
				LogUtil.log(title + "：更新报纸信息，需要下载文件", cach.length);
			}
			
			TimerUtil.callLater(1, dispatchInit);
			
			TimerUtil.callLater(2, dispatchReady);
		}
		
		/**
		 * @private
		 */
		private function resolveData():void
		{
			LogUtil.log(title + "：解析报纸数据内容");
			var keyDay:String, pathSheet:String, dataSheet:String, readable:Boolean = true;
			var objDay:Object, objSheet:Object, fileSheets:Array, fileItems:Array, arr:Array;
			var fileDay:VSFile, fileSheet:File,fileItem:File, stream:FileStream, fzip:VSFile, path:String;
			//遍历每一天的报纸
			for each (keyDay in days)	
			{
				if (!reslvd[keyDay])
				{
					fileDay = new VSFile(keyDay);
					
					if (EPaperUtil.mp::getDayInited(keyDay))
					{
						fzip = new VSFile(keyDay.substr(0, keyDay.length - 1) + ".zip");
						if (fzip.exists) fzip.deleteFile();
					}
					
					if (fileDay.exists && fileDay.isDirectory)
					{
						reslvd[keyDay] = true;
						arr = keyDay.split("/");
						papers.push(objDay = {
							"path" : keyDay.substr(FileUtil.resolvePathApplication("").length + 1),
							"zip"  : keyDay.substr(0, keyDay.length - 1) + ".zip",
							"date" : arr[arr.length - 2], "sheets" : []
						});
						fileSheets = fileDay.getDirectoryListing();
						//遍历每个版面
						for each (fileSheet in fileSheets)
						{
							if (fileSheet.isDirectory)
							{
								fileItems = fileSheet.getDirectoryListing();
								
								objDay.sheets.push(objSheet = {
									"path" : objDay.path + fileSheet.name + "/",
									"label" : fileSheet.name
								});
								
								pathSheet = objSheet.path;
								if (!images[pathSheet]) images[pathSheet] = {"sheet":objSheet, "images":[]};
								
								//分析版面文件夹下的每个文件，如果是XML，则解析XML数据
								for each (fileItem in fileItems)
								{
									switch (fileItem.extension)
									{
										case "jpg":
										case "jpeg":
										case "png":
											//如果是图片，将图片路径加入图片数组
											ArrayUtil.push(images[pathSheet]["images"], objSheet.path + fileItem.name);
											break;
										case "xml":
											//如果是XML，则解析XML数据
											stream = new FileStream;
											stream.open(fileItem, FileMode.READ);
											dataSheet = stream.readUTFBytes(stream.bytesAvailable);
											dataSheet = EPaperUtil.mp::replaceChi2Eng(dataSheet);
											try
											{
												objSheet.source = XML(dataSheet);
											}
											catch(o:Error)
											{
												LogUtil.log(title + "：解析报纸版面数据出错，可能数据格式不正确，或数据已加密，无法解析。", pathSheet);
											}
											stream.close();
											break;
									}
								}
								readable = false;
								//解析图片数组
								analizeImages(images[pathSheet]);
							}
						}
						objDay.sheets.sort(EPaperUtil.mp::sheetSortFunction);
					}
				}
			}
			papers.sort(EPaperUtil.mp::paperSortFunction);
			papers = papers.reverse();
			
			if (readable)
			{
				LogUtil.log(title + "：报纸处理完毕，没有报纸数据");
				resolved = true;
				dispatchReady();
			}
		}
		
		/**
		 * @private
		 */
		private function analizeImages(imageObj:Object):void
		{
			LogUtil.log(title + "：解析报纸版面图片", imageObj.sheet.path);
			var compare:ImageCompare = new ImageCompare(imageObj);
			var compareHandler:Function = function(e:CommandEvent):void
			{
				var compare:ImageCompare = e.command as ImageCompare;
				compare.removeEventListener(CommandEvent.COMMAND_END, compareHandler);
				delete images[compare.path];
				
				LogUtil.log(title + "：报纸图片已处理，剩余：" + images.length, compare.path);
				dispatchEvent(new ControlEvent(ControlEvent.PROGRESS, "处理报纸图片中，剩余：" + images.length));
				
				if(!images.length)
				{
					LogUtil.log(title + "：处理报纸图片完毕");
					resolved = true;
					dispatchEvent(new ControlEvent(ControlEvent.READY));
				}
			};
			compare.addEventListener(CommandEvent.COMMAND_END, compareHandler);
			queue.execute(compare);
		}
		
		
		/**
		 * @private
		 */
		private function cache_endHandler($e:CommandEvent):void
		{
			var cache:Cache = $e.command as Cache;
			const exist:Boolean = cache.exist;
			const fzip:String = FileUtil.resolvePathApplication(cache.saveURL);
			
			if (exist)
			{
				LogUtil.log(title + "：下载文件成功", cache.saveURL, "剩余下载：" + (cach.length - 1 + retrys.length));
				
				delete retrys[cache.saveURL];
				cache.removeEventListener(CommandEvent.COMMAND_END, cache_endHandler);
				var toSeparator:String = fzip.split("\\").join("/");
				var typePointIndex:int = toSeparator.lastIndexOf(".");
				var errors:Array = EPaperUtil.mp::unzipFile(new VSFile(fzip), toSeparator.slice(0, typePointIndex) + "/");
				if (errors)
				{
					LogUtil.log(title + "：解压以下文件出错，文件已损坏：\n");
					for each (var error:String in errors) LogUtil.log("\t" + error + "\n");
				}
			}
			else
			{
				if (cache.code == "550")
				{
					LogUtil.log(title + "：下载文件失败", cache.saveURL, "文件不存在。");
					EPaperUtil.mp::flagArchiveUnloadable(cache.saveURL);
					cache.removeEventListener(CommandEvent.COMMAND_END, cache_endHandler);
				}
				else
				{
					if (cach[cache.saveURL])
					{
						LogUtil.log(title + "：下载文件中断", cache.saveURL, "稍后重新下载。");
						retrys[cache.saveURL] = cache;
					}
				}
			}
			
			delete cach[cache.saveURL];
			
			if (cach.length == 0) resolveData();
		}
		
		
		/**
		 * 
		 * 具体内容。
		 * 
		 */
		
		public function get daysKeep():uint
		{
			return useCache ? getProperty("daysKeep", uint) : (mp::daysKeep);
		}
		
		/**
		 * @private
		 */
		public function set daysKeep($value:uint):void
		{
			useCache = false;
			mp::daysKeep = $value;
		}
		
		
		/**
		 * 
		 * 顶点更新时间。
		 * 
		 */
		
		public function get getPaperTime():String
		{
			return getProperty("renewalPaperTime");
		}
		
		
		/**
		 * 
		 * 具体内容。
		 * 相对地址路径。
		 * 
		 */
		
		public function get content():String
		{
			return getProperty("contentSource");
		}
		
		
		/**
		 * 
		 * 样式。
		 * 
		 */
		
		public var style:Object;
		
		
		/**
		 * 
		 * 报纸子集。
		 * 
		 */
		
		public var papers:Array = [];
		
		
		/**
		 * 保存电子报文件夹的绝对路径。
		 */
		private var days:Array = [];
		
		/**
		 * @private
		 */
		private var images:Map = new Map;
		
		/**
		 * @private
		 */
		private var useCache:Boolean = true;
		
		/**
		 * 重新下载的存放。
		 */
		private var retrys:Map = new Map;
		
		/**
		 * 是否已被解析。
		 */
		private var reslvd:Object = {};
		
		
		/**
		 * @private
		 */
		mp var daysKeep:uint;
		
		
		/**
		 * @private
		 */
		private static const queue:SequenceQueue = new SequenceQueue;
		
	}
}
