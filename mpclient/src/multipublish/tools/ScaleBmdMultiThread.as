package multipublish.tools
{
	import cn.vision.errors.SingleTonError;
	import cn.vision.pattern.core.Command;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	
	
	[Event(name="complete", type="flash.events.Event")]
	
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	
	public class ScaleBmdMultiThread extends EventDispatcher
	{
		
		
		[Embed(source="ScaleBmdThread.swf", mimeType="application/octet-stream")]
		public static const Thread:Class;
		
		public function ScaleBmdMultiThread()
		{
			super();
			
			if (!instance)
			{
				//Create worker from our own loaderInfo.bytes
				worker = WorkerDomain.current.createWorker(new Thread);
				
				//Create messaging channels for 2-way messaging
				mainToWorker = Worker.current.createMessageChannel(worker);
				workerToMain = worker.createMessageChannel(Worker.current);
				
				//Inject messaging channels as a shared property
				worker.setSharedProperty("mainToWorker", mainToWorker);
				worker.setSharedProperty("workerToMain", workerToMain);
				
				//Listen to the response from our worker
				workerToMain.addEventListener(Event.CHANNEL_MESSAGE, onWorkerToMain);
				
				//Start worker (re-run document class)
				worker.start();
			}
			else
			{
				throw new SingleTonError(this);
			}
			
			
		}
		
		
		public static const instance:ScaleBmdMultiThread = new ScaleBmdMultiThread;
		
		
		
		public function process($bmd:BitmapData, $scale:Number = 1, $smooth:Boolean = true):void
		{
			if(!processing && $bmd)
			{
				processing = true;
				bytes = new ByteArray;
				bytes.shareable = true;
				$bmd.copyPixelsToByteArray($bmd.rect, bytes);
				
				oriWidth  = $bmd.width;
				oriHeight = $bmd.height;
				scaWidth  = oriWidth  * $scale;
				scaHeight = oriHeight * $scale;
				
				worker.setSharedProperty("bytes" , bytes);
				worker.setSharedProperty("scale" , $scale);
				worker.setSharedProperty("width" , oriWidth);
				worker.setSharedProperty("height", oriHeight);
				worker.setSharedProperty("smooth", $smooth);
				
				mainToWorker.send("PROCESS");
			}
		}
		
		
		//Worker >> Main
		protected function onWorkerToMain(event:Event):void {
			//Trace out whatever message the worker has sent us.
			message = workerToMain.receive();
			
			if (message == "COMPLETE")
			{
				var bytes:ByteArray = worker.getSharedProperty("result");
				
				processing = false;
				if (bytes)
				{
					bitmapData = new BitmapData(scaWidth, scaHeight, false, 0XFFFFFF);
					bitmapData.setPixels(bitmapData.rect, bytes);
					
					dispatchEvent(new Event(Event.COMPLETE));
				}
				else
				{
					dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
				}
			}
			
		}
		
		
		public var message:String;
		
		public var bitmapData:BitmapData;
		
		private var oriWidth:Number;
		
		private var oriHeight:Number;
		
		private var scaWidth:Number;
		
		private var scaHeight:Number;
		
		private var processing:Boolean;
		
		private var bytes:ByteArray;
		
		private var worker:Worker;
		
		private var mainToWorker:MessageChannel;
		
		private var workerToMain:MessageChannel;
		
	}
}