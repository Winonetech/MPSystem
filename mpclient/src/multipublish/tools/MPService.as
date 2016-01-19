package multipublish.tools
{
	
	/**
	 * 
	 * 发布系统Socket服务交互。
	 * 
	 */
	
	
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.DebugUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.RegexpUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.Service;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.ServiceConsts;
	import multipublish.core.MPCConfig;
	
	
	public final class MPService extends Service
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function MPService()
		{
			super();
		}
		
		
		/**
		 * 
		 * 向服务端发送离线指令。
		 * 
		 */
		
		public function offline():void
		{
			if (socket && socket.connected)
			{
				socket.writeUTF(ServiceConsts.FORWARD_OFF_LINE + config.terminalNO);
				socket.flush();
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
			if (socket && socket.connected)
			{
				socket.writeUTF($cmd
					? ServiceConsts.FILE_DOWNLOAD + config.terminalNO + ";" + $data
					: ServiceConsts.FILE_PROGRESS + config.terminalNO + "," + $data);
				socket.flush();
			}
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
			if (socket && socket.connected)
			{
				socket.writeUTF(ServiceConsts.UPLOAD_LOG + config.terminalNO + ($success ? ", " + $name : ", 0"));
				socket.flush();
			}
		}
		
		
		/**
		 * 
		 * 通知服务端播放某一类型的节目。
		 * 
		 * @param $type:String 节目类型。
		 * 
		 */
		
		public function program($type:String):void
		{
			if (socket && socket.connected)
			{
				socket.writeUTF(ServiceConsts.PLAY_PROGRAM + $type);
				socket.flush();
			}
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
		override protected function handlerSocketConnected($e:Event):void
		{
			LogUtil.log(RegexpUtil.replaceTag(MPTipConsts.RECORD_SOCKET_ONLINE));
			
			super.handlerSocketConnected($e);
			
			socket.writeUTF(ServiceConsts.FORWARD_ON_LINE + config.terminalNO);
			socket.flush();
			handlerTimerHeartbeat();
			createTimer(config.heartbeatTime || 30, handlerTimerHeartbeat);
		}
		
		/**
		 * @private
		 */
		override protected function handlerSocketData($e:ProgressEvent):void
		{
			super.handlerSocketData($e);
			
			DebugUtil.execute(read, false);
			var temp:String = datas.join("\n");
			var list:Array = temp.split("\n");
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
			datas.length = 0;
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimerHeartbeat($e:TimerEvent = null):void
		{
			if (socket.connected)
			{
				LogUtil.log(RegexpUtil.replaceTag(MPTipConsts.RECORD_SOCKET_HEARTBEAT, config.terminalNO));
				
				socket.writeUTF(ServiceConsts.FORWARD_HEART_BEAT + config.terminalNO);
				socket.flush();
			}
		}
		
		
		/**
		 * @private
		 */
		private function read():void
		{
			while(true)
			{
				var data:String = socket.readUTF();
				ArrayUtil.push(datas, data);
			}
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
		private var datas:Vector.<String> = new Vector.<String>;
		
		
		/**
		 * @private
		 */
		private const HANDS:Object = {};
		
	}
}