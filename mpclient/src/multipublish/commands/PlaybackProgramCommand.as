package multipublish.commands
{
	
	/**
	 * 
	 * 播放节目。
	 * 
	 */
	
	
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.tools.MPService;
	
	
	public final class PlaybackProgramCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function PlaybackProgramCommand($type:String = null, $send:Boolean = true)
		{
			super();
			
			initialize($type, $send);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			playbackProgram();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($type:String, $send:Boolean):void
		{
			type = $type;
			send = $send;
		}
		
		/**
		 * @private
		 */
		private function playbackProgram():void
		{
			if (send)
			{
				LogUtil.logTip(MPTipConsts.RECORD_PROGRAM_TYPE_PUSH, type);
				
				config.service.program(type);
			}
			else
			{
				LogUtil.logTip(MPTipConsts.RECORD_PROGRAM_TYPE_PLAY, type);
				
				view.main.playbackProgram(type);
			}
		}
		
		
		/**
		 * @private
		 */
		private var type:String;
		
		/**
		 * @private
		 */
		private var send:Boolean;
		
	}
}