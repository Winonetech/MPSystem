package multipublish.commands
{
	
	/**
	 * 
	 * 自动更新。
	 * 
	 */
	
	
	import cn.vision.events.TimeoutEvent;
	import cn.vision.net.FTPLoader;
	import cn.vision.net.FTPRequest;
	import cn.vision.net.URILoader;
	import cn.vision.system.VSFile;
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.utils.CacheUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.URLConsts;
	
	
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
			
			initialize($path);
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
		
		
		/**
		 * @private
		 */
		private function initialize($path:String):void
		{
			path = $path;
		}
		
		/**
		 * @private
		 */
		private function clientUpdate():void
		{
			modelog(ClientStateConsts.UPDATE_CHECK);
			
			var loader:URILoader = new URILoader;
			loader.timeout = 5;
			loader.addEventListener(Event.COMPLETE, handlerLoadDefault);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handlerLoadDefault);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerLoadDefault);
			loader.addEventListener(TimeoutEvent.TIMEOUT, handlerLoadDefault);
			
			var request:URLRequest = new URLRequest;
			request.url = "http://" + config.httpHost + ":" +(config.httpPort || 80)+ URLConsts.GET_CLIENT_INFO;
			var variables:URLVariables = new URLVariables;
			variables.terminalNumber = config.terminalNO;
			variables.versionNumber = config.version;
			request.data = variables;
			
			LogUtil.log("连接服务端自动更新检测：" + request.url);
			LogUtil.log("terminalNumber:" + variables.terminalNumber);
			LogUtil.log("versionNumber:" + variables.versionNumber);
			
			loader.load(request);
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
		private function handlerLoadDefault($e:Event):void
		{
			var loader:URILoader = $e.target as URILoader;
			loader.removeEventListener(Event.COMPLETE, handlerLoadDefault);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, handlerLoadDefault);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerLoadDefault);
			loader.removeEventListener(TimeoutEvent.TIMEOUT, handlerLoadDefault);
			loader.close();
			
			if ($e.type == Event.COMPLETE)
			{
				var xml:XML = XMLUtil.convert($e.target.data, XML);
				
				LogUtil.log(xml.version, config.version);
				var updater:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.UPDATER));
				if (compareVersion(xml.version))
				{
					if (updater.exists)
					{
						//升级包下载完毕，退出并调用升级程序。
						ApplicationUtil.exit();
						ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.UPDATER));
					}
					else
					{
						//下载更新包。
						var ftp:FTPLoader = new FTPLoader;
						ftp.addEventListener(Event.COMPLETE, handlerFTPDefault);
						ftp.addEventListener(IOErrorEvent.IO_ERROR, handlerFTPDefault);
						ftp.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerFTPDefault);
						var loadURL:String = CacheUtil.extractURI(XMLUtil.convert(xml.file));
						var saveURL:String = FileUtil.resolvePathApplication(URLConsts.UPDATER);
						var request:FTPRequest = new FTPRequest(
							config.ftpHost,
							config.ftpUserName,
							config.ftpPassWord,
							config.ftpPort || 21,
							loadURL, saveURL);
						ftp.load(request);
					}
				}
				else
				{
					if (updater.exists) updater.deleteFile();
				}
			}
			else
			{
				LogUtil.log("获取新的客户端版本失败！");
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
		}
		
		
		/**
		 * @private
		 */
		private var path:String;
		
	}
}