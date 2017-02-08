package multipublish.commands
{
	
	/**
	 * 
	 * 初始化数据。
	 * 
	 */
	
	import cn.vision.utils.FileUtil;
	
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MDProvider;
	import multipublish.utils.ScheduleUtil;
	import multipublish.utils.ViewUtil;
	import multipublish.vo.Channel;
	
	
	public final class InitDataCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function InitDataCommand()
		{
			super();
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			if(!executing)
			{
				commandStart();
				
				initData();
			}
		}
		
		
		override public function close():void
		{
			if (executing)
			{
				if (provider.channelNow)
					provider.channelNow.removeEventListener(ControlEvent.INIT, channelNow_initHandler);
				if (provider.channelNew)
					provider.channelNew.removeEventListener(ControlEvent.INIT, channelNew_initHandler);
				
				commandEnd();
			}
		}
		
		
		/**
		 * @private
		 */
		private function initData():void
		{
			//如果存在当前排期，则不显示引导界面。
			if (provider.channelNow) ViewUtil.guild(false);
			
			modelog("初始化排期，下载文件。");
			
			//如果当前排期缓存存在，则解析当前排期缓存，当前排期的素材不论下载完成与否，都加入非等待队列
			var channelNow:String = getChannel(DataConsts.CHANNEL_NOW);
			
			//设定当前排期必须满足两个条件：
			//1.当前排期缓存存在，即channel.dat文件存在，此函数会作为参数传入。
			//2.当前排期数据结构为空，即provider.channelNow == null。
			if(!provider.channelNow && channelNow) 
			{
				channelNowInited = false;
				schedulePlayable = true;
				provider.channelNow = new Channel(channelNow, "channel", false);
				provider.channelNow.addEventListener(ControlEvent.INIT, channelNow_initHandler);
			}
			
			if (config.replacable)
			{
				//如果上一次发送的新排期仍然存在，要清除上一次新排期所需要下载的文件。
				if (provider.channelNew) Cache.clear(provider.channelNew.cacheGroup);
				
				//如果新排期缓存存在，则解析新排期缓存，且新排期的素材必须加入等待队列
				var channelNew:String = getChannel(DataConsts.CHANNEL_NEW);
				if (channelNew) 
				{
					channelNewInited = false;
					//如果当前排期不存在，则将报纸等数据加入等待队列
					var resolveWait:Boolean = !Boolean(provider.channelNow);
					provider.channelNew = new Channel(channelNew, "channel", true, resolveWait);
					provider.channelNew.addEventListener(ControlEvent.INIT, channelNew_initHandler);
				}
				
			}
			
			//如果当前排期与新排期都没有，表示没有任何数据，直接结束。
			if (!provider.channelNow && !provider.channelNew) commandEnd();
		}
		
		
		/**
		 * @private
		 * 设定当前排期必须满足两个条件：
		 * 1.当前排期缓存存在，即channel.dat文件存在，此函数会作为参数传入。
		 * 2.当前排期数据结构为空，即provider.channelNow == null。
		 */
		private function channelNowReplacable($channelNowData:String):Boolean
		{
			return provider.channelNow == null && $channelNowData;
		}
		
		
		/**
		 * @private
		 * 获取频道数据。
		 */
		private function getChannel($path:String):String
		{
			return FileUtil.readUTF(FileUtil.resolvePathApplication($path));
		}
		
		
		/**
		 * @private
		 */
		private function channelNow_initHandler($e:ControlEvent):void
		{
			provider.channelNow.removeEventListener(ControlEvent.INIT, channelNow_initHandler);
			
			channelNowInited = true;
			
			if(!provider.channelNew || channelNewInited) commandEnd();
		}
		
		/**
		 * @private
		 */
		private function channelNew_initHandler($e:ControlEvent):void
		{
			provider.channelNew.removeEventListener(ControlEvent.INIT, channelNew_initHandler);
			
			channelNewInited = true;
			
			if(!provider.channelNow || channelNowInited) commandEnd();
		}
		
		
		
		override protected function commandEnd():void
		{
			if (executing)
			{
				//新排期如果没有需要下载的素材，则需要将新排期替换老排期
				if (Cache.waitLave == 0) 
				{
					//如果排期被替换，则需要重新播放排期
					var scheduleChanged:Boolean = ScheduleUtil.changeChannel();
				}
				
				//满足以下条件都需要播放排期
				//1.第一次启动有当前排期
				//2.收到新的排期，且没有任何素材需要下载
				if (scheduleChanged || schedulePlayable)
					ViewUtil.playSchedule(true);
				
				super.commandEnd();
			}
		}
		
		
		/**
		 * @private
		 */
		private var provider:MDProvider = MDProvider.instance;
		
		/**
		 * @private
		 */
		private var channelNowInited:Boolean = true;
		
		/**
		 * @private
		 */
		private var channelNewInited:Boolean = true;
		
		/**
		 * 如果启动时有当前排期，则可以播放排期。
		 * @private
		 */
		private var schedulePlayable:Boolean;
		
	}
}