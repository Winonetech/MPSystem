package multipublish.commands
{
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSaver;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	
	/**
	 * 
	 * 重启播放器命令。
	 * 
	 */
	
	
	public final class ShotcutPlayerCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ShotcutPlayerCommand</code>构造函数。
		 * 
		 */
		
		public function ShotcutPlayerCommand($time:uint)
		{
			super();
			
			initialize($time);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			shotcutPlayer();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($time:uint):void
		{
			time = $time;
		}
		
		/**
		 * @private
		 */
		private function shotcutPlayer():void
		{
			if (time > 0)
			{
				LogSaver.log(TypeConsts.NETWORK, 
					EventConsts.EVENT_TAKE_SCREENSHOT,
					LogUtil.logTip(MPTipConsts.RECORD_COMMAND_SHOTCUT));
			}
			time > 0
				? config.shotcuter.start(time)
				: config.shotcuter.stop();
		}
		
		
		/**
		 * @private
		 */
		private var time:uint;
		
	}
}