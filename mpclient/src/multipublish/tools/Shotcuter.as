package multipublish.tools
{
	
	/**
	 * 
	 * 截图控制器。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.utils.LogUtil;
	
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.Timer;
	
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
			LogUtil.log("开始截图：" + $delay);
			if(!rectangle)
			{
				var w:Number = view.application.width  * scale;
				var h:Number = view.application.height * scale;
				rectangle = new Rectangle(0, 0, w, h);
				bmd = new BitmapData(rectangle.width, rectangle.height, false);
			}
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
			
			shotcut();
		}
		
		
		/**
		 * 
		 * 停止截图。
		 * 
		 */
		
		public function stop():void
		{
			LogUtil.log("停止截图。");
			if (timer)
			{
				timer.removeEventListener(TimerEvent.TIMER, handlerTimer);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
				timer.stop();
				timer = null;
			}
		}
		
		
		/**
		 * @private
		 */
		private function shotcut():void
		{
			bmd.draw(view.application, matrix);
			
			request.data = bmd.encode(rectangle, jpgOption);
			request.url = "http://" + config.httpHost + ":" + config.httpPort + "/" + config.shotcutURL + "?terminalId=" + config.terminalNO;
			LogUtil.log("上传截图：" + request.url);
			if (loading) loader.close();
			loading = true;
			loader.load(request);
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
			
			request = new URLRequest;
			request.method = URLRequestMethod.POST;
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			request.requestHeaders.push(header);
			loader = new URLLoader;
			loader.addEventListener(Event.COMPLETE, handlerDefault);
			loader.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			shotcut();
		}
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			stop();
		}
		
		
		private function handlerDefault($e:Event):void
		{
			loading = false;
			switch ($e.type)
			{
				case Event.COMPLETE:
					LogUtil.log("截图上传成功！");
					break;
				default:
					LogUtil.log("截图上传失败，" + ($e as Object).text);
					break;
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
		private var scale:Number;
		
		/**
		 * @private
		 */
		private var bmd:BitmapData;
		
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
		private var rectangle:Rectangle;
		
		/**
		 * @private
		 */
		private var request:URLRequest;
		
		/**
		 * @private
		 */
		private var loader:URLLoader;
		
		/**
		 * @private
		 */
		private var loading:Boolean;
		
	}
}