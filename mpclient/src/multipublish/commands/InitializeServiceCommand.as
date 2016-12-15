package multipublish.commands
{
	
	/**
	 * 
	 * 初始化服务，Socket，Controller。
	 * 
	 */
	
	
	import com.winonetech.controls.MainApplication;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.ServiceConsts;
	import multipublish.tools.Controller;
	import multipublish.tools.MPService;
	
	
	public final class InitializeServiceCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeServiceCommand</code>构造函数。
		 * <br>初始化服务。
		 * <br>1、初始化自动关机功能。
		 * <br>2、初始化Socket。
		 * 
		 * 
		 */
		
		public function InitializeServiceCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_SERV);
			
			initializeController();
			initializeSocket();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 * 初始化自动关机类。
		 */
		private function initializeController():void
		{
			if(!config.exportData)
			{
				//注册每天0:00执行函数，日期可以为任意日期。
				controller.registControlBroadcast(new Date(2000, 0, 1), presenter.broadcastProgram);
				controller.registControlUsecache(presenter.initializeModule, config.pushwaitTime || 5, null, true);
			}
			else
			{
				controller.registControlUsecache(presenter.exportData, config.pushwaitTime || 5, null, true);
			}
		}
		
		/**
		 * @private
		 */
		private function initializeSocket():void
		{
			if (config.exportData)
			{
				service.registHandler(ServiceConsts.RECEIVE_DATA_PUSH, presenter.exportData);
			}
			else
			{
				service.registHandler(ServiceConsts.RECEIVE_DATA_PUSH, presenter.initializeModule);
				service.registHandler(ServiceConsts.LOCK_TIME        , presenter.lockTime);
				service.registHandler(ServiceConsts.RESTART_PLAYER   , presenter.restartPlayer);
				service.registHandler(ServiceConsts.REBOOT_TERMINAL  , presenter.rebootTerminal);
				service.registHandler(ServiceConsts.RECEIVE_SHOTCUT  , presenter.shotcutPlayer);
				service.registHandler(ServiceConsts.SET_SHUTDOWN_TIME, presenter.shutdownTerminal);
				service.registHandler(ServiceConsts.REPORT_FILE_START, presenter.reportProgressStart);
				service.registHandler(ServiceConsts.REPORT_FILE_END  , presenter.reportProgressEnd);
				service.registHandler(ServiceConsts.REGULATE_VOL     , presenter.regulateVolume);
				service.registHandler(ServiceConsts.UPLOAD_LOG       , presenter.logUpload);
				service.registHandler(ServiceConsts.PLAY_PROGRAM     , presenter.playProgram);
			}
			service.connect(config.socketHost, config.messagePort || 6666);
			
			application.onClosing = service.offline;
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
		private function get service():MPService
		{
			return config.service;
		}
		
		/**
		 * @private
		 */
		private function get application():MainApplication
		{
			return view.application as MainApplication;
		}
		
	}
}