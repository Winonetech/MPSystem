package multipublish.commands
{
	
	/**
	 * 
	 * 环境初始化。<br>
	 * 获取网络配置，包括IP地址和MAC地址；<br>
	 * 初始化界面。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	
	import flash.desktop.NativeApplication;
	import flash.display.Screen;
	import flash.geom.Rectangle;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	
	import input.Input;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.views.GuildView;
	
	import mx.binding.utils.BindingUtils;
	
	import spark.components.WindowedApplication;
	
	
	public final class InitializeEnvironmentCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeEnvironmentCommand</code>构造函数。
		 * 
		 */
		
		public function InitializeEnvironmentCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_ENVI);
			
			initializeNetInfo();
			initializeWindow();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initializeNetInfo():void
		{
			var info:NetworkInfo = NetworkInfo.networkInfo;
			var interfaces:Vector.<NetworkInterface> = info.findInterfaces();
			for each (var item:NetworkInterface in interfaces)
			{
				if (item.addresses[0].prefixLength == 24)
				{
					config.ip  = item.addresses[0].address;
					config.mac = item.hardwareAddress;
					break;
				}
			}
			if(!config.ip)
			{
				item = interfaces[0];
				if (item)
				{
					config.ip  = item.addresses[0].address;
					config.mac = item.hardwareAddress;
				}
			}
		}
		
		/**
		 * @private
		 */
		private function initializeWindow():void
		{
			NativeApplication.nativeApplication.autoExit = true;
			//get client version
			config.version = ApplicationUtil.getVersion();
			var window:WindowedApplication = view.application;
			//hide window statusbar
			window.showStatusBar = false;
			
			var r:Rectangle = Screen.mainScreen.bounds;
			if (config.exportData || config.updateVersion)
			{
				window.nativeWindow.width  = 610;
				window.nativeWindow.height = 458;
				window.nativeWindow.x = .5 * (r.width  - window.nativeWindow.width );
				window.nativeWindow.y = .5 * (r.height - window.nativeWindow.height);
			}
			else
			{
				window.nativeWindow.width  = config.width  = r.width;
				window.nativeWindow.height = config.height = r.height;
				window.nativeWindow.x = window.nativeWindow.y = 0;
			}
			
			
			//add guild view
			window.addElement(view.guild    = new GuildView);
			window.addElement(view.keyboard = new Input);
			BindingUtils.bindProperty(view.keyboard, "title", config, "support");
		}
		
	}
}