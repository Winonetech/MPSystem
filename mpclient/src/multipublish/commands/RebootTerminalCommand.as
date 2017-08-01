package multipublish.commands
{
	
	/**
	 * 
	 * 重启终端命令。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	
	
	public final class RebootTerminalCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>RebootTerminalCommand</code>构造函数。
		 * 
		 */
		
		public function RebootTerminalCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			rebootTerminal();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function rebootTerminal():void
		{
			LogUtil.logTip(MPTipConsts.RECORD_SOCKET_OFFLINE);
			
			config.service.communicationStop();
			
			/*LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PC_REBOOT,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_REBOOT))*/
			LogUtil.logTip(MPTipConsts.RECORD_COMMAND_REBOOT);
			
			try
			{
				ApplicationUtil.exit();
				ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.TOOL_REBOOT));
			}
			catch (e:Error)
			{
				LogUtil.log("重启终端失败，请检查终端重启工具assets/tools/reboot.exe没有被其他安全软件隔离删除。");
			}
		}
		
	}
}