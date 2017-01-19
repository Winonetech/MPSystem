package multipublish.vo.contents
{
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	
	/**
	 * 
	 * 金融数据。
	 * 
	 */
	
	public class Finance extends Content
	{
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Finance($data:Object=null)
		{
			super($data);
		}
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
//			var name:String = getProperty("contentsname");
			
//			config.list.push(name);
		}
		
		public function get contentName():String
		{
			return getProperty("contentsname");
		}
		
		
		
		public function get timelength():uint
		{
			return getProperty("timelength");
		}
		
		private function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
	}
}