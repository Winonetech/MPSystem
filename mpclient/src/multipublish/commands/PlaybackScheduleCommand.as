package multipublish.commands
{
	
	/**
	 * 
	 * 播放排期。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.ScheduleRepeatTypeConsts;
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.core.mp;
	import multipublish.tools.Controller;
	import multipublish.utils.ScheduleUtil;
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
			
			if (config.mp::scheduled && config.mp::programed)
			{
				if (config.importData || 
					config.loadable || 
					config.cache)
				{
					noteSchedule();
					playbackSchedule();
				}
			}
			
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
				var schedules:Object = config.datas;
				for each (var schedule:Schedule in schedules)
				{
					if (ScheduleUtil.validateScheduleInArchive(schedule))
					{
						if ((schedule.type == ScheduleTypeConsts.DEMAND) || 
							(schedule.type == ScheduleTypeConsts.SPOTS)  || 
							(schedule.type == ScheduleTypeConsts.REPEAT  && 
							(schedule.extra.repeatType == ScheduleRepeatTypeConsts.DAY) && 
							!schedule.allDay))
						{
							controller.registControlBroadcast(schedule.timeStart, presenter.broadcastProgram);
							controller.registControlBroadcast(schedule.timeEnd  , presenter.broadcastProgram);
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
			//获取排期
			var schedules:Object = config.datas;
			for each (var schedule:Schedule in schedules)
			{
				if (ScheduleUtil.validateScheduleAvailable(schedule) && 
					ScheduleUtil.compareSchedules(current, schedule))
					var current:Schedule = schedule;
			}
			if (current) 
			{
				if (view.guild && view.application.contains(view.guild))
				{
					view.application.removeElement(view.guild);
					view.guild = null;
				}
				if (view.installer && view.application.contains(view.installer))
				{
					view.application.removeElement(view.installer);
					view.installer = null;
				}
				if (view.main)
				{
					view.main.enabled = true;
					view.main.data = current;
				}
			}
			else
			{
				modelog(ClientStateConsts.BROD_NOPR);
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
		private var note:Boolean;
		
	}
}