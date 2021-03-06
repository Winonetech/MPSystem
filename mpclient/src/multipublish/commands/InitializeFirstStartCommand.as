package multipublish.commands
{
	
	/**
	 * 
	 * 首次启动初始化，根据是否已获取终端编号来判断。
	 * 
	 */
	
	
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.JSONUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ScreenUtil;
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.Cache;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	import multipublish.utils.DataUtil;
	import multipublish.utils.ViewUtil;
	import multipublish.views.InstallerView;
	import multipublish.vo.Language;
	
	import mx.binding.utils.BindingUtils;
		
	
	public final class InitializeFirstStartCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeFirstStartCommand</code>构造函数。
		 * <br>初次启动时初始化。显示配置面板
		 * 
		 */
		
		public function InitializeFirstStartCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			show();
		}
		
		
		/**
		 * @private
		 * 显示配置面板。
		 */
		private function show():void
		{
			if (StringUtil.isEmpty(config.terminalNO))
			{
				ViewUtil.guild(false);
				
				view.application.addElement(view.installer = new InstallerView);
				view.installer.onSubmit = load;
				view.installer.onCancel = exit;
				var bounds:Rectangle = ScreenUtil.getMainScreenBounds();
				view.installer.x = .5 * (bounds.width  - view.installer.width);
				view.installer.y = .5 * (bounds.height - view.installer.height);
				BindingUtils.bindProperty(view.installer, "labelSubmit", language, "getTerminalNO");
				BindingUtils.bindProperty(view.installer, "labelCancel", language, "cancel");
			}
			else
			{
				commandEnd();
			}
		}
		
		/**
		 * @private
		 */
		private function exit():void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * @private
		 * 服务端接收数据。
		 */
		private function load():void
		{
			loader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, defaultHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, defaultHandler);
			
			var request:URLRequest = new URLRequest;
			request.url = "http://" + config.httpHost + ":" +(config.httpPort || 80) + "/" + config.requestTem;
			var variables:URLVariables = new URLVariables;
			variables.corpId  = config.companyID;
			variables.code    = config.deviceNO;
			variables.version = config.version;
			variables.ip      = config.ip;
			variables.mac     = config.mac;
			variables.screenResolutionWidth  = config.width;
			variables.screenResolutionHeight = config.height;
			request.data = variables;
			
			LogUtil.log("申请终端：" + request.url);
			
			loader.load(request);
		}
		
		/**
		 * @private
		 */
		private function save():void
		{
			FileUtil.saveUTF(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG), DataUtil.getConfig());
			
			view.application.removeElement(view.installer);
			ViewUtil.guild(true);
			
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
					
					applySettings();
				}
				reader.close();
				reader = null;
			}
			file = null;
		}
		
		/**
		 * @private
		 */
		private function applySettings():void
		{
			if(!StringUtil.isEmpty(config.ftpHost) && 
				config.ftpHost != "127.0.0.1")
			{
				Cache.deftp(
					config.ftpHost, 
					config.ftpPort, 
					config.ftpUserName, 
					config.ftpPassWord);
			}
			
			Cache.timeout = config.netTimeoutTime;
			
			view.application.alwaysInFront =!config.debug;
		}
		
		
		/**
		 * @private
		 * 判定返回的结果是否满足条件。满足则执行保存，否则弹出提示窗口。
		 */
		private function defaultHandler($e:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, defaultHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, defaultHandler);
			loader = null;
			
			if ($e.type == Event.COMPLETE)
			{
				var json:Object = JSON.parse($e.target.data as String);
				config.terminalNO = json.terminalNo;
				if(uint(config.terminalNO) > 0)
				{
					view.installer.onSubmit = save;
					BindingUtils.bindProperty(view.installer, "labelSubmit", language, "save");
				}
				else
				{
					view.installer.onSubmit = load;
					view.installer.onCancel = exit;
					tip(language.data == "中文" 
						? MPTipConsts.ERROR_CN_TERMINAL_GET_NO
						: MPTipConsts.ERROR_EN_TERMINAL_GET_NO);
				}
			}
			else
			{
				view.installer.onSubmit = load;
				view.installer.onCancel = exit;
				tip(language.data == "中文" 
					? MPTipConsts.ERROR_CN_SERVER_CONNECT 
					: MPTipConsts.ERROR_EN_SERVER_CONNECT);
			}
		}
		
		
		/**
		 * @private
		 */
		private function get language():Language
		{
			return config.language;
		}
		
		
		/**
		 * @private
		 */
		private var loader:URLLoader;
		
	}
}