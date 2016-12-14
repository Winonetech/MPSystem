package multipublish.tools
{
	
	/**
	 * 
	 * 截图控制器。
	 * 
	 */
	
	
	import cn.vision.core.VSObject;
	import cn.vision.data.Tip;
	import cn.vision.net.FTPLoader;
	import cn.vision.net.FTPRequest;
	import cn.vision.net.FTPUploader;
	import cn.vision.utils.BitmapUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSQLite;
	import com.winonetech.utils.CacheUtil;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCView;
	import multipublish.utils.URLUtil;
	
	import mx.managers.PopUpManager;
	
	
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
		 * 开始截图。每隔$delay秒进行一次截图，持续49 + 1次。
		 * @param $delay:截图间隔时间。
		 * @param $times:截图次数。该参数不可以为 0！
		 * 
		 */
		
		public function start($delay:uint = 10, $isPolicy:Boolean = false, $times:uint = 50, $name:String = null):void
		{
			LogUtil.log("开始截图：" + $delay);
			
			isPolicy = $isPolicy;
			ftpName  = $name;
			
			if(!rectangle)
			{
				var w:Number = view.application.width  * scale;
				var h:Number = view.application.height * scale;
				rectangle = new Rectangle(0, 0, w, h);
				bmd = new BitmapData(rectangle.width, rectangle.height, false);
			}
			if (!$isPolicy)
			{
				if(!timer)
				{
					timer = new Timer($delay * 1000, $times - 1 || 1);  //减一是因为第 0秒已经截图了一次了。
					timer.addEventListener(TimerEvent.TIMER, handlerTimer);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
				}
				else 
				{
					timer.delay = $delay * 1000;
				}
				timer.reset();
				timer.start();
			}
			
			
			shotcut();   //第 0秒的截图。
		}
		
		
		/**
		 * 
		 * 停止截图。
		 * 
		 */
		
		public function stop():void
		{
			if (timer)
			{
				LogUtil.log("停止截图。");
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
			if (view.main)
				bmd.draw(view.main, matrix);
			isPolicy ? _ftp() : _url();
			
		}
		
		private function _ftp():void
		{
			var data:ByteArray = BitmapUtil.encodeJPG(bmd);
			var path:String = FileUtil.resolvePathApplication("shotcutPic" + File.separator + config.terminalNO);
//			var file:File = new File(path);
//			file.createDirectory();  //创建存储不同终端截图的文件夹。
			
			pic = new File(path + File.separator + ftpName + ".jpg");
			var fs:FileStream = new FileStream;
			fs.open(pic, FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
			upLoadPath = "ShotcutPic" + "-" + config.terminalNO + "/" + ftpName + ".jpg";
			pic.canonicalize();
			upLoad();
		}
		
		/**
		 * 
		 * 上传截图。
		 * 
		 */
		
		private function upLoad():void
		{
			ftpRequest = new FTPRequest(
				config.ftpHost,
				config.ftpUserName,
				config.ftpPassWord,
				config.ftpPort,
				upLoadPath,
				pic.nativePath);
			ftpLoader = new FTPUploader;
			ftpLoader.timeout = 150;
			ftpLoader.addEventListener(Event.COMPLETE, handlerDefault_ftp);
			ftpLoader.addEventListener(Event.CANCEL, handlerDefault_ftp);
			ftpLoader.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault_ftp);
			ftpLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault_ftp);
			ftpLoader.upload(ftpRequest);
			
			stop();
		}
		
		private function _url():void
		{
			request.data = BitmapUtil.encodeJPG(bmd);
			request.url = "http://" + config.httpHost + ":" + config.httpPort + "/" + config.shotcutURL + "?terminalId=" + config.terminalNO;
			LogUtil.log("上传截图：" + request.url, bmd.width, bmd.height);
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
		
		
		private function handlerDefault_ftp($e:Event):void
		{
			ftpLoader.removeEventListener(Event.COMPLETE, handlerDefault_ftp);
			ftpLoader.removeEventListener(Event.CANCEL, handlerDefault_ftp);
			ftpLoader.removeEventListener(IOErrorEvent.IO_ERROR, handlerDefault_ftp);
			ftpLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault_ftp);
			
			if ($e.type == Event.CANCEL) upLoad();
			else
			{
				var success:Boolean = ($e.type == Event.COMPLETE);
				
				var description:Tip = success 
					? MPTipConsts.RECORD_SHOTCUT_UPLOAD_SUCCESS
					: MPTipConsts.RECORD_SHOTCUT_UPLOAD_FAILURE;
				var text:String = success ? "" : ($e as IOErrorEvent).text;
				
				if (success) config.service.shotcutOver(true, 
					config.terminalNO + "," + ftpName + "," + URLUtil.buildFTPURL(upLoadPath));
				
				LogSQLite.log(TypeConsts.NETWORK, 
					EventConsts.EVENT_TAKE_SCREENSHOT,
					LogUtil.logTip(description, text));
			}
		}
		
		/**
		 * 
		 * Request接收处理。
		 * 
		 */
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
		private var ftpRequest:FTPRequest;
		
		/**
		 * @private
		 */
		private var ftpLoader:FTPUploader;
		
		/**
		 * @private
		 */
		private var loader:URLLoader;
		
		/**
		 * @private
		 */
		private var loading:Boolean;
		
		/**
		 * @private
		 */
		private var isPolicy:Boolean;
		
		/**
		 * 
		 * 时间戳。
		 * 
		 */
		private var ftpName:String;
		
		private var pic:File;
		
		private var upLoadPath:String
	}
}