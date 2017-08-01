package multipublish.views
{
	
	/**
	 * 
	 * 广告视图
	 * 
	 */
	
	
	import multipublish.consts.MPTipConsts;
	import multipublish.vo.programs.AD;
	
	
	public final class ADView extends SheetView
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ADView()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			/*LogSQLite.log(
				TypeConsts.FILE,
				EventConsts.EVENT_START_PLAYING,
				data, log(MPTipConsts.RECORD_TYPESET_PLAY_AD, data));*/
			
			log(MPTipConsts.RECORD_TYPESET_PLAY_AD, data);
			
			visible = true;
		}
		
		override protected function processStop():void
		{
			log(MPTipConsts.RECORD_TYPESET_STOP_AD);
			
			visible = false;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			super.resolveData();
			
			ad = data as AD;
			
			visible = false;
		}
		
		
		
		
		/**
		 * 
		 * 是否启用广告。
		 * 
		 */
		
		public function get adable():Boolean
		{
			return ad ? ad.enabled : false;
		}
		
		/**
		 * @private
		 */
		public function get waitTime():uint
		{
			return ad ? ad.waitTime : 0;
		}
		
		
		/**
		 * @private
		 */
		private var ad:AD;
		
	}
}