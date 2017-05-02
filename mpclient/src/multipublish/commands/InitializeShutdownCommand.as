package multipublish.commands
{
	
	/**
	 * 
	 * 关闭终端命令。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.consts.URLConsts;
	import multipublish.tools.Controller;
	import multipublish.utils.DataUtil;
	
	
	public final class InitializeShutdownCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ShutdownTerminalCommand</code>构造函数。
		 * <br>初始化关机命令。会一直对关机时间进行监测，达到时间则关机。
		 * 
		 */
		
		public function InitializeShutdownCommand($cmd:String = "config")
		{
			super();
			
			initialize($cmd);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			shutdownTerminal();     //关闭终端
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($cmd:String):void
		{
			cmd = $cmd;
			conf = (cmd == "config");
		}
		
		/**
		 * @private
		 * 关闭终端
		 */
		private function shutdownTerminal():void
		{
			if (StringUtil.empty(cmd))
			{
				shutdownDirectly();   //不存在则立即关机
			}
			else
			{
				if (isNaN(Number(cmd))) 
				{
					if (cmd == "config")
					{
						if (config.shutdown)
						{
							cmd = config.shutdown;
							shutdownSettime();
						}
					}
					else
					{
						shutdownSettime();
					}
				}
				else
				{
					shutdownCheckweek();  
				}
			}
		}
		
		/**
		 * @private
		 * 关机命令
		 */
		private function shutdownDirectly():void
		{
			LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PC_SHUTDOWN,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_SHUTDOWN));
			
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.TOOL_SHUTDOWN));
		}
		
		/** 
		 * @private
		 * 
		 *  当关闭命令为一个数字时，表示当前星期直接关闭，无时间点。
		 */
		private function shutdownCheckweek():void
		{
			var date:Date = new Date;
			if (date.day == Number(cmd))
				shutdownDirectly();
		}
		
		/**
		 * @private
		 */
		private function shutdownSettime():void
		{
			if (!conf)
			{
				config.shutdown = cmd;
				
				Cache.save(URLConsts.NATIVE_CONFIG, DataUtil.getConfig());
			}
			
			if (cmd != "null" && cmd.indexOf("false") < 0)
			{
				//cmd的格式:0(星期一)-12:00:00;1-12:00:00
				var t1:Array = cmd.split(";");
				for each (var i:String in t1)
				{
					var t2:Array = i.split("-");
					var time:String = t2[1];
					if (time != "null")
					{
						var t3:Array = time.split(":");
						var date:Date = new Date(2000, 0, 2 + Number(t2[0]), t3[0], t3[1], t3[2]);
						controller.registControlShutdown(date, presenter.shutdownTerminal, t2[0]);
					}
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
		private var cmd:String;
		
		/**
		 * @private
		 */
		private var conf:Boolean;
		
	}
}