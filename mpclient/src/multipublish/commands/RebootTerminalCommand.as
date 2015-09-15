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
	
	import com.winonetech.tools.LogSaver;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
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
			
			config.service.offline();
			
			LogSaver.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PC_REBOOT,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_REBOOT));
			
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.TOOL_REBOOT));
		}
		
	}
}