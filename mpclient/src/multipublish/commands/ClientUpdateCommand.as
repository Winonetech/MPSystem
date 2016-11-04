package multipublish.commands
{
	
	/**
	 * 
	 * 自动更新。
	 * 
	 */
	
	
	import cn.vision.net.FTPLoader;
	import cn.vision.net.FTPRequest;
	import cn.vision.system.VSFile;
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.URLConsts;
	import multipublish.utils.DataUtil;
	import multipublish.utils.ZipUtil;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	
	public final class ClientUpdateCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ClientUpdateCommand($path:String = null)
		{
			super();
			
			path = $path;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			clientUpdate();
			
			commandEnd();
		}
		
		private function updateTest():void
		{
			var updater:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.UPDATER));
			if (updater.exists)
			{
				uncomporess();
				ApplicationUtil.exit();
				ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
			}
		}
		
		
		/**
		 * @private
		 */
		private function clientUpdate():void
		{
			modelog(ClientStateConsts.UPDATE_CHECK);
			
			var updater:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.UPDATER));
			if (config.remoteVersion && updater.exists)
			{
				if (compareVersion(config.remoteVersion))
				{
					//升级包下载完毕，退出并调用升级程序。
					LogUtil.log("升级包下载完毕，退出并调用升级程序");
					uncomporess();
					ApplicationUtil.exit();
					ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
				}
				else
				{
					LogUtil.log("升级完毕，删除更新包");
					updater.deleteFile();
					config.remoteVersion = null;
					Cache.save(URLConsts.NATIVE_CONFIG, DataUtil.getConfig());
				}
			}
			else
			{
				LogUtil.log("连接服务端自动更新检测：", config.version, config.terminalNO);
				
				requestData(defaultHandler, {
					"code": config.version,
					"number": config.terminalNO
				});
			}
		}
		
		/**
		 * @private
		 */
		private function requestData($handler:Function, $data:Object):void
		{
			http = new HTTPService;
			http.addEventListener(ResultEvent.RESULT, $handler);
			http.addEventListener(FaultEvent.FAULT, $handler);
			http.method = "POST";
			http.contentType = "application/json";
			http.url = url = "http://" + config.httpHost + ":" +(config.updtPort || 80)+ "/" + config.updateURL;
			http.send(JSON.stringify($data));
		}
		
		/**
		 * @private
		 */
		private function uncomporess():void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.UPDATER));
			ZipUtil.unzipFile(file);
			file.deleteFile();
		}
		
		/**
		 * @private
		 */
		private function compareVersion($version:String):Boolean
		{
			var rv:Array = $version.split(".");
			var lv:Array = config.version.split(".");
			var l:uint = Math.min(rv.length, lv.length);
			for (var i:uint = 0; i < l; i++)
			{
				if (Number(lv[i]) < Number(rv[i])) return true;
			}
			if (lv.length < rv.length) return true;
			return false;
		}
		
		
		/**
		 * @private
		 */
		private function defaultHandler($e:Event):void
		{
			http.removeEventListener(ResultEvent.RESULT, defaultHandler);
			http.removeEventListener(FaultEvent.FAULT, defaultHandler);
			
			if ($e.type == ResultEvent.RESULT)
			{
				var data:* = ($e as ResultEvent).result;
				if (data is String) data = JSON.parse(data);
				if (data.result == "success" && data.dataObj)
				{
					downID = data.downId;
					data = data.dataObj;
					var updater:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.UPDATER));
					LogUtil.log("远程版本：" + data.code + "，本地版本：" + config.version);
					if (compareVersion(data.code))
					{
						config.remoteVersion = data.code;
						Cache.save(URLConsts.NATIVE_CONFIG, DataUtil.getConfig());
						
							//下载更新包。
							LogUtil.log("下载更新包：" + data.fpath);
							var ftp:FTPLoader = new FTPLoader;
							ftp.timeout = 10;
							ftp.addEventListener(Event.COMPLETE, handlerFTPDefault);
							ftp.addEventListener(IOErrorEvent.IO_ERROR, handlerFTPDefault);
							ftp.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerFTPDefault);
							var loadURL:String = CacheUtil.extractURI(XMLUtil.convert(data.fpath));
							var saveURL:String = FileUtil.resolvePathApplication(URLConsts.UPDATER);
							var request:FTPRequest = new FTPRequest(
								config.ftpHost,
								config.ftpUserName,
								config.ftpPassWord,
								config.ftpPort || 21,
								loadURL, saveURL);
							ftp.load(request);
						
					}
					else
					{
						LogUtil.log("已是最新版本，无需升级");
						if (updater.exists) 
						{
							LogUtil.log("删除更新包");
							updater.deleteFile();
						}
					}
				}
				else
				{
					LogUtil.log("已是最新版本，无需升级");
				}
			}
			else
			{
				LogUtil.log("获取新的客户端版本失败，URL:" + url);
			}
		}
		
		/**
		 * @private
		 */
		private function handlerFTPDefault($e:Event):void
		{
			var loader:FTPLoader = $e.target as FTPLoader;
			loader.removeEventListener(Event.COMPLETE, handlerFTPDefault);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handlerFTPDefault);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerFTPDefault);
			if ($e.type == IOErrorEvent.IO_ERROR)
			{
				LogUtil.log("下载更新包失败：" + IOErrorEvent($e).text);
			}
			else
			{
				LogUtil.log("下载更新包成功，退出执行升级程序！");
				requestData(handlerDownDefault, {"downId":downID});
				
			}
		}
		
		/**
		 * @private
		 */
		private function handlerDownDefault(e:Event):void
		{
			http.removeEventListener(ResultEvent.RESULT, defaultHandler);
			http.removeEventListener(FaultEvent.FAULT, defaultHandler);
			
			uncomporess();
			ApplicationUtil.exit();
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
		}
		
		
		/**
		 * @private
		 */
		private var downID:String;
		
		/**
		 * @private
		 */
		private var url:String;
		
		/**
		 * @private
		 */
		private var path:String;
		
		/**
		 * @private
		 */
		private var http:HTTPService;
		
	}
}