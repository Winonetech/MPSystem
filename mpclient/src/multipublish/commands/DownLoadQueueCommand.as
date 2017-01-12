package multipublish.commands
{
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.utils.LogUtil;
	
	import com.rubenswieringa.book.limited;
	import com.winonetech.tools.Cache;
	
	import multipublish.consts.ContentConsts;
	import multipublish.events.DLStateEvent;
	import multipublish.tools.MPService;
	import multipublish.utils.ViewUtil;
	
	import spark.components.VideoDisplay;
	
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
			
			if (view.progress.isDownloading && config.replacable)     //如果正在下载时收到排期 应该初始化 isDownloading。 
			{
				Cache.queue.removeEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);
				Cache.queue_sp.removeEventListener(QueueEvent.QUEUE_END, handler_sp);
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
			if ($args)   
			{
				var temp:Array = trimBracket($args).split(",");
				Cache.deftp(
					temp[0], 
					temp[1], 
					temp[2], 
					temp[3]);
			}
			else	//不传参数表示默认用原来的 (主服务器)。
			{
				Cache.deftp(
					config.ftpHost, 
					config.ftpPort, 
					config.ftpUserName, 
					config.ftpPassWord);
			}
			//开始下载时再注册监听。
			Cache.queue.addEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);
			Cache.queue_sp.addEventListener(QueueEvent.QUEUE_END, handler_sp);
			view.progress.isDownloading = true;
			if (config.downloadState && view.progress.stateLabel) view.progress.stateLabel.text = "下载中...";
			view.progress.stop();    //防止下载一半的时候收到排期无法下载。
			view.progress.play();
		}
		
		/**
		 * 
		 * 去除字符串的首尾中括号([])。
		 * 
		 */
		
		private function trimBracket($str:String):String
		{
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
				LogUtil.log("需要下载的个数  -> " + Cache.cachesLave);
				LogUtil.log("是否存在特殊下载队列 -> " + Cache.hasSP);
				
				if (Cache.cachesLave > 0)       //普通队列大于 0则开始下载。
				{
					service.downloadApply();
					initDLState();
				}
				else        
				{
					if(video && view.application.contains(video))   //如果在显示图片时发送新排期且该排期无需下载则清除图片。     
						view.application.removeElement(video);
					
					
					
					if (Cache.hasSP) service.downloadApply();
					view.progress.dispatchEvent(new DLStateEvent(DLStateEvent.FINISH));//普通队列无下载但是新队列有下载，则也需要申请，但无需展示下载中的视频。
				}
		}
		
		/**
		 * 
		 * 下载完毕后的处理方法。
		 *  
		 */
		
		private function handler_QueueEnd(e:QueueEvent):void
		{
			Cache.queue.removeEventListener(QueueEvent.QUEUE_END, handler_QueueEnd);

			
			if (Cache.queue_sp.lave + Cache.queue_sp.num == 0)
			{
				view.progress.isDownloading = false;
		
				service.downloadOver();
				
				view.progress.stop();
			}
			
			
			if(video && view.application.contains(video))
				view.application.removeElement(video);
			
			
			if (view.application.contains(view.progress))
				view.application.removeElement(view.progress);
			
			
			view.progress.dispatchEvent(new DLStateEvent(DLStateEvent.FINISH));
			   
//			view.progress = null;
		}
		
		
		private function handler_sp(e:QueueEvent):void
		{
			Cache.queue_sp.removeEventListener(QueueEvent.QUEUE_END, handler_sp);
			
			service.downloadOver(); 
			if (Cache.queue.lave + Cache.queue.num == 0) 
			{
				view.progress.isDownloading = false;
				
				view.progress.stop();
				
//				view.progress.dispatchEvent(new DLStateEvent(DLStateEvent.FINISH));
			}
		}
		
		/**
		 * 
		 * 下载状态初始化。
		 * 
		 */
		
		private function initDLState():void
		{
			if (!video && !view.main.data)   //当图片不存在(第一次加载)并且主页面无数据(无排期播放)时加入图片。
			{
				initImage(); 
			
				view.application.addElement(video);
			}
			else if (video && view.application.contains(video))
			{
				view.application.removeElement(video);
				if (!video.playing) video.play();
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
			video = new VideoDisplay;
			video.width = view.application.width;
			video.height = view.application.height;
			video.x = video.y = 0;
			video.autoDisplayFirstFrame = true;
			video.autoPlay = true;
			video.loop = true;
			video.scaleMode = "letterbox";
			video.source = ContentConsts.WELCOME_VIDEO;
		}

		
		private static var video:VideoDisplay;
		
		/**
		 * 
		 * 一个计数器。统计发送申请的个数。只处理最后一个。
		 * 
		 */
		
		private static var count:int = 0;
		
		private const REMOVE_B:RegExp = /^\[*/;
		
		private const REMOVE_E:RegExp = /\]*$/;
		
		private var service:MPService = config.service;
		
		private var cmd:String;
		
	}
}