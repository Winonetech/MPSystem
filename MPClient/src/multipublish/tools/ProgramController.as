package multipublish.tools
{
	import cn.vision.utils.FileUtil;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MPCConfig;
	import multipublish.utils.BUSUtil;

	/**
	 * 节目播放控制。诸如：暂停 恢复等。 
	 */
	
	public final class ProgramController
	{
		public function ProgramController()
		{
			execute();
		}
		
		private function execute():void
		{
			if (timer && !timer.running)
			{
				timer.addEventListener(TimerEvent.TIMER, changed_timerHandler);
				timer.start();
				
				changed_timerHandler();
			}
		}
		
		public function changed_timerHandler(e:TimerEvent = null):void
		{
			BUSUtil.updatePlayable();
		}
		
		private function changeProgramStauts():void
		{
			var result:String = FileUtil.readUTF(FileUtil.resolvePathApplication(DataConsts.PAUSE_CFG));
			
			try
			{
				if (result) 
				{
					var playing:Boolean = "true" == result;
					
					playing != config.playable && config.setPlayable(playing);
				} 
				else  //如果文件不存在了 则判定为恢复播放。
				{
					config.playable || config.setPlayable(true);
				}
			} 
			catch(error:Error) {}
		}
		
		
		/**
		 * @private
		 */
		private const DELAY:uint = config.programGap || 1;
		
		/**
		 * @private
		 */
		private var timer:Timer = new Timer(DELAY * 1000);
		
		
		/**
		 * @private
		 */
		private function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
	}
}