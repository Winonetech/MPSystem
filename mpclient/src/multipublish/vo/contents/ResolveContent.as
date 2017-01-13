package multipublish.vo.contents
{
	
	/**
	 * 
	 * 需要解析的内容数据类型。
	 * 
	 */
	
	
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.Base64Util;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	use namespace wt;
	
	
	public class ResolveContent extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ResolveContent($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			remoteURL = getProperty("contentSource");
			localURL = StringUtil.replace(CacheUtil.extractURI(remoteURL, PathConsts.PATH_FILE), "?", "-");
			localURL = StringUtil.replace(localURL, "=", "-");
			localURL = StringUtil.replace(localURL, "&", "-");
			
			resolveContentSource(remoteURL);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override wt function registCache(...$args):void
		{
			for each (var item:* in $args)
			{
				var cache:Cache = (item is String) ? Cache.cache(item, inited) : item;
				if (cache && ! cach[cache.saveURL] && !cache.exist)
				{
					var handler:Function = function($e:CommandEvent):void
					{
						var cache:Cache = Cache($e.command);
						cache.removeEventListener(CommandEvent.COMMAND_END, handler);
						
						delete cach[cache.saveURL];
						if (ready) dispatchEvent(new ControlEvent(ControlEvent.READY));
					};
					cache.addEventListener(CommandEvent.COMMAND_END, handler);
					cach[cache.saveURL] = cache;
				}
			}
			
			if (cach.length) dispatchEvent(new ControlEvent(ControlEvent.DOWNLOAD));  //当有需要下载的文件时，发送下载命令。
		}
		
		
		/**
		 * 
		 * 加载数据
		 * 
		 */
		
		protected function loadContent($url:String, $useCache:Boolean = false, $method:String = "GET", $args:Object = null):void
		{
			resolved = false;
			tip = {};
			tip.title = "提示";
			tip.message = title + " 正在加载数据，请稍后...";
			
			LogUtil.log(title + "加载数据：" + $url);
			
			http = new HTTPService;
			http.addEventListener(ResultEvent.RESULT, http_defaultHandler);
			http.addEventListener(FaultEvent.FAULT, http_defaultHandler);
			http.method = $method;
			http.requestTimeout = 10;
			http.url = $url;
			http.resultFormat
			http.contentType = "application/json; charset=utf-8";
			
			if ($args)
				http.send(JSON.stringify($args));
			else
				http.send();
			
			//createTimer(30);
		}
		
		
		/**
		 * 
		 * 解析内容资源。
		 * 
		 */
		
		protected function resolveContentSource($content:*):void
		{
			
		}
		
		
		/**
		 * 
		 * 解析数据
		 * 
		 */
		
		protected function analyzeContent($data:Object):void
		{
			
		}
		
		
		/**
		 * 
		 * 处理结果
		 * 
		 */
		
		protected function processResult($success:Boolean, $data:* = null):void
		{
			if ($success)
			{
				try
				{
					if (http.url!= localURL)
						FileUtil.saveUTF(FileUtil.resolvePathApplication(localURL), $data);
					
					$data = Base64Util.decode($data);
					
					var data:Object = $data is String ? JSON.parse($data) : $data;
				}
				catch(o:Error)
				{
					LogUtil.log(title + "解析JSON出错：", o.message, $data);
				}
				analyzeContent(data);
			}
			else
			{
				time = 0;
				tip = tip || {};
				tip.title = "错误";
				
				if (http.url != localURL)
				{
					LogUtil.log(tip.message = title + "加载数据出错：" + http.url);
					LogUtil.log(title + "尝试加载本地缓存：" + localURL);
					loadContent(localURL, true);
				}
				else
				{
					LogUtil.log(tip.message = title + "加载数据出错：" + remoteURL, localURL);
					dispatchEvent(new ControlEvent(ControlEvent.ERROR, tip.message));
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function createTimer(repeat:uint):void
		{
			if(!timer)
			{
				timer = new Timer(1000, repeat);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
				timer.start();
			}
		}
		
		/**
		 * @private
		 */
		private function removeTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
				timer = null;
			}
		}
		
		
		/**
		 * @private
		 */
		private function http_defaultHandler(e:Event):void
		{
			http.removeEventListener(ResultEvent.RESULT, http_defaultHandler);
			http.removeEventListener(FaultEvent.FAULT, http_defaultHandler);
			
			removeTimer();
			
			var bool:Boolean = e.type == ResultEvent.RESULT;
			processResult(bool, bool ? (e as ResultEvent).result : null);
		}
		
		/**
		 * @private
		 */
		private function timer_completeHandler(e:TimerEvent):void
		{
			var fault:Fault = new Fault("6001", "请求超时", remoteURL);
			http_defaultHandler(new FaultEvent(FaultEvent.FAULT, false, false));
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function get ready():Boolean
		{
			return super.ready && resolved;
		}
		
		
		/**
		 * 
		 * 是否已解析完毕所有的内容。
		 * 
		 */
		
		protected var resolved:Boolean = true;
		
		
		/**
		 * @private
		 */
		protected var inited:Boolean;
		
		/**
		 * @private
		 */
		private var localURL:String;
		
		/**
		 * @private
		 */
		private var remoteURL:String;
		
		/**
		 * @private
		 */
		private var time:int;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		protected var temp:int;
		
		/**
		 * @private
		 */
		private var http:HTTPService;
		
	}
}