package multipublish.commands
{
	
	/**
	 * 
	 * 播放排期。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.core.MDProvider;
	import multipublish.tools.Controller;
	import multipublish.utils.ScheduleUtil;
	import multipublish.utils.ViewUtil;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class PlaybackScheduleCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>PlaybackScheduleCommand</code>构造函数。
		 * 
		 */
		
		public function PlaybackScheduleCommand($note:Boolean = true)
		{
			super();
			
			initialize($note);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			if (config.replacable)
			{
				if (config.importData || 
					config.loadable || 
					config.cache)
				{
					noteSchedule();
					playbackSchedule();
				}
			}
			
			config.replacable = true;
			
			commandEnd();
 		}
		
		
		/**
		 * @private
		 */
		private function initialize($note:Boolean):void
		{
			note = $note;
		}
		
		/**
		 * @private
		 */
		private function noteSchedule():void
		{
			if (note)
			{
				controller.removeControlAllBroadcast();
				var schedules:Object = provider.schedulesMap;
				for each (var schedule:Schedule in schedules)
				{
					if (ScheduleUtil.validateScheduleInArchive(schedule))  //验证排期的日期。轮播直接返回 true。
					{
						if ((schedule.type == ScheduleTypeConsts.DEMAND) || 
							(schedule.type == ScheduleTypeConsts.SPOTS)  || 
							(schedule.type == ScheduleTypeConsts.REPEAT  && 
							!schedule.repeatWholeDay))
						{
							//轮播、默认是不需要注册时间点。重复类型如果是全天播放也不需要注册时间点。
							controller.registControlBroadcast(schedule.startTime, presenter.broadcastProgram);
							controller.registControlBroadcast(schedule.endTime  , presenter.broadcastProgram);
						}
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		private function playbackSchedule():void
		{
			config.cache = false;

			var schedules:Map = provider.schedulesMap;
			
			for each (var schedule:Schedule in schedules)
			{
				//PS:此处只修复了每周 每月的 BUG。如果新增加了每年请进入修改。
				if (ScheduleUtil.validateScheduleAvailable(schedule) && 
					ScheduleUtil.compareSchedules(current, schedule))
				{
					var current:Schedule = schedule;
//					config.latest = schedule;
				}
			}
			
			if (current) 
			{
				playSchedules(current);
			}
//			else if (schedules.length > 0)
			else
			{
//				playSchedules(findLatest(schedules));
				modelog(ClientStateConsts.BROD_NOPR);
			}
		}
		
		private function playSchedules($data:Schedule):void
		{
			ViewUtil.guild(false);
			
			if (view.installer && view.application.contains(view.installer))
			{
				view.application.removeElement(view.installer);
				view.installer = null;
			}
			if (view.main)
			{
				view.main.enabled = true;
				view.main.data = $data;  //调用 data的 setter函数 会触发其 resolveData (MainView)
			}
		}
		
		
		/*
		private function findLatest(schedules:Map):Schedule
		{
			var result:Schedule;
			for each (var schedule:Schedule in schedules)
			{
				if (compareScdDate(schedule, result)) 
				{
					result = schedule;
					config.latest = schedule;
				}
			}
			return result || config.latest;
		}
		*/
		
		/**
		 * @private
		 * 用以比较排期开始时间(日期+时间)。
		 * $a比$b早，则返回为true。
		 */
		/*
		private function compareScdDate($a:Schedule, $b:Schedule):Boolean
		{
			var date:Date = new Date;
			//结束日期必须大于当前日期，否则视为无效排期。
		   //此处不比较时间是因为重复的特殊性。
			if (DateUtil.compareDate_SP($a.endDate, date) == -1) return false;
			
			
			//日期的筛选。
			if ($a.type == ScheduleTypeConsts.DEMAND)  //点播只需判定日期符合即可。
			{
				if (!$b) return true;
			}
			else if ($a.type == ScheduleTypeConsts.REPEAT)      //重复则需要判定今天是否满足重复条件。
			{
				switch ($a.extra.repeatType)
				{
					case ScheduleRepeatTypeConsts.DAY : 	//每天重复不需要判定当天。
						if (!$b) return true;
						break;
					case ScheduleRepeatTypeConsts.WEEK :		//每周重复需要判定当天日期是否在档。
						if ($a.extra.weekDays.indexOf(date.day) != -1)
						{
							if (!$b) return true;
						}
						else return false;
						break;
					case ScheduleRepeatTypeConsts.MONTH :   //每月重复需要判定当天日期是否在档。
						if ($a.extra.monthDay == date.date)
						{
							if (!$b) return true;
						}
						else return false;
						break;
				}
			 }
			
			
			var ta:Date = $a.startTime;
			var tb:Date = $b.startTime;
			
			var dateA:Date = new Date(date.fullYear, date.month, date.date, ta.hours, ta.minutes, ta.seconds);
			var dateB:Date = new Date(date.fullYear, date.month, date.date, tb.hours, tb.minutes, tb.seconds);
			
			return dateA.time < dateB.time && dateA.time > date.time;     //时间已过的排期不能用于播放。
		}
		*/
		
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
		private function get provider():MDProvider
		{
			return MDProvider.instance;
		}
		
		
		/**
		 * @private
		 */
		private var note:Boolean;
		
	}
}