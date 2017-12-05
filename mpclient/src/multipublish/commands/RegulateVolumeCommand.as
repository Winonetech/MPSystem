package multipublish.commands
{
	
	/**
	 * 
	 * 控制声音。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.MathUtil;
	import cn.vision.utils.StringUtil;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	
	
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
			
			changeVolume(volume);
			
//			SoundMixer.soundTransform = new SoundTransform(volume * .01);
		}
		
		private function changeVolume($vol:uint = 60):void
		{
			$vol = Math.min($vol, 100);
			
			LogUtil.log("The system volume is changed to " + $vol);
			
			$vol = Math.round($vol / 100.0 * MAX_VOL);
			
			ApplicationUtil.executeBAT(
				StringUtil.replace(
					FileUtil.resolvePathApplication(URLConsts.TOOL_VOLUME),	"\\", "/"),
					$vol);
		}
		
		
		/**
		 * @private
		 */
		private var volume:Number = 1;
		
		/**
		 * @private
		 * nircmd插件的最大音量值。
		 */
		
		private const MAX_VOL:uint = 65535;
	}
}