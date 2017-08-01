package multipublish.commands
{
	import cn.vision.datas.Tip;
	import cn.vision.net.FTPRequest;
	import cn.vision.net.FTPUploader;
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.tools.MPService;

	public final class StatisticsUploadCommand extends _InternalCommand
	{
		public function StatisticsUploadCommand()
		{
			super();
		}
		
		override protected function processExecute():void
		{
			var date:Date = new Date;
			date.date -= 1;
			var str:String = ObjectUtil.convert(date, String, "YYYY-MM-DD");
			var loc:String = FileUtil.resolvePathApplication("statistics/" + str + ".sqlite");
			var rem:String = "statistics/" + config.terminalNO + "_" + str + ".sqlite";
			var file:VSFile = new VSFile(loc);
			if (file.exists)
			{
				var request:FTPRequest = new FTPRequest(
					config.ftpHost,
					config.ftpUserName,
					config.ftpPassWord,
					config.ftpPort,
					rem, loc);
				uploader = new FTPUploader;
				uploader.addEventListener(Event.COMPLETE, upload_defaultHandler);
				uploader.addEventListener(IOErrorEvent.IO_ERROR, upload_defaultHandler);
				uploader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, upload_defaultHandler);
				uploader.upload(request);
			}
		}
		
		private function upload_defaultHandler($e:Event):void
		{
			uploader.removeEventListener(Event.COMPLETE, upload_defaultHandler);
			uploader.removeEventListener(IOErrorEvent.IO_ERROR, upload_defaultHandler);
			uploader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, upload_defaultHandler);
			
			var success:Boolean = ($e.type == Event.COMPLETE);
			
			var description:Tip = success 
				? MPTipConsts.STATISTICS_UPLOAD_SUCCESS
				: MPTipConsts.STATISTICS_UPLOAD_FAILURE;
			var text:String = success ? "" : ($e as Object).text;
			
			/*LogSQLite.log(TypeConsts.NETWORK, 
				EventConsts.EVENT_STATISTICS_UPLOADED,
				LogUtil.logTip(description, text));*/
			
			LogUtil.logTip(description, text);
			
			service.logover(success, uploader.remoteURL);
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
		private var uploader:FTPUploader;
		
	}
}