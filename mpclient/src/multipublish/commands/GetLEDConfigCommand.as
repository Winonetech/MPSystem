package multipublish.commands
{
	
	/**
	 * 
	 * 设置从服务端发送过来的LED配置信息。
	 * 
	 */
	
	
	import cn.vision.utils.FileUtil;
	
	import multipublish.consts.URLConsts;
	
	
	public class GetLEDConfigCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
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
		
		
		/**
		 * @private
		 */
		private　function getLEDConfig():void
		{
			if (ledConfig)
				FileUtil.saveUTF(URLConsts.LED_CONFIG, ledConfig);
		}
		
		
		/**
		 * @private
		 */
		private var ledConfig:String;
		
	}
}