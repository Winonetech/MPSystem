package multipublish.commands
{
	
	/**
	 * 
	 * 播放节目。
	 * 
	 */
	
	
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
			
			playbackProgram():
			
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
			send ? config.service.program(type) : view.main.playbackProgram(type);
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