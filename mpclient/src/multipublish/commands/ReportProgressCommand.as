package multipublish.commands
{
	import com.winonetech.tools.Cache;
	
	import multipublish.core.MPCConfig;
	import multipublish.tools.Reporter;
	
	/**
	 * 
	 * 上报文件进度命令。
	 * 
	 */
	
	
	public final class ReportProgressCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ReportProgressCommand</code>构造函数。
		 * 
		 * @param $cmd:Boolean (default = true) true开始上报进度，false结束上报进度。
		 * 
		 */
		
		public function ReportProgressCommand($cmd:Boolean = true)
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
			
			reportProgress();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($cmd:Boolean):void
		{
			cmd = $cmd;
		}
		
		/**
		 * @private
		 */
		private function reportProgress():void
		{
			cmd ? reporter.start()
				: reporter.stop();
		}
		
		
		/**
		 * @private
		 */
		private function get reporter():Reporter
		{
			return config.reporter;
		}
		
		
		/**
		 * @private
		 */
		private var cmd:Boolean;
		
	}
}