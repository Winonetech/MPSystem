package multipublish.vo
{
	
	/**
	 * 
	 * 语言数据结构。
	 * 
	 */
	
	
	import multipublish.core.mp;
	
	
	[Bindable]
	public final class Language
	{
		
		/**
		 * @private
		 */
		private function dataChange():void
		{
			var d:Object = data == "中文" ? CN : EN;
			for (var key:String in d) this[key] = d[key];
		}
		
		
		/**
		 * 
		 * 设置语言。
		 * 
		 */
		
		public function get data():String
		{
			return mp::data;
		}
		
		/**
		 * @private
		 */
		public function set data($value:String):void
		{
			if ($value != mp::data)
			{
				mp::data = $value;
				dataChange();
			}
		}
		
		
		//#################################################################
		//# 
		//# 设置面板
		//# 
		//#################################################################
		
		
		/**
		 * 
		 * 设置面板标题。
		 * 
		 */
		
		public var setting:String = "设置";
		
		
		//-----------------------------------------------------------------
		// 终端TAB
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 设置面板终端TAB。
		 * 
		 */
		
		public var terminal:String = "终端配置";
		
		
		/**
		 * 
		 * 公司ID。
		 * 
		 */
		public var language:String = "语言：";
		
		
		/**
		 * 
		 * 公司ID。
		 * 
		 */
		public var companyID:String = "公司ID：";
		
		
		/**
		 * 
		 * 设备编号。
		 * 
		 */
		public var deviceNO:String = "设备编号：";
		
		
		/**
		 * 
		 * 终端编号。
		 * 
		 */
		public var terminalNO:String = "终端编号：";
		
		
		/**
		 * 
		 * 数据包。
		 * 
		 */
		
		public var packageData:String = "数据包：";
		
		
		/**
		 * 
		 * 导入。
		 * 
		 */
		
		public var labelImport:String = "导入";
		
		
		//-----------------------------------------------------------------
		// HTTP TAB
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 设置面板HTTP TAB。
		 * 
		 */
		
		public var http:String = "HTTP 服务";
		
		
		/**
		 * 
		 * HTTP 地址。
		 * 
		 */
		
		public var httpHost:String = "HTTP 地址：";
		
		
		/**
		 * 
		 * HTTP 端口。
		 * 
		 */
		
		public var httpPort:String = "HTTP 端口：";
		
		
		//-----------------------------------------------------------------
		// Socket TAB
		//-----------------------------------------------------------------
		
		
		
		/**
		 * 
		 * 设置面板Socket TAB。
		 * 
		 */
		
		public var socket:String = "Socket 服务";
		
		
		/**
		 * 
		 * Socket 地址。
		 * 
		 */
		
		public var socketHost:String = "Socket 地址：";
		
		
		/**
		 * 
		 * 推送端口。
		 * 
		 */
		
		public var messagePort:String = "推送端口：";
		
		
		/**
		 * 
		 * 截图端口。
		 * 
		 */
		
		public var capturePort:String = "截图端口：";
		
		
		/**
		 * 
		 * 心跳间隔。
		 * 
		 */
		
		public var heartbeatTime:String = "心跳间隔：";
		
		
		/**
		 * 
		 * 等待推送时长。
		 * 
		 */
		
		public var pushwaitTime:String = "等待推送时长：";
		
		
		/**
		 * 
		 * 断开重连时长。
		 * 
		 */
		
		public var reconnectTime:String = "断开重连时长：";
		
		
		//-----------------------------------------------------------------
		// FTP TAB
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 设置面板FTP TAB。
		 * 
		 */
		
		public var ftp:String = "FTP 服务";
		
		
		/**
		 * 
		 * FTP 地址。
		 * 
		 */
		
		public var ftpHost:String = "FTP 地址：";
		
		
		/**
		 * 
		 * FTP 端口。
		 * 
		 */
		
		public var ftpPort:String = "FTP 端口：";
		
		
		/**
		 * 
		 * FTP 用户名。
		 * 
		 */
		
		public var ftpUserName:String = "用户名：";
		
		
		/**
		 * 
		 * FTP 密码。
		 * 
		 */
		
		public var ftpPassWord:String = "密码：";
		
		
		//-----------------------------------------------------------------
		// OTHER TAB
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 设置面板FTP TAB。
		 * 
		 */
		
		public var other:String = "其他";
		
		
		/**
		 * 
		 * 无应答超时。
		 * 
		 */
		
		public var support:String = "标题：";
		
		
		/**
		 * 
		 * 无应答超时。
		 * 
		 */
		
		public var welcome:String = "欢迎语：";
		
		
		/**
		 * 
		 * 无应答超时。
		 * 
		 */
		
		public var netTimeoutTime:String = "无应答超时：";
		
		
		/**
		 * 
		 * 最大节目时长。
		 * 
		 */
		
		public var maxDurationTime:String = "最大节目时长：";
		
		
		/**
		 * 
		 * 左右切换时长。
		 * 
		 */
		
		public var slideTweenTime:String = "左右切换时长：";
		
		
		/**
		 * 
		 * 缩放切换时长。
		 * 
		 */
		
		public var zoomTweenTime:String = "缩放切换时长：";
		
		
		//-----------------------------------------------------------------
		// HELP
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 整数，必填。
		 * 
		 */
		
		public var integerRequired:String = "整数，必填。";
		
		
		/**
		 * 
		 * IP地址，必填。
		 * 
		 */
		
		public var ipRequired:String = "IP地址，必填。";
		
		
		/**
		 * 
		 * 必填。
		 * 
		 */
		
		public var required:String = "必填。";
		
		
		/**
		 * 
		 * 整数。
		 * 
		 */
		
		public var integer:String = "整数。";
		
		
		/**
		 * 
		 * 手动获取。
		 * 
		 */
		
		public var manual:String = "手动获取。";
		
		
		/**
		 * 
		 * 默认21端口。
		 * 
		 */
		
		public var defaultPort21:String = "默认21端口。";
		
		
		/**
		 * 
		 * 默认80端口。
		 * 
		 */
		
		public var defaultPort80:String = "默认80端口。";
		
		
		/**
		 * 
		 * 默认6666端口。
		 * 
		 */
		
		public var defaultPort6666:String = "默认6666端口。";
		
		
		/**
		 * 
		 * 默认6668端口。
		 * 
		 */
		
		public var defaultPort6668:String = "默认6668端口。";
		
		
		/**
		 * 
		 * 以秒为单位，默认1秒。
		 * 
		 */
		
		public var defaultTime1:String = "以秒为单位，默认1秒。";
		
		
		/**
		 * 
		 * 以秒为单位，默认1.5秒。
		 * 
		 */
		
		public var defaultTime1_5:String = "以秒为单位，默认1.5秒。";
		
		
		/**
		 * 
		 * 以秒为单位，默认5秒。
		 * 
		 */
		
		public var defaultTime5:String = "以秒为单位，默认5秒。";
		
		
		/**
		 * 
		 * 以秒为单位，默认30秒。
		 * 
		 */
		
		public var defaultTime30:String = "以秒为单位，默认30秒。";
		
		
		/**
		 * 
		 * 以秒为单位，默认60秒。
		 * 
		 */
		
		public var defaultTime60:String = "以秒为单位，默认60秒。";
		
		
		/**
		 * 
		 * 以秒为单位，默认7200秒。
		 * 
		 */
		
		public var defaultTime7200:String = "以秒为单位，默认7200秒。";
		
		
		//-----------------------------------------------------------------
		// button
		//-----------------------------------------------------------------
		
		
		/**
		 * 
		 * 获取终端编号标签。
		 * 
		 */
		
		public var getTerminalNO:String = "获取终端编号";
		
		
		/**
		 * 
		 * 取消。
		 * 
		 */
		
		public var cancel:String = "取消";
		
		
		/**
		 * 
		 * 保存。
		 * 
		 */
		
		public var save:String = "保存";
		
		
		/**
		 * @private
		 */
		mp var data:String = "中文";
		
		
		/**
		 * @private
		 */
		private static const CN:Object = 
		{
			setting  :"设置",
			
			terminal   :"终端设置",
			language   :"语言",
			companyID  :"公司ID：",
			deviceNO   :"设备编号：",
			terminalNO :"终端编号：",
			packageData:"数据包：",
			labelImport:"导入",
			
			http    :"HTTP 服务",
			httpHost:"HTTP 地址：",
			httpPort:"HTTP 端口：",
			
			socket       :"Socket 服务",
			socketHost   :"Socket 地址：",
			messagePort  :"推送端口：",
			capturePort  :"截图端口：",
			heartbeatTime:"心跳间隔：",
			pushwaitTime :"等待推送时长：",
			reconnectTime:"断开重连时长：",
			
			ftp         :"FTP 服务",
			ftpHost     :"FTP 地址：",
			ftpPort     :"FTP 端口：",
			ftpUserName :"用户名：",
			ftpPassWord :"密码：",
			
			other           :"其他",
			support         :"标题：",
			welcome         :"欢迎语：",
			netTimeoutTime  :"无应答超时：",
			maxDurationTime :"最大节目时长：",
			slideTweenTime  :"左右切换时长：",
			zoomTweenTime   :"缩放切换时长：",
			
			
			integerRequired:"整数，必填。",
			ipRequired     :"IP地址，必填。",
			required       :"必填。",
			integer        :"整数。",
			manual         :"手动获取。",
			defaultPort21  :"默认21端口。",
			defaultPort80  :"默认80端口。",
			defaultPort6666:"默认6666端口。",
			defaultPort6668:"默认6668端口。",
			defaultTime1   :"以秒为单位，默认1秒。",
			defaultTime1_5 :"以秒为单位，默认1.5秒。",
			defaultTime5   :"以秒为单位，默认5秒。",
			defaultTime30  :"以秒为单位，默认30秒。",
			defaultTime60  :"以秒为单位，默认60秒。",
			defaultTime7200:"以秒为单位，默认7200秒。",
			
			getTerminalNO:"获取终端编号",
			cancel       :"取消",
			save         :"保存"
		};
		
		
		/**
		 * @private
		 */
		private static const EN:Object = 
		{
			setting   :"Setting",
			
			terminal   :"Ternimal Setting",
			language   :"Language",
			companyID  :"Company ID",
			deviceNO   :"Device NO.:",
			terminalNO :"Ternimal NO.:",
			packageData:"Data Package：",
			labelImport:"Import",
			
			http    :"HTTP Service",
			httpHost:"HTTP host:",
			httpPort:"HTTP port:",
			
			socket       :"Socket Service",
			socketHost   :"Socket host:",
			messagePort  :"Message port:",
			capturePort  :"Capture port:",
			heartbeatTime:"Heartbeat interval:",
			pushwaitTime :"Waiting time for message:",
			reconnectTime:"Time for reconnect:",
			
			ftp        :"FTP Service",
			ftpHost    :"FTP Host:",
			ftpPort    :"FTP Port:",
			ftpUserName:"Username:",
			ftpPassWord: "Password:",
			
			other          :"Other",
			support        :"Title:",
			welcome        :"Guilding words:",
			netTimeoutTime :"No response time:",
			maxDurationTime:"Program max time:",
			slideTweenTime :"Slide tween time:",
			zoomTweenTime  :"Zoom tween time:",
			
			integerRequired:"Integer, required.",
			ipRequired     :"IP address, required.",
			required       :"Required.",
			integer        :"Integer.",
			manual         :"Manual get.",
			defaultPort21  :"Default 21.",
			defaultPort80  :"Default 80.",
			defaultPort6666:"Default 6666.",
			defaultPort6668:"Default 6668.",
			defaultTime1   :"In seconds, default 1.",
			defaultTime1_5 :"In seconds, default 1.5.",
			defaultTime5   :"In seconds, default 5.",
			defaultTime30  :"In seconds, default 30.",
			defaultTime60  :"In seconds, default 60.",
			defaultTime7200:"In seconds, default 7200.",
			
			getTerminalNO:"Get terminal NO.",
			cancel       :"Cancel",
			save         :"Save"
		};
		
	}
}