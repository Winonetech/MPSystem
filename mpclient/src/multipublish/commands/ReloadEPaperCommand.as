package multipublish.commands
{
	
	/**
	 * 
	 * 获取报纸数据。
	 * 
	 */
	
	
	import multipublish.utils.URLUtil;
	
	
	public class ReloadEPaperCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ReloadEPaperCommand($url:String)
		{
			super();
			
			url = URLUtil.buildFTPURL($url);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			reloadEpaper();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function reloadEpaper():void
		{
			
		}
		
		
		/**
		 * @private
		 */
		private var url:String;
		
	}
}