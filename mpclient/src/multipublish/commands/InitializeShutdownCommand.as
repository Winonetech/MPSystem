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
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.consts.URLConsts;
	import multipublish.tools.Controller;
	import multipublish.utils.ConfigUtil;
	
	
	public final class InitializeShutdownCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ShutdownTerminalCommand</code>构造函数。
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
			
			shutdownTerminal();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($cmd:String):void
		{
			cmd = $cmd;   //关机命令参数
			conf = (cmd == "config");
		}
		
		/**
		 * @private
		 */
		private function shutdownTerminal():void
		{
			if (StringUtil.empty(cmd))
			{
				//参数为空表示立即关机
				shutdownDirectly();
			}
			else
			{
				if (isNaN(Number(cmd))) 
				{
					//仅初始化的时候进来。
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
						//非默认情况。
						controller.removeControlAllShutdown();  //覆盖之前的策略。
						shutdownSettime();
					}
				}
				else
				{
					//仅当回调函数的时候会进来。
					shutdownCheckweek();
				}
			}
		}
		
		/**
		 * @private
		 */
		private function shutdownDirectly():void
		{
			LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PC_SHUTDOWN,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_SHUTDOWN));
			
			config.service.communicationStop();
			
			try
			{
				ApplicationUtil.exit();
				ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.TOOL_SHUTDOWN));
			}
			catch (e:Error)
			{
				LogUtil.log("重启终端失败，请检查终端重启工具assets/tools/shutdown.exe没有被其他安全软件隔离删除。");
			}
			
		}
		
		/** 
		 * @private
		 */
		private function shutdownCheckweek():void
		{
			var date:Date = new Date;
			if (date.day == Number(cmd)) shutdownDirectly();
		}
		
		/**
		 * @private
		 */
		private function shutdownSettime():void
		{
			//conf -> cmd == "config"
			if (!conf)
			{
				config.shutdown = cmd;
				
				ConfigUtil.saveNativeData();
				ConfigUtil.backupConfig();
			}
			
			if (cmd != "null" && cmd.indexOf("false") < 0)
			{
				//cmd格式：星期 -hh:mm:ss; 星期 -hh:mm:ss; ... ...
				var t1:Array = cmd.split(";");    //分割出每个星期所对应的关机时间。
				for each (var i:String in t1)
				{
					var t2:Array = i.split("-");  //t2[0]为星期数解析。
					var time:String = t2[1];     //t2[1]为时间解析。
					if (time != "null")
					{
						var t3:Array = time.split(":");   //t3[0]为时，t3[1]为分，t3[2]为秒。
						//2000年 1月表示特定的 日期 =星期 -2。
						var date:Date = new Date(2000, 0, 2 + Number(t2[0]), t3[0], t3[1], t3[2]);
						controller.registControlShutdown(date, presenter.shutdownTerminal, t2[0]);
					}
				}
			}
			else
			{
				controller.removeControlAllShutdown();
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
		 * 关机命令参数。
		 */
		private var cmd:String;
		
		/**
		 * cmd是否为config（默认情况）
		 */
		private var conf:Boolean;
		
	}
}