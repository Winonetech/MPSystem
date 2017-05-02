package multipublish.commands
{
	
	/**
	 * 
	 * 初始化本地配置。
	 * 
	 */
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.Cache;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.utils.ConfigUtil;
	
	
	public final class InitializeConfigCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeConfigCommand</code>构造函数。
		 * <br>解析 config并映射到 MDConfig中。
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
			
			ConfigUtil.readNativeData();
			
			if(!StringUtil.empty(config.ftpHost) && 
				config.ftpHost != "127.0.0.1")
			{
				Cache.deftp(
					config.ftpHost, 
					config.ftpPort, 
					config.ftpUserName, 
					config.ftpPassWord);
			}
			
			Cache.timeout = config.netTimeoutTime;
			
			view.application.alwaysInFront = !config.debug;
			
			commandEnd();
		}
		
	}
}