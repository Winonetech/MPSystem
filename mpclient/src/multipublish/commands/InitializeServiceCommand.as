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
		 */
		private function initializeController():void
		{
			if(!config.exportData)
			{
				//注册每天 00:00监测排期。
				controller.registControlBroadcast(new Date(2000, 0, 1), presenter.broadcastProgram);
				//设定 n秒后执行加载频道排期。
				controller.registControlUsecache(presenter.initializeModule, config.pushwaitTime || 5);
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
				service.registHandler(ServiceConsts.RECEIVE_SCEDULE, presenter.exportData);
				service.registHandler(ServiceConsts.RECEIVE_PROGRAM, presenter.exportData);
			}
			else
			{
//				service.registHandler(ServiceConsts.RECEIVE_PROGRAM  , presenter.initializeProgram);
				service.registHandler(ServiceConsts.RECEIVE_SCEDULE  , presenter.initializeModule);
				service.registHandler(ServiceConsts.RECEIVE_LEDTEXT  , presenter.sendLed);
				service.registHandler(ServiceConsts.LOCK_TIME        , presenter.lockTime);
				service.registHandler(ServiceConsts.RESTART_PLAYER   , presenter.restartPlayer);
				service.registHandler(ServiceConsts.REBOOT_TERMINAL  , presenter.rebootTerminal);
				service.registHandler(ServiceConsts.RECEIVE_SHOTCUT  , presenter.shotcutPlayer);
				service.registHandler(ServiceConsts.SET_SHUTDOWN_TIME, presenter.shutdownTerminal);
				service.registHandler(ServiceConsts.REPORT_FILE_START, presenter.reportProgressStart);
				service.registHandler(ServiceConsts.REPORT_FILE_END  , presenter.reportProgressEnd);
				service.registHandler(ServiceConsts.REGULATE_VOL     , presenter.regulateVolume);
				service.registHandler(ServiceConsts.UPLOAD_LOG       , presenter.logUpload);
				service.registHandler(ServiceConsts.FILE_DOWNLOAD    , presenter.downloadFiles);
				service.registHandler(ServiceConsts.EPAPER_DOWNLOAD  , presenter.downloadEPaper);
				service.registHandler(ServiceConsts.CONTROL_LED      , presenter.getLEDConfig);
				service.registHandler(ServiceConsts.DOWNLOAD_STATE	 , presenter.downloadQueueHandle);
			}
			service.frequency = config.heartbeatTime;
			service.communicationStart();
			
			application.onClosing = service.communicationStop;
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