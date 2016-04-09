package multipublish.tools
{
	
	/**
	 * 
	 * 发布系统HTTP服务交互。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.DebugUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.RegexpUtil;
	import cn.vision.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.ServiceConsts;
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	
	
	public final class MPService
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function MPService()
		{
			super();
			
			initialize();
		}
		
		
		/**
		 * 
		 * 向服务端发送上线指令。
		 * 
		 */
		
		public function online():void
		{
			if(!connected)
			{
				offsend = false;
				send(ServiceConsts.FORWARD_ON_LINE + config.terminalNO);
			}
			
		}
		
		
		/**
		 * 
		 * 向服务端发送离线指令。
		 * 
		 */
		
		public function offline():void
		{
			if (connected)
			{
				offsend = true;
				send(ServiceConsts.FORWARD_OFF_LINE + config.terminalNO);
			}
		}
		
		
		/**
		 * 
		 * 向服务端上报文件进度。
		 * 
		 * @param $data:String 相关参数，$cmd为true，$data上报格式为1430276253109.jpg;3，2代表开始下载，3代表下载完成，4代表下载出错。
		 * @param $cmd:Boolean (default = true) true则上报文件开始和结束下载，false则上报文件下载进度。
		 * 
		 */
		
		public function report($data:String, $cmd:Boolean = true):void
		{
			send($cmd
				? ServiceConsts.FILE_DOWNLOAD + config.terminalNO + ";" + $data
				: ServiceConsts.FILE_PROGRESS + config.terminalNO + "," + $data);
		}
		
		
		/**
		 * 
		 * 向服务端上报日志上传完毕。
		 * 
		 * @param $success:String (default = true) 是否上传成功。
		 * 
		 */
		
		public function logover($success:Boolean = true, $name:String = null):void
		{
			send(ServiceConsts.UPLOAD_LOG + config.terminalNO + ($success ? ", " + $name : ", 0"));
		}
		
		
		/**
		 * 
		 * 是否已注册某个Socket命令回调。
		 * 
		 * @param $cmd Socket命令回调名称，参见ServiceConsts。
		 * 
		 * @return Boolean 布尔值。
		 * 
		 */
		
		public function havingHandler($cmd:String):Boolean
		{
			return HANDS[$cmd];
		}
		
		
		/**
		 * 
		 * 注册Socket命令回调。
		 * 
		 * @param $cmd Socket命令回调名称，参见ServiceConsts。
		 * @param $handler 回调函数，必须包含参数$data:String，参阅ServiceUtil。
		 * 
		 */
		
		public function registHandler($cmd:String, $handler:Function, ...$args):void
		{
			HANDS[$cmd] = $handler;
		}
		
		
		/**
		 * 
		 * 移除命令回调。
		 * 
		 * @param $cmd Socket命令回调名称，参见ServiceConsts。
		 * 
		 */
		
		public function removeHandler($cmd:String):void
		{
			delete HANDS[$cmd];
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			loader = new URLLoader;
			request = new URLRequest;
			timer = new Timer(30000);
			loader.addEventListener(Event.COMPLETE, handlerDefault);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
			
			timer.addEventListener(TimerEvent.TIMER, handlerTimer);
		}
		
		/**
		 * @private
		 */
		private function heartbeat():void
		{
			if (connected) send(ServiceConsts.FORWARD_HEART_BEAT + config.terminalNO);
		}
		
		/**
		 * @private
		 */
		private function timerStart():void
		{
			if(!connected)
			{
				mp::connected = true;
				timer.start();
			}
		}
		
		/**
		 * @private
		 */
		private function timerStop():void
		{
			if (connected)
			{
				mp::connected = false;
				timer.reset();
				timer.stop();
			}
		}
		
		
		/**
		 * @private
		 */
		private function send($value:String):void
		{
			cmds.push($value);
			
			requestURI();
		}
		
		/**
		 * @private
		 */
		private function requestURI():void
		{
			if(!requesting &&cmds.length)
			{
				requesting = true;
				var variables:URLVariables = new URLVariables;
				variables.cmd = cmds.shift();
				//request.url = "message.txt";
				request.url = "http://" + config.httpHost + ":" + (config.httpPort || 80) + "/" + config.serviceURL;
				request.data = variables;
				
				LogUtil.log("通讯：" + request.url + "，cmd:" + variables.cmd);
				
				loader.load(request);
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerDefault($e:Event):void
		{
			requesting = false;
			switch ($e.type)
			{
				case Event.COMPLETE:
					offsend ? timerStop() : timerStart();
					readCMD(loader.data as String);
					break;
				case IOErrorEvent.IO_ERROR:
				case SecurityErrorEvent.SECURITY_ERROR:
					mp::message = ($e as Object).text;
					break;
				default:
					break;
			}
			requestURI();
		}
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			heartbeat();
		}
		
		/**
		 * @private
		 */
		private function readCMD($value:String):void
		{
			$value = $value.split("\r").join("");
			var list:Array = $value.split("\n");
			var filter:Function = function($item:*, $index:int, $array:Array):Boolean
			{
				return !StringUtil.isEmpty($item.substr(0, 5));
			};
			list = list.filter(filter, null);
			while (list.length)
			{
				var data:String = ArrayUtil.shift(list);
				
				LogUtil.log(RegexpUtil.replaceTag(MPTipConsts.RECORD_SOCKET_DATA, data));
				
				if (data)
				{
					var cmd:String = data.substr(0, 5);
					if (HANDS[cmd]) DebugUtil.execute(HANDS[cmd], true, data.substr(5));
				}
			}
		}
		
		
		/**
		 * 
		 * 心跳频率。
		 * 
		 */
		
		public function get frequency():uint
		{
			return timer.delay * .001;
		}
		
		/**
		 * @private
		 */
		public function set frequency($value:uint):void
		{
			timer.delay = $value * 1000;
			if (connected)
			{
				timer.reset();
				timer.start();
			}
		}
		
		
		/**
		 * 
		 * 是否已连接。
		 * 
		 */
		
		public function get connected():Boolean
		{
			return mp::connected as Boolean;
		}
		
		
		/**
		 * 
		 * 返回信息。
		 * 
		 */
		
		public function get message():String
		{
			return mp::message;
		}
		
		
		/**
		 * @private
		 */
		private function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		
		/**
		 * @private
		 */
		private var cmds:Vector.<String> = new Vector.<String>;
		
		/**
		 * @private
		 */
		private var datas:Vector.<String> = new Vector.<String>;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var timerHandler:Function;
		
		/**
		 * @private
		 */
		private var loader:URLLoader;
		
		/**
		 * @private
		 */
		private var request:URLRequest;
		
		/**
		 * @private
		 */
		private var requesting:Boolean;
		
		/**
		 * @private
		 */
		private var offsend:Boolean;
		
		
		/**
		 * @private
		 */
		mp var connected:Boolean;
		
		/**
		 * @private
		 */
		mp var message:String;
		
		
		/**
		 * @private
		 */
		private const HANDS:Object = {};
		
	}
}