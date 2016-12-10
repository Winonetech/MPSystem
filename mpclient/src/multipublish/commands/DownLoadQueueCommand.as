package multipublish.commands
{
	import cn.vision.events.pattern.QueueEvent;
	
	import com.winonetech.tools.Cache;
	
	import multipublish.events.DLStateEvent;
	import multipublish.tools.MPService;
	import multipublish.utils.ViewUtil;
	
	import spark.components.Image;
	
	/**
	 *
	 * 下载队列命令。
	 * 执行发送和接收，当参数为空时表示发送至服务端。
	 * 
	 */
	
	public final class DownLoadQueueCommand extends _InternalCommand
	{
		
		
		public function DownLoadQueueCommand($cmd:String = null)
		{
			super();
			
			initialize($cmd);
		}
		
		private function initialize($cmd:String):void
		{
			cmd = $cmd;
			
			if (view.progress.isDownloading)
			{
				Cache.queue.removeEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);
				view.progress.isDownloading = false;
			}
		}
		
		
		override public function execute():void
		{
			commandStart();
			
			cmd ? resolve() : send();
			
			commandEnd();
		}
		
		/**
		 * 
		 * 解析命令。
		 * 
		 */
		
		private function resolve():void
		{
			var tempCmd:Array = cmd.split("-");
			var args :String = tempCmd.pop();
			var state:String = tempCmd.shift();
			
			state.toLowerCase() == "start" ? resolveStart(args) : resolveDelay(args);
		}
		
		
		/**
		 * 
		 * 解析开始下载的命令参数。
		 * 
		 */
		
		private function resolveStart($args:String):void
		{
			if ($args)   //不传参数表示默认用原来的 (主服务器)。
			{
				var temp:Array = trimBracket($args).split(",");
				Cache.deftp(
					temp[0], 
					temp[1], 
					temp[2], 
					temp[3]);
			}
			else
			{
				Cache.deftp(
					config.ftpHost, 
					config.ftpPort, 
					config.ftpUserName, 
					config.ftpPassWord);
			}
			Cache.queue.addEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);
			view.progress.isDownloading = true;
			if (config.downloadState) view.progress.stateLabel.text = "下载中...";
			view.progress.play();
		}
		
		/**
		 * 
		 * 去除字符串的首尾中括号([])。
		 * 
		 */
		
		private function trimBracket($str:String):String
		{
			const REMOVE_B:RegExp = /^\[*/;
			const REMOVE_E:RegExp = /\]*$/;
			
			$str = $str.replace(REMOVE_B, "");
			$str = $str.replace(REMOVE_E, "");
			
			return $str;
		}
		
		/**
		 * 
		 * 解析排队状态。
		 * 
		 */
		
		private function resolveDelay($args:String):void
		{
			if (config.downloadState)
			{
				var temp:Array = $args.split("/");
				view.progress.stateLabel.text = "正在排队...当前共有" + temp.pop() +
					"个终端正在排队，您前面还有" + temp.shift() + "台。";
			}
		}
		
		/**
		 * 
		 * 发送下载申请并初始化状态栏。
		 * 
		 */
		
		private function send():void
		{
			trace(Cache.cachesLave);
			if (Cache.cachesLave > 0)
			{
				service.downloadApply();
				initDLState();
			}
			else
			{
				view.progress.dispatchEvent(new DLStateEvent(DLStateEvent.FINISH));
			}
		}
		
		
		private function handler_QueueEnd(e:QueueEvent):void
		{
			Cache.queue.removeEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);
			
			service.downloadOver();

			view.application.removeElement(image);
			view.progress.isDownloading = false;
			view.progress.dispatchEvent(new DLStateEvent(DLStateEvent.FINISH));
			
			if (view.application.contains(view.progress))
				view.application.removeElement(view.progress);
//			view.progress = null;
		}
		
		/**
		 * 
		 * 下载状态初始化。
		 * 
		 */
		
		private function initDLState():void
		{
			if (!image)
			{
				initImage(); 
			
				view.application.addElement(image);
			}
			
			if (config.downloadState) initProgress();
			
			ViewUtil.guild(false);
		}
		
		/**
		 * 
		 * 初始化状态栏。
		 * 
		 */
		
		private function initProgress():void
		{
			view.application.addElement(view.progress);
			view.progress.x = view.progress.y = 0;
			view.progress.stateLabel.text = "下载准备中 请稍候...";
		}
		
		
		/**
		 * 
		 * 初始化图片。
		 * 
		 */
		
		private function initImage():void
		{
			image = new Image;
			image.width = view.application.width;
			image.height = view.application.height;
			image.x = image.y = 0;
			image.source = "assets/images/welcomePic.png";
		}
		
		private var service:MPService = config.service;
		
		private var cmd:String;
		
		private var image:Image;
		
	}
}