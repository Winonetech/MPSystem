package multipublish.commands
{
	
	/**
	 * 
	 * 初始化本地配置。
	 * 
	 */
	
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.Cache;
	
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.URLConsts;
	
	
	public final class InitializeConfigCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeConfigCommand</code>构造函数。
		 * 
		 */
		
		public function InitializeConfigCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_CONF);
			
			loadConfig();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function loadConfig():void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG));
			if (file.exists)
			{
				var reader:FileStream = new FileStream;
				reader.open(file, FileMode.READ);
				var xml:XML = XML(reader.readUTFBytes(reader.bytesAvailable));
				if (xml) 
				{
					XMLUtil.map(xml, config);
					config.language.data = XMLUtil.convert(xml["languageData"]);
					if(!StringUtil.isEmpty(config.ftpHost) && 
						config.ftpHost != "127.0.0.1")
					{
						Cache.deftp(
							config.ftpHost, 
							config.ftpPort, 
							config.ftpUserName, 
							config.ftpPassWord);
					}
				}
				reader.close();
				reader = null;
			}
			file = null;
		}
		
	}
}