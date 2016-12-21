package multipublish.commands
{
	import cn.vision.utils.FileUtil;
	
	import multipublish.consts.URLConsts;

	public class GetLEDConfigCommand extends _InternalCommand
	{
		
		
		public function GetLEDConfigCommand($config:String)
		{
			super();
			
			ledConfig = $config;
		}
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			getLEDConfig();
			
			commandEnd();
		}
		
		private　function getLEDConfig():void
		{
			if (ledConfig)
				FileUtil.saveUTF(URLConsts.LED_CONFIG, ledConfig);
		}
		
		private var ledConfig:String;
	}
}