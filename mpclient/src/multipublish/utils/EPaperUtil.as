package multipublish.utils
{
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.system.VSFile;
	import cn.vision.utils.DateUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.StringUtil;
	
	import com.coltware.airxzip.ZipEntry;
	import com.coltware.airxzip.ZipFileReader;
	import com.rubenswieringa.book.Book;
	
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import multipublish.consts.URLConsts;
	import multipublish.core.mp;

	public class EPaperUtil
	{
		
		/**
		 * 
		 * 检测报纸文件是否标记在服务器上不存在。
		 * 
		 * @param $path:String 报纸文件路径。
		 * 
		 * @return Boolean true为已标记不存在，false为未标记不存在。
		 * 
		 */
		
		mp static function checkArchiveUnloadable($path:String):Boolean
		{
			var cacheObj:Object = getEpaperCache();
			var bool:Boolean = cacheObj && cacheObj[$path];
			if (bool)
			{
				//如果本地标记了服务端不存在该报纸文件，检测报纸的日期是否为今天的，如果是今天的，还需要重新连接服务端检测一次，返回false。
				try
				{
					var date:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD");
					var temp:String = $path.split("/").pop();
					var save:String = temp.split(".")[0];
					bool = !(save == date);
				}
				catch(e:Error) {}
			}
			return bool;
		}
		
		/**
		 * 
		 * 标记报纸文件在服务器上不存在。
		 * 
		 * @param $path:String 报纸文件路径。
		 * 
		 */
		
		mp static function flagArchiveUnloadable($path:String):void
		{
			var cacheObj:Object = getEpaperCache() || {};
			cacheObj[$path] = true;
			setEpaperCache(cacheObj);
		}
		
		/**
		 * @private
		 */
		private static function getEpaperCache():Object
		{
			epaperFile = epaperFile || new VSFile(FileUtil.resolvePathApplication(URLConsts.EPAPER_CACHE));
			if (epaperFile.exists)
			{
				epaperStream.open(epaperFile, FileMode.READ);
				var temp:String = epaperStream.readUTFBytes(epaperStream.bytesAvailable);
				epaperStream.close();
			}
			try
			{
				if (temp) var result:Object = JSON.parse(temp);
			} catch(e:Error){}
			return result;
		}
		
		/**
		 * @private
		 */
		private static function setEpaperCache($value:Object):void
		{
			try
			{
				var temp:String = JSON.stringify($value);
			} catch(e:Error) {}
			if (temp)
			{
				epaperStream.open(epaperFile, FileMode.WRITE);
				epaperStream.writeUTFBytes(temp);
				epaperStream.close();
			}
		}
		
		/**
		 * 
		 * 检测报纸压缩档中的文件是否能被解压。
		 * 只有图片和XML才能解压。
		 * 
		 */
		
		mp static function checkFileUnzipable($fileName:String):Boolean
		{
			var ext:String = FileUtil.getFileTypeByURL($fileName).toLowerCase();
			return(ext == FileTypeConsts.JPEG || 
					ext == FileTypeConsts.JPG ||
					ext == FileTypeConsts.PNG || 
					ext == "xml");
		}
		
		
		/**
		 * 
		 * 检测是否有已初始化完毕文件。
		 * 
		 */
		
		mp static function getDayInited(path:String):Boolean
		{
			var init:VSFile = new VSFile(path + "init.ini");
			return init.exists;
		}
		
		
		/**
		 * 
		 * 解压文件。
		 * 
		 */
		
		mp static function unzipFile(file:VSFile, path:String):Array
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
					if (entry.getUncompressSize() > 0 &&
						EPaperUtil.mp::checkFileUnzipable(fileName))
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
		 * 
		 * 根据报纸的压缩包路径获取对应的文件夹路径
		 * 如C:\MPClient\cache\epaper\2\2016-04-03.zip获取到的路径为C:\MPClient\cache\epaper\2\2016-04-03\
		 * 
		 */
		
		mp static function getPathByZipFile(fzip:String):String
		{
			var temp:Array = fzip.split("\\").join("/").split(".");
			temp.pop();
			return temp.join(".") + "/";
		}
		
		
		/**
		 * 
		 * 解析XML并替换中文节点。
		 * 
		 */
		
		mp static function replaceChi2Eng($value:String):String
		{
			$value = StringUtil.replace($value, "  >", ">");
			$value = StringUtil.replace($value, " >", ">");
			$value = StringUtil.replace($value, "<版面>", "<sheet>");
			$value = StringUtil.replace($value, "</版面>", "</sheet>");
			
			$value = StringUtil.replace($value, "<大样>", "<bigStyle>");
			$value = StringUtil.replace($value, "</大样>", "</bigStyle>");
			
			$value = StringUtil.replace($value, "<日期>", "<date>");
			$value = StringUtil.replace($value, "</日期>", "</date>");
			
			$value = StringUtil.replace($value, "<报名>", "<paperName>");
			$value = StringUtil.replace($value, "</报名>", "</paperName>");
			
			$value = StringUtil.replace($value, "<版次>", "<paperNo>");
			$value = StringUtil.replace($value, "</版次>", "</paperNo>");
			
			$value = StringUtil.replace($value, "<组版人>", "<former>");
			$value = StringUtil.replace($value, "</组版人>", "</former>");
			
			$value = StringUtil.replace($value, "<版面宽>", "<sheetW>");
			$value = StringUtil.replace($value, "</版面宽>", "</sheetW>");
			
			$value = StringUtil.replace($value, "<版面高>", "<sheetH>");
			$value = StringUtil.replace($value, "</版面高>", "</sheetH>");
			
			$value = StringUtil.replace($value, "<组版记录>", "<sheetRecord>");
			$value = StringUtil.replace($value, "</组版记录>", "</sheetRecord>");
			
			$value = StringUtil.replace($value, "<补字文件>", "<letterFile>");
			$value = StringUtil.replace($value, "</补字文件>", "</letterFile>");
			
			$value = StringUtil.replace($value, "<图片路径>", "<imagePath>");
			$value = StringUtil.replace($value, "</图片路径>", "</imagePath>");
			
			$value = StringUtil.replace($value, "<刊图路径>", "<sheetImagePath>");
			$value = StringUtil.replace($value, "</刊图路径>", "</sheetImagePath>");
			
			$value = StringUtil.replace($value, "<广告路径>", "<adPath>");
			$value = StringUtil.replace($value, "</广告路径>", "</adPath>");
			
			$value = StringUtil.replace($value, "<宽>", "<width>");
			$value = StringUtil.replace($value, "</宽>", "</width>");
			
			$value = StringUtil.replace($value, "<高>", "<height>");
			$value = StringUtil.replace($value, "</高>", "</height>");
			
			$value = StringUtil.replace($value, "<表格篇数>", "<xlsTotal>");
			$value = StringUtil.replace($value, "</表格篇数>", "</xlsTotal>");
			
			$value = StringUtil.replace($value, "<文本篇数>", "<textTotal>");
			$value = StringUtil.replace($value, "</文本篇数>", "</textTotal>");
			
			$value = StringUtil.replace($value, "<图片篇数>", "<imageTotal>");
			$value = StringUtil.replace($value, "</图片篇数>", "</imageTotal>");
			
			$value = StringUtil.replace($value, "<小样>", "<smallStyle>");
			$value = StringUtil.replace($value, "</小样>", "</smallStyle>");
			
			$value = StringUtil.replace($value, "<引题>", "<preTitle>");
			$value = StringUtil.replace($value, "</引题>", "</preTitle>");
			
			$value = StringUtil.replace($value, "<标题>", "<title>");
			$value = StringUtil.replace($value, "</标题>", "</title>");
			
			$value = StringUtil.replace($value, "<副题>", "<subTitle>");
			$value = StringUtil.replace($value, "</副题>", "</subTitle>");
			
			$value = StringUtil.replace($value, "<摘要>", "<summary>");
			$value = StringUtil.replace($value, "</摘要>", "</summary>");
			
			$value = StringUtil.replace($value, "<写稿日期>", "<writeDate>");
			$value = StringUtil.replace($value, "</写稿日期>", "</writeDate>");
			
			$value = StringUtil.replace($value, "<字数>", "<letters>");
			$value = StringUtil.replace($value, "</字数>", "</letters>");
			
			$value = StringUtil.replace($value, "<作者>", "<author>");
			$value = StringUtil.replace($value, "</作者>", "</author>");
			
			$value = StringUtil.replace($value, "<栏目>", "<part>");
			$value = StringUtil.replace($value, "</栏目>", "</part>");
			
			$value = StringUtil.replace($value, "<修改记录>", "<modifyRecord>");
			$value = StringUtil.replace($value, "</修改记录>", "</modifyRecord>");
			
			$value = StringUtil.replace($value, "<流程记录>", "<workflow>");
			$value = StringUtil.replace($value, "</流程记录>", "</workflow>");
			
			$value = StringUtil.replace($value, "<版名>", "<sheetName>");
			$value = StringUtil.replace($value, "</版名>", "</sheetName>");
			
			$value = StringUtil.replace($value, "<版面图映射>", "<sheetImageDown>");
			$value = StringUtil.replace($value, "</版面图映射>", "</sheetImageDown>");
			
			$value = StringUtil.replace($value, "<顶点个数>", "<pointTotal>");
			$value = StringUtil.replace($value, "</顶点个数>", "</pointTotal>");
			
			$value = StringUtil.replace($value, "<顶点>", "<point>");
			$value = StringUtil.replace($value, "</顶点>", "</point>");
			
			$value = StringUtil.replace($value, "<内容>", "<content>");
			$value = StringUtil.replace($value, "</内容>", "</content>");
			
			$value = StringUtil.replace($value, "<附图>", "<withImage>");
			$value = StringUtil.replace($value, "</附图>", "</withImage>");
			
			$value = StringUtil.replace($value, "<发布>", "<publish>");
			$value = StringUtil.replace($value, "</发布>", "</publish>");
			
			$value = StringUtil.replace($value, "<信息ID>", "<infoID>");
			$value = StringUtil.replace($value, "</信息ID>", "</infoID>");
			
			$value = StringUtil.replace($value, "<来源>", "<from>");
			$value = StringUtil.replace($value, "</来源>", "</from>");
			
			$value = StringUtil.replace($value, "<通讯员>", "<messager>");
			$value = StringUtil.replace($value, "</通讯员>", "</messager>");
			
			$value = StringUtil.replace($value, "<序号>", "<number>");
			$value = StringUtil.replace($value, "</序号>", "</number>");
			
			$value = StringUtil.replace($value, "<分类>", "<type>");
			$value = StringUtil.replace($value, "</分类>", "</type>");
			
			$value = StringUtil.replace($value, "<简图>", "<easyImage>");
			$value = StringUtil.replace($value, "</简图>", "</easyImage>");
			
			$value = StringUtil.replace($value, "<真图>", "<trueImage>");
			$value = StringUtil.replace($value, "</真图>", "</trueImage>");
			
			$value = StringUtil.replace($value, "<图标>", "<icon>");
			$value = StringUtil.replace($value, "</图标>", "</icon>");
			
			$value = StringUtil.replace($value, "<体裁>", "<bodyStyle>");
			$value = StringUtil.replace($value, "</体裁>", "</bodyStyle>");
			
			$value = StringUtil.replace($value, "<图片说明>", "<imageSummary>");
			$value = StringUtil.replace($value, "</图片说明>", "</imageSummary>");
			
			$value = StringUtil.replace($value, "<转载>", "<origin>");
			$value = StringUtil.replace($value, "</转载>", "</origin>");
			
			$value = StringUtil.replace($value, "<图片>", "<photo>");
			$value = StringUtil.replace($value, "</图片>", "</photo>");
			
			$value = StringUtil.replace($value, "<摄影记者>", "<photoAuthor>");
			$value = StringUtil.replace($value, "</摄影记者>", "</photoAuthor>");
			
			$value = StringUtil.replace($value, "<版面图>", "<sheetImage>");
			$value = StringUtil.replace($value, "</版面图>", "</sheetImage>");
			
			$value = StringUtil.replace($value, "<文件名>", "<fileName>");
			$value = StringUtil.replace($value, "</文件名>", "</fileName>");
			
			return $value;
		}
		
		
		/**
		 * 
		 * 报纸排序函数。
		 * 
		 */
		
		mp static function paperSortFunction(a:*, b:*):int
		{
			return DateUtil.compareDate(
				new Date(a.date.split("-").join("/")), 
				new Date(b.date.split("-").join("/")));
		}
		
		
		/**
		 * 
		 * 版面排序函数。
		 * 
		 */
		
		mp static function sheetSortFunction(a:*, b:*):int
		{
			return StringUtil.compare(a.label, b.label);
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
		
		
		/**
		 * @private
		 */
		private static var epaperFile:VSFile;
		
		/**
		 * @private
		 */
		private static var epaperStream:FileStream = new FileStream;
		
	}
}