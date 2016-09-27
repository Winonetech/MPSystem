package multipublish.vo.programs
{
	
	/**
	 * 
	 * 广告数据
	 * 
	 */
	
	
	public final class AD extends Sheet
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function AD($data:Object=null, $name:String = "ad")
		{
			super($data, $name);
		}
		
		
		/**
		 * 
		 * 是否启用广告。
		 * 
		 */
		
		public function get enabled():Boolean
		{
			return getProperty("adEnabled", Boolean);
		}
		
		
		/**
		 * 
		 * 等待时长。
		 * 
		 */
		
		public function get waitTime():uint
		{
			return getProperty("waitTime", uint);
		}
		
	}
}