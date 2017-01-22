package multipublish.utils
{
	import cn.vision.collections.Map;
	import cn.vision.core.NoInstance;
	import cn.vision.utils.ScreenUtil;
	import cn.vision.utils.TimerUtil;
	
	import flash.geom.Rectangle;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.ContentConsts;
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.core.MDProvider;
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCPresenter;
	import multipublish.core.MPCView;
	import multipublish.tools.Controller;
	import multipublish.views.GuildView;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class ViewUtil extends NoInstance
	{
		
		/**
		 * 
		 * 显示或隐藏引导界面。
		 * 
		 */
		
		public static function guild($visible:Boolean, $message:String = null):void
		{
			if ($visible)
			{
				view.guild = view.guild || new GuildView;
				
				if(!view.application.contains(view.guild))
				{
					var rect:Rectangle = ScreenUtil.getMainScreenBounds();
					view.guild.width = rect.width;
					view.guild.height = rect.height;
					view.application.addElement(view.guild);
				}
				if ($message) config.state = $message;
			}
			else
			{
				if (view.guild && view.application.contains(view.guild))
				{
					view.application.removeElement(view.guild);
					view.guild = null;
				}
			}
			if (view.main) view.main.enabled = !$visible;
		}
		
		/**
		 * 
		 * 显示或隐藏下载界面。
		 * 
		 */
		
		public static function showDownload($visible:Boolean, $message:String = null):void
		{
			if ($visible)
			{
				if(!view.application.contains(view.progress))
				{
					view.application.addElement(view.progress);
				}
				view.progress.play();
				if ($message) view.progress.message = $message;
			}
			else
			{
				if (view.progress && view.application.contains(view.progress))
				{
					view.application.removeElement(view.progress);
					
				}
				view.progress.stop();
			}
		}
		
		
		/**
		 * 
		 * 显示或隐藏下载树界面。
		 * 
		 */
		
		public static function showTree($visible:Boolean):void
		{
			if ($visible)
			{
				if(!view.application.contains(view.treeVideo))
				{
					view.application.addElement(view.treeVideo);
				}
				view.treeVideo.source = ContentConsts.WELCOME_VIDEO;
			}
			else
			{
				if (view.progress && view.application.contains(view.treeVideo))
				{
					view.application.removeElement(view.treeVideo);
					
				}
				view.treeVideo.source = null;
			}
		}
		
		
		public static function playSchedule($note:Boolean):void
		{
			var controller:Controller = config.controller;
			controller.removeControlAllBroadcast();
			
			if (provider.channelNow)
			{
				if ($note)
				{
					for each (var schedule:Schedule in provider.channelNow.schedulesMap)
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
				
				for each (schedule in provider.channelNow.schedulesMap)
				{
					//PS:此处只修复了每周 每月的 BUG。如果新增加了每年请进入修改。
					if (ScheduleUtil.validateScheduleAvailable(schedule) && 
						ScheduleUtil.compareSchedules(current, schedule)) var current:Schedule = schedule;
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
						
						if (view.main.data)
						{
							view.main.reset();
							view.main.data = null;
						}
						
						view.main.data = current;  //调用 data的 setter函数 会触发其 resolveData (MainView)
						
						view.main.play();
					}
				}
				else
				{
					config.state = ClientStateConsts.BROD_NOPR;
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private static var provider:MDProvider = MDProvider.instance;
		
		/**
		 * @private
		 */
		private static var view:MPCView = MPCView.instance;
		
		/**
		 * @private
		 */
		private static var config:MPCConfig = MPCConfig.instance;
		
		/**
		 * @private
		 */
		private static var presenter:MPCPresenter = MPCPresenter.instance;
		
	}
}