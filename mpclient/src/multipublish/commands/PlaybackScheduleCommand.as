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
	import multipublish.core.MDProvider;
	import multipublish.core.mp;
	import multipublish.tools.Controller;
	import multipublish.utils.ScheduleUtil;
	import multipublish.utils.ViewUtil;
	import multipublish.vo.schedules.Schedule;
	
	import spark.components.VideoPlayer;
	
	
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
				var schedules:Object = provider.schedulesMap;
				for each (var schedule:Schedule in schedules)
				{
					if (ScheduleUtil.validateScheduleInArchive(schedule))
					{
						if ((schedule.type == ScheduleTypeConsts.DEMAND) || 
							(schedule.type == ScheduleTypeConsts.SPOTS)  || 
							(schedule.type == ScheduleTypeConsts.REPEAT  && 
							(schedule.extra.repeatType == ScheduleRepeatTypeConsts.DAY) && 
							!schedule.repeatWholeDay))
						{
							//轮播是不需要注册时间的。
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
			//var schedules:Object = config.datas;
			var schedules:Object = provider.schedulesMap;
			for each (var schedule:Schedule in schedules)
			{
				if (ScheduleUtil.validateScheduleAvailable(schedule) && 
					ScheduleUtil.compareSchedules(current, schedule))
					var current:Schedule = schedule;
			}
			if (current) 
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
					view.main.data = current;  //调用 data的 setter函数 会触发其 resolveData (MainView)
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