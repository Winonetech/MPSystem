package multipublish.vo.contents
{
	
	/**
	 * 
	 * 网页内容。
	 * 
	 */
	
	
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.HTTPUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.TimerUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.coltware.airxzip.ZipEntry;
	import com.coltware.airxzip.ZipFileReader;
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	import com.winonetech.utils.ConvertUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import multipublish.core.mp;
	import multipublish.utils.EPaperUtil;
	
	use namespace wt; 
	
	public final class HTMLWeb extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function HTMLWeb(
			$data:Object = null, 
			$name:String = "html", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function customParse():void
		{
			if (htmlType)
			{
				if (htmlType == "url")
					content = HTTPUtil.normalize(getProperty("contentSource"));
				else if (htmlType == "local")
				{
					homePath = "index.html";     //设置首页。
					parseLocal();
				}
				else
				{
					LogUtil.log("htmlType字段赋值错误。可能的值为:'local' & 'url'");
				}
			}
			else
			{
				LogUtil.log("htmlType字段不存在，默认视为动态网页。");
				content = HTTPUtil.normalize(getProperty("contentSource"));    //适应老系统。
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override wt function registCache(...$args):void
		{
			if ($args.length == 0) return;
			var saveURL  :String = CacheUtil.extractURI($args[0], PathConsts.PATH_FILE);   //保存的相对路径。
			var zipPath  :String = FileUtil.resolvePathApplication(saveURL);			  //文件绝对路径。
			var unZipPath:String = EPaperUtil.mp::getPathByZipFile(zipPath); 		     //解压路径。
			var file:VSFile = new VSFile(zipPath);
			if (file.exists)
			{
				LogUtil.log(title + "：网页文件压缩包存在，解压缩文件。");
				try
				{
					var errors:Array = EPaperUtil.mp::unzipFile(file, unZipPath);
				}
				catch (e:Error)
				{
					LogUtil.log(title + "：解压网页文件出错，文件已损坏，路径：" + zipPath);
				}
				if (errors)
				{
					LogUtil.log(title + "：解压以下文件出错，文件已损坏：\n");
					for each (var error:String in errors) LogUtil.log("\t" + error + "\n");
				}
				else
				{
					content = unZipPath + homePath;
				}
			}
			else
			{
				LogUtil.log(title + "：网页文件压缩包不存在，" + zipPath);
				
				var cache:Cache = ($args[0] is String) ? Cache.cache($args[0], !useWait) : $args[0];
				if (!cach[cache.saveURL])
				{
					cache.extra = cache.extra || {};
					cache.addEventListener(CommandEvent.COMMAND_END, handlerCacheEnd);
					cach[cache.saveURL] = cache;
				}
			}
			
		}
		
		private function handlerCacheEnd($e:CommandEvent):void
		{
			var cache:Cache = $e.command as Cache;
			const exist:Boolean = cache.exist;
			const fzip:String = FileUtil.resolvePathApplication(cache.saveURL);
			const unZipPath:String = EPaperUtil.mp::getPathByZipFile(fzip); 
			
			if (exist)
			{
				LogUtil.log(title + "：下载文件成功");
				
				cache.removeEventListener(CommandEvent.COMMAND_END, handlerCacheEnd);
				var errors:Array = unzipFile(new VSFile(fzip), unZipPath);
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
					cache.removeEventListener(CommandEvent.COMMAND_END, handlerCacheEnd);
				}
				else
				{
					if (cach[cache.saveURL])
					{
						LogUtil.log(title + "：下载文件中断", cache.saveURL);
					}
				}
			}
			
			delete cach[cache.saveURL];
			
			if (cach.length == 0) 
			{
				content = unZipPath + homePath;
				LogUtil.log(title + "：报纸处理完毕，没有报纸数据");
				dispatchEvent(new ControlEvent(ControlEvent.READY));
			}
			
		}
		
		
		private function unzipFile(file:VSFile, path:String):Array
		{
			if (file && file.exists)
			{
				var reader:ZipFileReader = new ZipFileReader;
				reader.open(file);
				var entries:Array = reader.getEntries();
				var fold:String = getFold(path, entries);
				var t:int, entry:ZipEntry, fileName:String;
				var temp:VSFile, bytes:ByteArray, errors:Array;
				var stream:FileStream = new FileStream;
				var l:int = entries.length;
				
				for (t = 0; t < l; t++)
				{
					entry = entries[t] as ZipEntry;
					fileName = fold + entry.getFilename();
					if (entry.getUncompressSize() > 0)
					{
						temp = new VSFile(fileName);
						stream.open(temp, FileMode.WRITE);
						try
						{
							bytes = reader.unzip(entry);
						}
						catch (e:Error)
						{
							errors = errors || [];
							errors.push(fileName);
						}
						if (bytes) stream.writeBytes(reader.unzip(entry));
						stream.close();
						bytes = null;
					}
				}
				
				reader.close();
				
				var folder:VSFile = new VSFile(path);
				if (folder.exists && folder.getDirectoryListing().length > 0)
				{
					//创建一个标识文件来表示已经解压完毕
					var init:VSFile = new VSFile(path + "init.ini");
					stream = new FileStream;
					stream.open(init, FileMode.WRITE);
					stream.writeUTFBytes("inited");
					stream.close();
					
					//删除zip压缩包
					file.deleteFile();
				}
			}
			return errors;
		}
		
		/**
		 * @private
		 */
		private static function getFold(path:String, entries:Array):String
		{
			var temp:Array = path.split("/");
			var i:String = temp[temp.length - 2];
			path = (entries[0] as ZipEntry).getFilename();
			var a:Array = path.split("/");
			temp.length-= a[0] == i ? 2 : 1;
			return temp.join("/") + "/";
		}
		
		
		private function parseLocal():void
		{
			wt::registCache(getProperty("contentSource"));
		}
		
		/**
		 * 
		 * 背景颜色。
		 * 
		 */
		
		override public function get backgroundColor():uint
		{
			var temp:String = getProperty("backgroundColor");
			return temp ? ConvertUtil.touint(temp) : 0xFFFFFF;
		}
		
		
		/**
		 * 
		 * 网址。
		 * 
		 */
		
		public function get content():String
		{
			return mp::content;
		}
		
		public function set content($value:String):void
		{
			mp::content = $value;
		}
		
		public function get htmlType():String
		{
			return getProperty("htmlType");
		}
		
		/**
		 * 
		 * 首页地址。
		 * 该属性仅加载本地zip时可用。
		 *  
		 */
		
		private var homePath:String;
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}