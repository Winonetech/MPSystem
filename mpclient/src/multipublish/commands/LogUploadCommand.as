package multipublish.commands
{
	
	/**
	 * 
	 * 日志上传。<br>
	 * 上传前一天的日志文件。
	 * 
	 */
	
	
	import cn.vision.data.Tip;
	import cn.vision.net.FTPRequest;
	import cn.vision.net.FTPUploader;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSaver;
	import com.winonetech.utils.CacheUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.tools.MPService;
	
	
	public final class LogUploadCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function LogUploadCommand($path:String)
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
			
			logUpload();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($path:String):void
		{
			path = $path;
			var s:String = path.substr(-1);
			if (s != "/" && s != "\\") path += "/";
		}
		
		/**
		 * @private
		 */
		private function logUpload():void
		{
			LogSaver.log(TypeConsts.NETWORK, 
				EventConsts.EVENT_UPLOAD_LOG,
				LogUtil.logTip(MPTipConsts.RECORD_LOG_UPLOAD));
			
			var date:Date = new Date;
			var month:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			var time:String;
			if (date.date == 1)
			{
				if (date.fullYear % 4 == 0)
				{
					time = date.fullYear + "-" + date.month + (date.month == 1 ? 29 : month[date.month - 1]);
				}
				else
				{
					time = date.fullYear + "-" + date.month + "-" + month[date.month - 1];
				}
			}
			else
			{
				time = date.fullYear + "-" + (date.month + 1) + "-" + (date.date - 1)
			}
			var name:String = "log/sqlite/" + time + ".sqlite";
			var request:FTPRequest = new FTPRequest(
				config.ftpHost,
				config.ftpUserName,
				config.ftpPassWord,
				config.ftpPort,
				CacheUtil.extractURI(path) + config.terminalNO + "-" + time + ".sqlite",
				FileUtil.resolvePathApplication(name));
			uploader = new FTPUploader;
			uploader.timeout = 5;
			uploader.addEventListener(Event.COMPLETE, handlerDefault);
			uploader.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			uploader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
			uploader.upload(request);
		}
		
		
		/**
		 * @private
		 */
		private function handlerDefault($e:Event):void
		{
			uploader.removeEventListener(Event.COMPLETE, handlerDefault);
			uploader.removeEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			uploader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
			
			var success:Boolean = ($e.type == Event.COMPLETE);
			
			var description:Tip = success 
				? MPTipConsts.RECORD_LOG_UPLOAD_SUCCESS
				: MPTipConsts.RECORD_LOG_UPLOAD_FAILURE;
			var text:String = success ? "" : ($e as IOErrorEvent).text;
			
			LogSaver.log(TypeConsts.NETWORK, 
				EventConsts.EVENT_LOG_UPLOADED,
				LogUtil.logTip(description, text));
			
			service.logover(success, uploader.remoteURL.split("/").pop());
		}
		
		
		/**
		 * @private
		 */
		private function get service():MPService
		{
			return config.service;
		}
		
		
		/**
		 * @private
		 */
		private var path:String;
		
		/**
		 * @private
		 */
		private var uploader:FTPUploader;
		
	}
}