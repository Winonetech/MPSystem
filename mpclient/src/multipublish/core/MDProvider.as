package multipublish.core
{
	
	/**
	 * 
	 * 数据源。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.core.VSObject;
	import cn.vision.errors.SingleTonError;
	
	import multipublish.vo.Channel;
	import multipublish.vo.programs.AD;
	
	
	public final class MDProvider extends VSObject
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function MDProvider()
		{
			if(!instance)
				super();
			else 
				throw new SingleTonError(this);
		}
		
		
		/**
		 * 
		 * 频道当前排期数据。
		 * 
		 */
		
		public var channelNow:Channel;
		
		
		/**
		 * 
		 * 频道新排期数据。
		 * 
		 */
		
		public var channelNew:Channel;
		
		
		/**
		 * 
		 * 单例引用。
		 * 
		 */
		
		public static const instance:MDProvider = new MDProvider;
		
	}
}