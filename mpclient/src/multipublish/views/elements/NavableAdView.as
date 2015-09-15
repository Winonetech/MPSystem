package multipublish.views.elements
{
	
	/**
	 * 
	 * 可控制广告视图。
	 * 
	 */
	
	
	public final class NavableAdView extends CommanView
	{
		
		/**
		 * 
		 * <code>AdvertiseView</code>构造函数。
		 * 
		 */
		
		public function NavableAdView()
		{
			super();
			
			initializeEnvironment();
			
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			automatic = true;
		}
		
	}
}