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
	import com.winonetech.tools.LogSaver;
	
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
			cmd = $cmd;
			conf = (cmd == "config");
		}
		
		/**
		 * @private
		 */
		private function shutdownTerminal():void
		{
			if (StringUtil.isEmpty(cmd))
			{
				shutdownDirectly();
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
		 */
		private function shutdownDirectly():void
		{
			LogSaver.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PC_SHUTDOWN,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_SHUTDOWN));
			
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.TOOL_SHUTDOWN));
		}
		
		/** 
		 * @private
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
			
			if (cmd != "false" && cmd != "null")
			{
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