package multipublish.core
{
	
	/**
	 * 
	 * 配置存储器。
	 * 
	 */
	
	
	import cn.vision.errors.SingleTonError;
	
	import com.winonetech.core.Config;
	import com.winonetech.core.Store;
	
	import flash.display.Stage;
	
	import multipublish.tools.Controller;
	import multipublish.tools.MPService;
	import multipublish.tools.Reporter;
	import multipublish.tools.Shotcuter;
	import multipublish.vo.Language;

	
	[Bindable]
	public final class MPCConfig extends Config
	{
		 
		/**
		 * 
		 * <code>MPCConfig</code>构造函数。
		 * 
		 */
		
		public function MPCConfig()
		{
			if(!instance) 
			{
				super();
				
				initialize();
			}
			else throw new SingleTonError(this);
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::service    = new MPService;
			mp::controller = new Controller;
			mp::shotcuter  = new Shotcuter;
			mp::language   = new Language;
			mp::reporter   = new Reporter;
		}
		
		
		/**
		 * 
		 * 时间控制器。
		 * 
		 */
		
		public function get controller():Controller
		{
			return mp::controller;
		}
		
		
		/**
		 * 
		 * 语言。
		 * 
		 */
		
		public function get language():Language
		{
			return mp::language;
		}
		
		
		/**
		 * 
		 * socket交互，用于发送心跳，接受地址推送，终端控制。
		 * 
		 */
		
		public function get service():MPService
		{
			return mp::service;
		}
		
		
		/**
		 * 
		 * 截图控制器。
		 * 
		 */
		
		public function get shotcuter():Shotcuter
		{
			return mp::shotcuter;
		}
		
		
		/**
		 * 
		 * 下载进度上报器。
		 * 
		 */
		
		public function get reporter():Reporter
		{
			return mp::reporter;
		}
		
		
		/**
		 * 
		 * 舞台。
		 * 
		 */
		
		public function get stage():Stage
		{
			return view.application.stage;
		}
		
		/**
		 * 
		 * 缓存数据。
		 * 
		 */
		
		public function get store():Store
		{
			return Store.instance;
		}
		
		
		/**
		 * 
		 * 视图管理类。
		 * 
		 */
		
		public function get view():MPCView
		{
			return MPCView.instance;
		}
		
		
		/**
		 * 
		 * 使用缓存。
		 * 
		 */
		
		public var cache:Boolean;
		
		
		/**
		 * 
		 * 自动关机指令。
		 * 
		 */
		
		public var shutdown:String;
		
		
		/**
		 * 
		 * 技术支持。
		 * 
		 */
		
		public var support:String = "Winonetech";
		
		
		/**
		 * 
		 * 欢迎语。
		 * 
		 */
		
		public var welcome:String = "欢迎使用颖网科技多媒体制作发布系统。";
		
		
		/**
		 * 
		 * 公司ID。
		 * 
		 */
		
		public var companyID:String = "999";
		
		
		/**
		 * 
		 * 设备编号。
		 * 
		 */
		
		public var deviceNO:String = "";
		
		
		/**
		 * 
		 * 终端编号。
		 * 
		 */
		
		public function get terminalNO():String
		{
			return mp::terminalNO;
		}
		
		public function set terminalNO($value:String):void
		{
			mp::terminalNO = $value;
			//LogSaver.terminalNO = $value;
		}
		
		
		/**
		 * 
		 * 服务端IP地址。
		 * 
		 */
		
		public var httpHost:String = "127.0.0.1";
		
		
		/**
		 * 
		 * HTTP端口。
		 * 
		 */
		
		public var httpPort:uint = 80;
		
		
		/**
		 * 
		 * SOCKET IP地址。
		 * 
		 */
		
		public var socketHost:String = "127.0.0.1";
		
		
		/**
		 * 
		 * 服务端socket端口。
		 * 
		 */
		
		public var messagePort:uint = 6666;
		
		
		/**
		 * 
		 * 截图端口。
		 * 
		 */
		
		public var capturePort:uint = 6668;
		
		
		/**
		 * 
		 * 心跳间隔。
		 * 
		 */
		
		public var heartbeatTime:uint = 30;
		
		
		/**
		 * 
		 * 启动等待推送时长，超时则加载本地缓存。
		 * 
		 */
		
		public var pushwaitTime:uint = 5;
		
		
		/**
		 * 
		 * SOCKET断开后重连时长，以秒为单位。
		 * 
		 */
		
		public var reconnectTime:uint = 60;
		
		
		/**
		 * 
		 * FTP host。
		 * 
		 */
		
		public var ftpHost:String = "127.0.0.1";
		
		
		/**
		 * 
		 * FTP端口。
		 * 
		 */
		
		public var ftpPort:uint = 21;
		
		
		/**
		 * 
		 * FTP用户名。
		 * 
		 */
		
		public var ftpUserName:String = "ftp";
		
		
		/**
		 * 
		 * FTP密码。
		 * 
		 */
		
		public var ftpPassWord:String = "FTPmedia";
		
		
		/**
		 * 
		 * 加载超时时长。
		 * 
		 */
		
		public var netTimeoutTime:uint = 5;
		
		
		/**
		 * 
		 * 节目最大时长，以秒为单位。
		 * 
		 */
		
		public var maxDurationTime:uint = 7200;
		
		
		/**
		 * 
		 * 节目左右切换缓动时长，以秒为单位。
		 * 
		 */
		
		public var slideTweenTime:Number = 1.5;
		
		
		/**
		 * 
		 * 进入或返回缩放缓动时长，以秒为单位。
		 * 
		 */
		
		public var zoomTweenTime:Number = 1;
		
		
		/**
		 * 
		 * 是否打开缓存包导出程序。
		 * 
		 */
		
		public var exportData:Boolean;
		
		
		/**
		 * 
		 * 是否打开缓存包导出程序。
		 * 
		 */
		
		public var updateVersion:Boolean;
		
		
		/**
		 * 
		 * 是否导入缓存包。
		 * 
		 */
		
		public var importData:Boolean;
		
		
		/**
		 * 
		 * 终端屏幕高度，像素为单位。
		 * 
		 */
		
		public var height:Number = 0;
		
		
		/**
		 * 
		 * 终端屏幕宽度，像素为单位。
		 * 
		 */
		
		public var width:Number = 0;
		
		
		/**
		 * 
		 * 本机IP地址。
		 * 
		 */
		
		public var ip:String;
		
		
		/**
		 * 
		 * 是否从服务端加载。
		 * 
		 */
		
		public var loadable:Boolean;
		
		
		/**
		 * 
		 * 本机mac地址。
		 * 
		 */
		
		public var mac:String;
		
		
		/**
		 * 
		 * 版本号。
		 * 
		 */
		
		public var version:String;
		
		
		/**
		 * 
		 * 客户端状态。
		 * 
		 */
		
		public var state:String;
		
		
		/**
		 * 
		 * 临时数据存储。
		 * 
		 */
		
		public var source:*;
		
		
		/**
		 * 
		 * 临时数据存储。
		 * 
		 */
		
		public var temp:*;
		
		
		/**
		 * @private
		 */
		mp var controller:Controller;
		
		/**
		 * @private
		 */
		mp var language:Language;
		
		/**
		 * @private
		 */
		mp var service:MPService;
		
		/**
		 * @private
		 */
		mp var shotcuter:Shotcuter;
		
		/**
		 * @private
		 */
		mp var reporter:Reporter;
		
		/**
		 * @private
		 */
		mp var terminalNO:String;
		
		
		/**
		 * 
		 * 单例引用。
		 * 
		 */
		
		public static const instance:MPCConfig = new MPCConfig;
		
	}
}