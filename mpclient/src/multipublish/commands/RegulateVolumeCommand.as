package multipublish.commands
{
	
	/**
	 * 
	 * 控制声音。
	 * 
	 */
	
	
	import cn.vision.utils.LogUtil;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import multipublish.consts.MPTipConsts;
	
	
	public final class RegulateVolumeCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>RegulateVolumeCommand</code>构造函数。
		 * 
		 */
		
		public function RegulateVolumeCommand($value:Number = 1)
		{
			super();
			
			initialize($value);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			regulateVolume();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($volume:Number):void
		{
			volume = $volume;
		}
		
		/**
		 * @private
		 */
		private function regulateVolume():void
		{
			/*LogSQLite.log(TypeConsts.NETWORK, 
				EventConsts.EVENT_ADJUST_VOL,
				LogUtil.logTip(MPTipConsts.RECORD_ADJUST_VOL))*/
			LogUtil.logTip(MPTipConsts.RECORD_ADJUST_VOL);
			
			SoundMixer.soundTransform = new SoundTransform(volume * .01);
		}
		
		
		/**
		 * @private
		 */
		private var volume:Number = 1;
		
	}
}