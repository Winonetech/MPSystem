package multipublish.commands
{
	
	/**
	 * 
	 * 重启播放器命令。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	
	
	public final class RestartPlayerCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>RestartPlayerCommand</code>构造函数。
		 * 
		 */
		
		public function RestartPlayerCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			restartPlayer();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function restartPlayer():void
		{
			LogUtil.logTip(MPTipConsts.RECORD_SOCKET_OFFLINE); 
			
			config.service.communicationStop();
			
			/*LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_PLAYER_START,
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_RESTART))*/
			LogUtil.logTip(MPTipConsts.RECORD_COMMAND_RESTART);
			
			ApplicationUtil.exit();
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
		}
		
	}
}