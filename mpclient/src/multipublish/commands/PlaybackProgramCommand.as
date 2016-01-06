package multipublish.commands
{
	
	/**
	 * 
	 * 播放节目。
	 * 
	 */
	
	
	public final class PlaybackProgramCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function PlaybackProgramCommand($type:String = null)
		{
			super();
			
			type = $type;
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
		private function playbackProgram():void
		{
			view.main.playbackProgram(type);
		}
		
		
		/**
		 * @private
		 */
		private var type:String;
		
	}
}