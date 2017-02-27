package multipublish.commands.steps
{
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.XMLUtil;
	
	import multipublish.commands.Step;
	import multipublish.consts.URLConsts;
	
	public final class FinanceUpdate extends Step
	{
		public function FinanceUpdate()
		{
			super();
		}
		
		
		override public function execute():void
		{
			commandStart();
			
			load();
		}
		
		
		private function load():void
		{
			model = new Model;
			model.url = "http://" + config.httpHost + ":" + (config.httpPort || 80) + URLConsts.GET_FINANCE_DATA;
			model.addEventListener(CommandEvent.COMMAND_END, modelHandler);
			model.execute();
		}
		
		
		private function modelHandler($e:CommandEvent):void
		{
			var xml:XML = XMLUtil.convert(model.data, XML);
			var url:String = URLConsts.FINANCEDATA;
			if (xml)
			{
				model.removeEventListener(CommandEvent.COMMAND_END, modelHandler);
				save(url, xml);
			}
			commandEnd();
		}
		
		private var model:Model;
	}
}