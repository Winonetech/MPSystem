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
		 * 排期字典。
		 * 
		 */
		
		public var schedulesMap:Map = new Map;
		
		
		/**
		 * 
		 * 节目字典。
		 * 
		 */
		
		public var programsMap:Map = new Map;
		
		
		/**
		 * 
		 * 布局字典。
		 * 
		 */
		
		public var layoutsMap:Map = new Map;
		
		
		/**
		 * 
		 * 页面字典。
		 * 
		 */
		
		public var pagesMap:Map = new Map;
		
		
		/**
		 * 
		 * 组件字典。
		 * 
		 */
		
		public var componentsMap:Map = new Map;
		
		
		/**
		 * 
		 * 内容字典。
		 * 
		 */
		
		public var contentsMap:Map = new Map;
		
		
		/**
		 * 
		 * 版面字典。
		 * 
		 */
		
		public var sheetsMap:Map = new Map;
		
		
		/**
		 * 
		 * 广告版面。
		 * 
		 */
		
		public var ad:AD;
		
		
		/**
		 * 
		 * 样式。
		 * 
		 */
		
		public var style:Object;
		
		
		
		/**
		 * 
		 * EPaper字典。
		 * 
		 */
		
		public var ePaperMap:Map = new Map;
		/**
		 * 
		 * 单例引用。
		 * 
		 */
		
		public static const instance:MDProvider = new MDProvider;
		
	}
}