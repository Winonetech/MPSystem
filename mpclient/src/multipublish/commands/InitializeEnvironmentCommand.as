package multipublish.commands
{
	
	/**
	 * 
	 * 环境初始化。<br>
	 * 获取网络配置，包括IP地址和MAC地址；<br>
	 * 初始化界面。
	 * 
	 */
	
	
	import cn.vision.system.VSFile;
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.ScreenUtil;
	
	import flash.desktop.NativeApplication;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	import flash.utils.ByteArray;
	
	import input.Input;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.URLConsts;
	import multipublish.tools.ScreenController;
	import multipublish.utils.ViewUtil;
	import multipublish.views.GuildView;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Alert;
	
	import spark.components.WindowedApplication;
	
	
	public final class InitializeEnvironmentCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeEnvironmentCommand</code>构造函数。
<<<<<<< HEAD
		 * <br>初始化环境 包括如下：
		 * <br>1.初始化网络配置、终端接口等；
		 * <br>2.初始化窗口组件等；
=======
		 * <br>包括初始化网络配置，初始化窗口和初始化LED。
>>>>>>> newspaper
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
			initializeLed();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initializeNetInfo():void
		{
			var info:NetworkInfo = NetworkInfo.networkInfo;   //获取实例
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
			//window.alwaysInFront = true;
			
			var r:Rectangle = getDebug() ? ScreenUtil.getMainScreenBounds() : ScreenUtil.getScreensBounds();
			
			config.screenController = new ScreenController;
			
			if (config.exportData || config.updateVersion)
			{
				window.nativeWindow.width  = 610;
				window.nativeWindow.height = 458;
				window.nativeWindow.x = .5 * (r.width  - window.nativeWindow.width);
				window.nativeWindow.y = .5 * (r.height - window.nativeWindow.height);
			}
			else
			{
				LogUtil.log("获取屏幕尺寸：" + r);
				
			}
			
			//add guild view
			ViewUtil.guild(true);
			
			window.addElement(view.keyboard = new Input);
			BindingUtils.bindProperty(view.keyboard, "title", config, "support");
		}
		
		/**
		 * @private
		 */
		private function initializeLed():void
		{
			try
			{
				ApplicationUtil.execute(
					FileUtil.resolvePathApplication(URLConsts.LED_LAUNCH),
					FileUtil.resolvePathApplication(URLConsts.LED_PATH)
				);
			}
			catch(e:Error)
			{
				LogUtil.log("LED程序启动不成功，请检查路径 " + URLConsts.LED_LAUNCH);
			}
		}
		
		private function getDebug():Boolean
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication("config.ini"));
			if (file.exists)
			{
				var stream:FileStream = new FileStream;
				stream.open(file, FileMode.READ);
				try
				{
					var xml:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
					
				}
				catch (o:Error)
				{
					Alert.show("读取配置文件出错！");
				}
				stream.close();
				if (xml)
				{
					return ObjectUtil.convert(xml.debug, Boolean);
				}
			}
			return false;
		}
		
	}
}