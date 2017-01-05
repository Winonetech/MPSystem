package multipublish.commands.steps
{
	
	/**
	 * 
	 * 初始化排期数据。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.events.pattern.CommandEvent;
	import cn.vision.utils.DateUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.Step;
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.tools.Controller;
	import multipublish.utils.ScheduleUtil;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class InitializeSchedule extends Step
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function InitializeSchedule()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_SCHE);
			
			load();
		}
		
		
		/**
		 * @private
		 */
		private function load():void
		{
			model = new Model;
			model.url = config.cache ? DataConsts.PATH_SCHEDULE : config.source;
			model.addEventListener(CommandEvent.COMMAND_END, modelHandler);
			model.execute();
		}
		
		/**
		 * @private
		 */
		private function make(xml:XML, saveURL:String, loadURL:String):void
		{
			config.source = XMLUtil.convert(xml["url"]);
			var list:XMLList = xml["schedule"];
			var temp:Object = {};
			var dict:Map = store.clear(Schedule);
			for each (var item:XML in list)
			{
				var type:uint    = XMLUtil.convert(item["type"], uint);
				var spot:Boolean = XMLUtil.convert(item["spot"], Boolean);
				
				//如果是插播类型，需要判断该spot值，是false则代表该插播节目是第一次播放。
				if (type != ScheduleTypeConsts.SPOTS || !spot)
				{
					//由于点播类型排期从当前时间开始播放的特殊性，下发节目到播放会有一定延时，
					//需要自动延期，此时会带来重复加载该排期的新问题，因此，在该类型排期中
					//如果使用过之后，标记spot=true以避免重复插播。
					type == ScheduleTypeConsts.SPOTS && (item["spot"] = true);
					var schedule:Schedule = new Schedule(item);
					if (ScheduleUtil.validateScheduleInArchive(schedule))
					{
						//如果排期未修改，使用历史排期。
						if (dict && dict[schedule.id])
						{
							var olds:Schedule = dict[schedule.id];
							schedule = DateUtil.compare(olds.timeModify, 
								schedule.timeModify) == 0 ? olds : schedule;
							schedule.removeAllPrograms();
						}
						store.registData(schedule);
						var programs:XMLList = item["program"];
						var l:uint = programs ? programs.length() : 0;
						for (var i:int = 0; i < l; i++) 
							push(temp, XMLUtil.convert(programs[i]["id"]), {index:i, schedule:schedule});
					}
				}
			}
			config.temp = temp;
		}
		
		
		/**
		 * @private
		 */
		private function modelHandler($e:CommandEvent):void
		{
			var xml:XML = XMLUtil.convert(model.data, XML);
			var url:String = DataConsts.PATH_SCHEDULE;
			model.extra.tmp = (url != model.url) ? model.url : model.extra.tmp;   //排期获取路径是否为本地。改属性只存 url的加载。
			if (xml)
			{
				model.removeEventListener(CommandEvent.COMMAND_END, modelHandler);
				make(xml, url, model.url);
				if (url != model.url) save(url, xml);
				else flag(url);
				commandEnd();
			}
			else     //如果无法从服务器获取到 则读取本地排期。
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
						EventConsts.EVENT_LOAD_ERROR, model.extra.tmp,
						LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_SCHEDULE));
					
					commandEnd();
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function get controller():Controller
		{
			return config.controller;
		}
		
		
		/**
		 * @private
		 */
		private var model:Model;
		
	}
}