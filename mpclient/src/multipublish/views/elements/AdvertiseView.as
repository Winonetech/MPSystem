package multipublish.views.elements
{
	
	/**
	 * 
	 * 广告视图。
	 * 
	 */
	
	
	public final class AdvertiseView extends CommanView
	{
		
		/**
		 * 
		 * <code>AdvertiseView</code>构造函数。
		 * 
		 */
		
		public function AdvertiseView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			navigatable = false;
			automatic = true;
		}
		
	}
}