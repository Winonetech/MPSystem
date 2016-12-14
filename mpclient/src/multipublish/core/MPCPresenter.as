package multipublish.core
{
	
	/**
	 * 
	 * 命令队列逻辑处理器。
	 * 
	 */
	
	
	import cn.vision.errors.SingleTonError;
	import cn.vision.pattern.core.Command;
	import cn.vision.pattern.core.Presenter;
	import cn.vision.pattern.queue.SequenceQueue;
	
	import multipublish.commands.*;
	
	import spark.components.WindowedApplication;
	
	
	public final class MPCPresenter extends Presenter
	{
		
		/**
		 * 
		 * <code>MPCPresenter</code>构造函数。
		 * 
		 */
		
		public function MPCPresenter()
		{
			if(!instance)
			{
				super();
				
				initialize();
			}
			else throw new SingleTonError(this);
		}
		
		
		/**
		 * 
		 * 执行命令。
		 * 
		 */
		
		public function execute($command:Command):void
		{
			quene.execute($command);
		}
		
		/**
		 * 
		 * 下载电子报。
		 * 
		 */
		public function downloadEPaper($url:String):void
		{
			execute(new LoadEPaperCommand($url));
		}
		
		
		/**
		 * 
		 * 导入数据。
		 * 
		 */
		
		public function importData():void
		{
			config.cache = true;
			
			execute(new ImportDataCommand);
			execute(new InitializeDataCommand);
			execute(new PlaybackScheduleCommand);
		}
		
		
		/**
		 * 
		 * 导出数据。
		 * 
		 * @param $push:String 推送地址。
		 * 
		 */
		
		public function exportData($push:String = null, $cache:Boolean = false):void
		{
			config.cache  = $cache;
			
			execute(new InitializeDataCommand($push));
			execute(new ExportDataCommand);
		}
		
		
		/**
		 * 
		 * 初始化模块。
		 * 
		 * @param $push:String 推送地址。
		 * @param $cache:Boolean 是否使用缓存。
		 * 
		 */
		
		public function initializeModule($push:String = null, $cache:Boolean = false):void
		{
			config.cache  = $cache;
			
			execute(new LoadChannelCommand($push));
			execute(new InitDataCommand);
			execute(new PlaybackScheduleCommand);
		}
		
		
		/**
		 * 
		 * 播放节目。
		 * 
		 */
		
		public function broadcastProgram():void
		{
			execute(new PlaybackScheduleCommand(false));
		}
		
		
		/**
		 * 
		 * 发送LED信息。
		 * 
		 */
		
		public function sendLed($value:String):void
		{
			execute(new SendLedCommand($value));
		}
		
		
		/**
		 * 
		 * 时间同步
		 * 
		 */
		
		public function lockTime($value:String):void
		{
			execute(new LockTimeCommand($value));
		}
		
		
		/**
		 * 
		 * 下载文件
		 * 
		 */
		
		public function downloadFiles($data:String):void
		{
			execute(new ReloadFilesCommand($data));
		}
		
		
		/**
		 * 
		 * 获取报纸
		 * 
		 */
		
		public function refreshEpaper($data:String):void
		{
			execute(new ReloadEPaperCommand($data));
		}
		
		
		/**
		 * 
		 * 时间同步
		 * 
		 */
		
		public function logUpload($value:String):void
		{
			execute(new LogUploadCommand($value));
		}
		
		
		/**
		 * 
		 * 重启终端。
		 * 
		 */
		
		public function rebootTerminal(...$args):void
		{
			execute(new RebootTerminalCommand);
		}
		
		
		/**
		 * 
		 * 重启播放器。
		 * 
		 */
		
		public function restartPlayer(...$args):void
		{
			execute(new RestartPlayerCommand);
		}
		
		
		/**
		 * 
		 * 截图。
		 * 
		 */
		
		public function shotcutPlayer($value:String):void
		{
			execute(new ShotcutPlayerCommand($value));
		}
		
		
		/**
		 * 
		 * 打开设置面板。
		 * 
		 */
		
		public function showDeploy():void
		{
			execute(new ShowDeployCommand);
		}
		
		
		/**
		 * 
		 * 设定关机时间。
		 * 
		 */
		
		public function shutdownTerminal($value:String = null):void
		{
			execute(new InitializeShutdownCommand($value));
		}
		
		
		
		/**
		 * 
		 * 控制声音。
		 * 
		 */
		
		public function regulateVolume($value:Number):void
		{
			execute(new RegulateVolumeCommand($value));
		}
		
		
		/**
		 * 
		 * 开始上报进度。
		 * 
		 */
		
		public function reportProgressStart($value:String = null):void
		{
			execute(new ReportProgressCommand);
		}
		
		
		/**
		 * 
		 * 结束上报进度。
		 * 
		 */
		
		public function reportProgressEnd($value:String = null):void
		{
			execute(new ReportProgressCommand(false));
		}
		
		
		/**
		 * 
		 * 结束上报进度。
		 * 
		 */
		
		public function update($app:*, $value:String = null):void
		{
			app = $app;
			config.updateVersion = true;
			execute(new InitializeEnvironmentCommand);
			execute(new InitializeConfigCommand);
			execute(new ClientUpdateCommand($value));
		}
		
		
		/**
		 * 
		 * 启动流程。
		 * 
		 */
		
		override protected function setup(...$args):void
		{
			config.exportData = $args[0];
			execute(new InitializeEnvironmentCommand);    //初始化网络配置，初始化窗口和初始化LED。
			execute(new InitializeConfigCommand);        //解析 config并映射到 MDConfig中。
			execute(new InitializeShutdownCommand);     //初始化关机数据。
			execute(new ShotcutPlayerCommand);         //初始化截图数据。
			execute(new InitializeFirstStartCommand); //调出首次设置弹窗。(根据是否有终端编号以判定是否需要弹出设置窗口)
			execute(new ClientUpdateCommand);		 //升级判定。
			execute(new InitializeViewCommand);     //调出显示页面。
			execute(new InitializeServiceCommand); //初始化服务。
			execute(new SendLedCommand);          //发送 LED。
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			quene = new SequenceQueue;    //实例化一个顺序的同步命令
		}
		
		
		/**
		 * 
		 * 主窗口。
		 * 
		 */
		
		public function get application():WindowedApplication
		{
			return app as WindowedApplication;
		}
		
		
		/**
		 * @private
		 */
		private function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		
		/**
		 * @private
		 */
		private var quene:SequenceQueue;
		
		
		/**
		 * 
		 * 单例引用。
		 * 
		 */
		
		public static const instance:MPCPresenter = new MPCPresenter;
		
	}
}