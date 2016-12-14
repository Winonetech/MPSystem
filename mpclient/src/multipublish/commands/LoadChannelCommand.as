package multipublish.commands
{
	
	/**
	 * 
	 * 加载频道数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.tools.LogSQLite;
	
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
			
			config.controller.removeControlUsecache();
			model = new Model;    //执行 url并存储数据。
			model.url = config.cache ? DataConsts.PATH_CHANNEL : url;
			model.addEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
			model.execute();
		}
		
		/**
		 * @private
		 */
		private function model_commandEndHandler($e:CommandEvent):void
		{
			//判定是否与上一次的排期相等
			if (config.ori["channel"]!= model.data)
			{
				config.ori["channel"] = model.data;  
				config.replacable = true;
				var dat:Object = ObjectUtil.convert(model.data, Object);
				var url:String = DataConsts.PATH_CHANNEL;
				model.extra.url = (url != model.url) ? model.url : model.extra.url;
				if (dat)
				{
					model.removeEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
					
					flagSave(model.url, url, JSON.stringify(dat, null, "\t"));
					
					config.raw["channel"] = dat;
					
					commandEnd();
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
				config.replacable = false;
				modelog(model.data ? "与上一次的排期数据相同。" : "排期数据为空。");
				commandEnd();
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
		
	}
}