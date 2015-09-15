package multipublish.tools
{
	
	/**
	 * 
	 * 截图控制器。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.Socket;
	import flash.utils.Timer;
	
	import multipublish.consts.ServiceConsts;
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCView;
	
	
	public final class Shotcuter extends VSObject
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Shotcuter()
		{
			super();
			
			initialize();
		}
		
		
		/**
		 * 
		 * 开始截图。
		 * 
		 */
		
		public function start($delay:uint = 10):void
		{
			//计数为了防止2个人在看截图时，一个关闭窗口后，另外一个窗口不刷新的截图问题。
			count++;
			w = view.application.width  * scale;
			h = view.application.height * scale;
			rectange = new Rectangle(0, 0, w, h);
			bmd = new BitmapData(w, h, false, 0);
			cmd = ServiceConsts.SEND_SHOTCUT + config.terminalNO;
			
			if(!timer)
			{
				timer = new Timer($delay * 1000, 49);
				timer.addEventListener(TimerEvent.TIMER, handlerTimer);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
			}
			else 
			{
				timer.delay = $delay * 1000;
			}
			timer.reset();
			timer.start();
			createSocket();
		}
		
		
		/**
		 * 
		 * 停止截图。
		 * 
		 */
		
		public function stop():void
		{
			count--;
			if (count <= 0 && timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, handlerTimer);
				timer = null;
			}
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			scale = 1 / 3;
			jpgOption = new JPEGEncoderOptions(50);
			matrix = new Matrix;
			matrix.scale(scale, scale);
		}
		
		/**
		 * @private
		 */
		private function createSocket():void
		{
			var socket:Socket = new Socket;
			socket.addEventListener(Event.CONNECT, handlerDefault);
			socket.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
			socket.connect(config.socketHost, config.capturePort);
		}
		
		/**
		 * @private
		 */
		private function shotcutPlayer(socket:Socket):void
		{
			bmd.draw(view.application, matrix);
			socket.writeInt(cmd.length);
			socket.writeUTFBytes(cmd);
			socket.writeBytes(bmd.encode(rectange, jpgOption));
			socket.flush();
			socket.close();
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			createSocket();
		}
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			count = 0;
		}
		
		/**
		 * @private
		 */
		private function handlerDefault($e:Event):void
		{
			var socket:Socket = $e.target as Socket;
			socket.addEventListener(Event.CONNECT, handlerDefault);
			socket.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
			if ($e.type == Event.CONNECT) shotcutPlayer(socket);
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
		private function get view():MPCView
		{
			return MPCView.instance;
		}
		
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var cmd:String;
		
		/**
		 * @private
		 */
		private var scale:Number;
		
		/**
		 * @private
		 */
		private var jpgOption:JPEGEncoderOptions;
		
		/**
		 * @private
		 */
		private var matrix:Matrix;
		
		/**
		 * @private
		 */
		private var rectange:Rectangle;
		
		/**
		 * @private
		 */
		private var bmd:BitmapData;
		
		/**
		 * @private
		 */
		private var w:Number;
		
		/**
		 * @private
		 */
		private var h:Number;
		
		/**
		 * @private
		 */
		private var count:int;
		
	}
}