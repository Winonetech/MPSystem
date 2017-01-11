package multipublish.commands
{
	
	/**
	 * 
	 * 加载频道数据。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import multipublish.commands.steps.Model;
	import multipublish.consts.DataConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	
	
	public final class LoadChannelCommand extends Step
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function LoadChannelCommand($url:String = null)
		{
			super();
			
			url = $url;
			
			count = 0;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			loadChannel();
		}
		
		
		/**
		 * @private
		 */
		private function loadChannel():void
		{
			modelog("加载频道数据。");
			config.loadable = true;
			
          	if ((!config.view.main.data && !config.cache && 
				File.applicationDirectory.
				resolvePath(DataConsts.PATH_CHANNEL).exists) ||
				(!config.cache && File.applicationDirectory
					.resolvePath(DataConsts.NEW_CHANNEL).exists))
			{
				//如果无内容播放(终端刚启动时)且不是第一次启动则播放老排期。
				//或者收到新排期时正在 new的下载阶段。
				config.cache = true;  
				
				count++;
				
				delayModel = new Model;
				
				delayModel.url = url;
				delayModel.addEventListener(CommandEvent.COMMAND_END, delayModel_commandEndHandler);
				delayModel.execute();
			}
			
			//如果新排期存在则去读取新排期。否则正常播放。
			if (File.applicationDirectory.
				resolvePath(DataConsts.NEW_CHANNEL).exists)
			{
				if (count != 0)
				{
					var file:File = new File(File.applicationDirectory.
						resolvePath(DataConsts.NEW_CHANNEL).nativePath);
					InitDelayModuleCommand.count = 0;
					if (file.exists) file.deleteFile();
				}
				delayModel = new Model;
				delayModel.url = DataConsts.NEW_CHANNEL;
				
				count++;
				
				delayModel.addEventListener(CommandEvent.COMMAND_END, delayModel_commandEndHandler);
				delayModel.execute();	
			}
			else
			{
				model = new Model;    //执行 url并存储数据。
				
				model.url = config.cache ? DataConsts.PATH_CHANNEL : url;
				
				count++;
				
				model.addEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
				model.execute();
			}
		}
		
		
		private function delayModel_commandEndHandler($e:CommandEvent):void
		{
			delayModel.removeEventListener(CommandEvent.COMMAND_END, delayModel_commandEndHandler);
			
			var dat:Object = ObjectUtil.convert(delayModel.data, Object);
			var url:String = DataConsts.NEW_CHANNEL;
			
			if (dat)
			{
				count--;    //解析成功需要自减。
				
				//新排期存在就不需要再保存了。
				if (!File.applicationDirectory.resolvePath(DataConsts.NEW_CHANNEL).exists)
				{
					flagSave(delayModel.url, url, JSON.stringify(dat, null, "\t"));
					if (count == 0) commandEnd();
				}
				else
				{
					config.controller.removeControlUsecache();
					Cache.queue.clear();       //停止正在下载 /预备下载的命令。
					Cache.queue_sp.clear();
					
					config.ori["channel"] = delayModel.data; 
					config.raw["channel"] = dat;
					config.replacable = true;
					if (count == 0) commandEnd();
				}
				
			}
			else
			{
				LogSQLite.log(TypeConsts.FILE,
					EventConsts.EVENT_LOAD_ERROR, delayModel.url,
					LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_CHANNEL));
				
				commandEnd();
			}
		}
		
		
		/**
		 * @private
		 */
		private function model_commandEndHandler($e:CommandEvent):void
		{
			//判定是否与上一次的排期相等
			if (config.ori["channel"]!= model.data)
			{
				config.controller.removeControlUsecache();
				Cache.queue.clear();       //停止正在下载 /预备下载的命令。
				Cache.queue_sp.clear();
				
				config.ori["channel"] = model.data;  
				config.replacable = true;
				var dat:Object = ObjectUtil.convert(model.data, Object);
				var url:String = DataConsts.PATH_CHANNEL;
				model.extra.url = (url != model.url) ? model.url : model.extra.url;
				if (dat)
				{
					count--;     //解析成功需要自减。
					
					model.removeEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
					
					flagSave(model.url, url, JSON.stringify(dat, null, "\t"));
					
					config.raw["channel"] = dat;
					
					if (count == 0) commandEnd();
				}
				else
				{
					//如果后端接收不到数据，则接收本地缓存。
					if (model.url!= url)
					{
						model.url = url;
						model.execute();
					}
					else 
					{
						LogSQLite.log(TypeConsts.FILE,
							EventConsts.EVENT_LOAD_ERROR, model.extra.url,
							LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_CHANNEL));
						
						commandEnd();
					}
				}
			} 
			else
			{
				count--;     //排期相同需要自减。
				config.replacable = false;
				modelog(model.data ? "与上一次的排期数据相同。" : "排期数据为空。");
				if (count == 0) commandEnd();
			}
		}
		
		
		/**
		 * @private
		 */
		private var url:String;
		
		/**
		 * @private
		 */
		private var model:Model;
		
		private var delayModel:Model;
		
		/**
		 * 
		 * 一个计数。当新老排期都处理完毕后才能发放CommandEnd。
		 * 
		 */
		
		private var count:uint;
	}
}