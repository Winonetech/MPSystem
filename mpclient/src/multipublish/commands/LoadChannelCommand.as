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
	
	import com.winonetech.controls.Field;
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
			
			//保证只有收到新排期或者无排期的时候才会进入。
          	if (!config.cache && File.applicationDirectory.
				resolvePath(DataConsts.PATH_CHANNEL).exists &&
				url != "fromDelay")
			{
				config.cache = true;  
				
				var delay:Function = function($time:Number, $f:Function):void
				{
					var timer:Timer = new Timer($time * 1000, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, $f);
					timer.start();
				};
				
				var f1:Function = function(e:TimerEvent):void
				{
					delayModel.execute();
				}
				
				
				InitDelayModuleCommand.count = 0;
				
				count++;
				
				delayModel = new Model;
				
				delayModel.url = url;
				delayModel.addEventListener(CommandEvent.COMMAND_END, delayModel_commandEndHandler);
				delay(.5, f1);
			}
			
			//只要进了上面的 if就必须进此处的 else之一。
			if (count == 0 && File.applicationDirectory.
				resolvePath(DataConsts.PATH_CHANNEL).exists && url == "fromDelay")
			{
				//进入此处的可能有：
			    //1.已下载完成 new排期但需要对其进行解析。
				
				delayModel = new Model;
				delayModel.url = DataConsts.NEW_CHANNEL;
				
				count++;
				InitDelayModuleCommand.count = 1;
				
				delayModel.addEventListener(CommandEvent.COMMAND_END, delayModel_commandEndHandler);
				delayModel.execute();	
			}
			else if (!File.applicationDirectory.resolvePath(DataConsts.NEW_CHANNEL).exists && !config.view.main.data)
			{
				//进入此处的可能有：
				//1.开机时未收到排期故而需要调用本地缓存。
				//2.无节目时读取老排期的时候。
				//3.无老排期时。
				
				model = new Model;    //执行 url并存储数据。
				
				model.url = config.cache ? DataConsts.PATH_CHANNEL : url;
				
				count++;
				
				model.addEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
				model.execute();
			}
			else
			{
				//进入此处的可能有：
				//1.在解析下载新排期时收到新的排期的时候。需要替换原来的新排期。
				
				if (File.applicationDirectory.resolvePath(DataConsts.NEW_CHANNEL).exists)
				{
					var f:File = new File(File.applicationDirectory.
						resolvePath(DataConsts.NEW_CHANNEL).nativePath);
					
					f.deleteFile();
				}
				
				config.replacable = false;   //此处设置为 false是为了保证不要正在播放的节目再切换一遍。
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
				if (!File.applicationDirectory.resolvePath(url).exists)
				{
//					flagSave(delayModel.url, url, JSON.stringify(dat, null, "\t"));
					FileUtil.saveUTF(FileUtil.resolvePathApplication(url), JSON.stringify(dat, null, "\t"));
					if (count == 0) commandEnd();
				}
				else
				{
					config.controller.removeControlUsecache();
					Cache.queue.clear();       //停止正在下载 /预备下载的命令。
					Cache.queue_sp.clear();

					config.replacable = !FileUtil.compareFile(
						File.applicationDirectory.resolvePath(DataConsts.PATH_CHANNEL),
						File.applicationDirectory.resolvePath(DataConsts. NEW_CHANNEL));
					
					config.ori["channel"] = delayModel.data; 
					config.raw["channel"] = dat;
					
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
				
				if (File.applicationDirectory.resolvePath(DataConsts.NEW_CHANNEL).exists)
				{
					var f:File = new File(File.applicationDirectory.
						resolvePath(DataConsts.NEW_CHANNEL).nativePath);
					
					f.deleteFile();
				}
				
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