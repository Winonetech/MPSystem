package multipublish.commands
{
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.ServiceConsts;
	import multipublish.consts.URLConsts;
	import multipublish.core.MPCConfig;
	import multipublish.errors.FileUnExistError;
	import multipublish.tools.MPService;

	public final class SendLEDConfigCommand extends _InternalCommand
	{
		
		
		
		public function SendLEDConfigCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			sendLEDConfig();
			
			commandEnd();
		}
		
		
		private function sendLEDConfig():void
		{
			if (flag) return;      //如果不是第一次进入，则直接返回。
			
			var config:String = readConfig2String();
			
			if (config) 
				MPCConfig.instance.service.readConfigOver(config);
			
			flag = true;
		}
		
		
		/**
		 * 
		 * 返回读到的config数据。String类型。
		 * 
		 */
		
		private function readConfig2String():String
		{
			
			var url:String = FileUtil.resolvePathApplication(URLConsts.LED_CONFIG);
			var f:File = new File(url);
			var fs:FileStream = new FileStream;
			
			if (f.exists)
			{
				fs.open(f, FileMode.READ);
				var config:String = fs.readUTFBytes(fs.bytesAvailable);
				fs.close();
			}
			else
			{
				throw new FileUnExistError(url);
			}
			
			return config;
		}
		
		/**
		 * 
		 * 一个标记。只允许首次进入。
		 * 
		 */
		
		private static var flag:Boolean;
		
	}
}