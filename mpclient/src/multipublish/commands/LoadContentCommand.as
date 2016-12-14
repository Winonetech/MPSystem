package multipublish.commands
{
	
	/**
	 * 
	 * 加载内容数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.steps.Model;
	import multipublish.consts.DataConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;

	
	public final class LoadContentCommand extends Step
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function LoadContentCommand($url:String = null)
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
			model = new Model;
			model.url = config.cache ? DataConsts.PATH_CONTENT : url;
			model.addEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
			model.execute();
		}
		
		/**
		 * @private
		 */
		private function model_commandEndHandler($e:CommandEvent):void
		{
			var dat:Object = ObjectUtil.convert(model.data, Object);
			var url:String = DataConsts.PATH_CONTENT;
			model.extra.url = (url != model.url) ? model.url : model.extra.url;
			if (dat)
			{
				model.removeEventListener(CommandEvent.COMMAND_END, model_commandEndHandler);
				
				flagSave(model.url, url, dat);
				
				config.raw["content"] = dat;
				
				commandEnd();
			}
			else
			{
				if (model.url!= url)
				{
					model.url = url;
					model.execute();
				}
				else 
				{
					LogSQLite.log(
						TypeConsts.FILE,
						EventConsts.EVENT_LOAD_ERROR,
						model.extra.url,
						LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_CHANNEL));
					
					commandEnd();
				}
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