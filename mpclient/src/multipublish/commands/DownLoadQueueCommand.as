package multipublish.commands
{
	
	/**
	 *
	 * 下载队列命令。
	 * 执行发送和接收，当参数为空时表示向服务端请求下载。
	 * 
	 */
	
	
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.ParallelQueue;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.Cache;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MDProvider;
	import multipublish.tools.MPService;
	import multipublish.utils.ViewUtil;
	
	
	public final class DownLoadQueueCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function DownLoadQueueCommand($cmd:String = null)
		{
			super();
			
			cmd = $cmd;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			ViewUtil.playSchedule(true);
			
			cmd ? resolve() : send();
			
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function close():void
		{
			if (executing)
			{
				waitQueue.removeEventListener(QueueEvent.QUEUE_END, wait_endHandler);
				unwaitQueue.removeEventListener(QueueEvent.QUEUE_END, unwait_endHandler);
				
				ViewUtil.showDownload(false);
				
				ViewUtil.showTree(false);
				
				commandEnd();
			}
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
			
			//如果是start表示开始下载，如果是delay，表示排队等待下载。
			state.toLowerCase() == "start" ? resolveStart(args) : resolveDelay(args);
		}
		
		
		/**
		 * 
		 * 解析开始下载的命令参数。
		 * 
		 */
		
		private function resolveStart($args:String):void
		{
			if ($args)   //传入参数表示使用子FTP地址
			{
				var temp:Array = trimBracket($args).split(",");
				Cache.deftp(temp[0], temp[1], temp[2], temp[3]);
			}
			else	//不传参数表示默认用主服务器地址(主服务器)。
			{
				Cache.deftp(
					config.ftpHost, 
					config.ftpPort, 
					config.ftpUserName, 
					config.ftpPassWord);
			}
			
			//开始下载时再注册监听。
			if (waitQueue.lave)
				waitQueue.addEventListener(QueueEvent.QUEUE_END, wait_endHandler, false, 0, true);
			if (unwaitQueue.lave)
				unwaitQueue.addEventListener(QueueEvent.QUEUE_END, unwait_endHandler, false, 0, true);
			
			//展示下载提示框。
			if (config.downloadState && Cache.waitLave) ViewUtil.showDownload(true);
			
			Cache.start();
			
		}
		
		/**
		 * @private
		 * 去除字符串的首尾中括号([])。
		 */
		private function trimBracket($str:String):String
		{
			$str = $str.replace(/^\[*/, "");
			$str = $str.replace(/\]*$/, "");
			
			return $str;
		}
		
		/**
		 * @private
		 * 解析排队状态。
		 */
		private function resolveDelay($args:String):void
		{
			if (config.downloadState)
			{
				var temp:Array = $args.split("/");
				var message:String = "正在排队...当前共有" + temp.pop() +
					"个终端正在排队，您前面还有" + temp.shift() + "台。"
				ViewUtil.showDownload(true, message);
			}
			
			commandEnd();
		}
		
		/**
		 * @private
		 * 发送下载申请并初始化状态栏。
		 */
		private function send():void
		{
			LogUtil.log("需要等待下载的个数  -> " + Cache.waitLave);
			LogUtil.log("不需要等待的下载个数 -> " + Cache.unwaitLave);
			
			if (Cache.hasDownload)
			{
				service.downloadApply();
				
				if(!provider.channelNow && Cache.waitLave > 0) //如果当前无排期，且有新的排期素材需要下载
				{
					//显示下载树。
					ViewUtil.guild(false);
					
					ViewUtil.showTree(true);
				}
			}
			else
			{
				if (provider.channelNew)
				{
					changeChannel();
				}
				else
				{
					if(!provider.channelNow) modelog("没有节目");
				}
			}
			
			commandEnd();
		}
		
		/**
		 * @private
		 * 下载结束。
		 */
		private function downloadOver():void
		{
			service.downloadOver();
			
			changeChannel();
			
			commandEnd();
		}
		
		/**
		 * @private
		 * 切换排期。
		 */
		private function changeChannel():void
		{
			provider.channelNow = provider.channelNew;
			
			provider.channelNew = null;
			
			FileUtil.moveFile(
				FileUtil.resolvePathApplication(DataConsts.CHANNEL_NEW),
				FileUtil.resolvePathApplication(DataConsts.CHANNEL_NOW), true);
			
			ViewUtil.playSchedule(true);
		}
		
		
		/**
		 * @private
		 */
		private function wait_endHandler(e:QueueEvent):void
		{
			waitQueue.removeEventListener(QueueEvent.QUEUE_END, wait_endHandler);
			
			//隐藏下载树视频
			ViewUtil.showTree(false);
			
			ViewUtil.showDownload(false);
			
			//新排期下载完毕，替换老排期
			
			if (unwaitQueue.lave + unwaitQueue.num == 0) downloadOver();
		}
		
		
		/**
		 * @private
		 */
		private function unwait_endHandler(e:QueueEvent):void
		{
			unwaitQueue.removeEventListener(QueueEvent.QUEUE_END, unwait_endHandler);
			
			if (waitQueue.lave + waitQueue.num == 0) downloadOver();
		}
		
		
		/**
		 * @private
		 */
		private function get waitQueue():ParallelQueue
		{
			return Cache.queue;
		}
		
		/**
		 * @private
		 */
		private function get unwaitQueue():ParallelQueue
		{
			return Cache.queue_sp;
		}

		
		/**
		 * @private
		 */
		private var service:MPService = config.service;
		
		/**
		 * @private
		 */
		private var provider:MDProvider = MDProvider.instance;
		
		/**
		 * @private
		 */
		private var cmd:String;
		
	}
}