package multipublish.commands
{
	
	/**
	 * 
	 * 加载频道数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	
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
			
			//获取当前排期数据。
			channelNow = readChannelNow();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			//删除使用缓存注册。
			config.controller.removeControlUsecache();
			
			//加载新的排期数据。
			loadChannelNew();
		}
		
		
		/**
		 * @private
		 */
		private function readChannelNow():Object
		{
			var temp:String = FileUtil.readUTF(FileUtil.resolvePathApplication(DataConsts.CHANNEL_NOW));
			if (temp) var result:Object = ObjectUtil.convert(temp, Object);
			return result;
		}
		
		/**
		 * @private
		 */
		private function loadChannelNew():void
		{
			modelog("加载频道数据。");
			
			model = new Model;    //执行 url并存储数据。
			
			model.url = url;
			
			model.addEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
			model.execute();
		}
		
		
		/**
		 * @private
		 */
		private function model_commandEndHandler($e:CommandEvent):void
		{
			var channelNew:Object = ObjectUtil.convert(model.data, Object);
			if (channelNew)
			{
				//当新排期数据有效且与老排期不同，则需要保存新排期数据。
				if(!ObjectUtil.compare(channelNow, channelNew))
					FileUtil.saveUTF(FileUtil.resolvePathApplication(DataConsts.CHANNEL_NEW), String(model.data));
				else
					modelog("与上一次的排期数据相同。");
			}
			else
			{
				//加载到的排期数据无效。
				LogSQLite.log(TypeConsts.FILE,
					EventConsts.EVENT_LOAD_ERROR, model.extra.url,
					LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_CHANNEL));
			}
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private var channelNow:Object;
		
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