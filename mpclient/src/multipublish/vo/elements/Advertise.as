package multipublish.vo.elements
{
	
	/**
	 * 
	 * 广告元素数据结构。
	 * 
	 */
	
	
	import multipublish.core.mp;
	
	
	public final class Advertise extends Comman
	{
		
		/**
		 * 
		 * <code>Advertise</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Advertise($data:Object=null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var list:* = data["waittime"];
			if (list)
				mp::wait = getProperty("waittime", uint);
		}
		
		
		/**
		 * 
		 * 等待时长。
		 * 
		 */
		
		public function get wait():uint
		{
			return mp::wait;
		}
		
		
		/**
		 * @private
		 */
		mp var wait:uint;
		
	}
}