package multipublish.commands
{
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSQLite;
	
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