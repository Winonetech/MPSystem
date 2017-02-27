package multipublish.consts
{
	
	/**
	 * 
	 * 定义了一些url常量 。
	 * 
	 */
	
	import cn.vision.core.NoInstance;
	
	import multipublish.core.MPCConfig;
	
	public class FinanceTypeConsts extends NoInstance
	{
		
		
		/**
		 * 
		 * 存款利率。
		 * 
		 */
		public static const DEPOSITRATE:String = MPCConfig.instance.isVertical 
												 ? "financeData/DepositRate-V.swf" : "financeData/DepositRate-H.swf";
		
		/**
		 * 
		 * 外汇牌价。
		 * 
		 */
		public static const QUOTATION:String   = MPCConfig.instance.isVertical 
												 ? "financeData/ForExDepositRate-V.swf" : "financeData/ForExDepositRate-H.swf";
		
		/**
		 * 
		 * 黄金。
		 * 
		 */
		public static const GOLD:String        = MPCConfig.instance.isVertical 
												 ? "financeData/Gold-V.swf" : "financeData/Gold-H.swf";
		
		/**
		 * 
		 * 原油。
		 * 
		 */
		public static const OIL:String         = MPCConfig.instance.isVertical 
												 ? "financeData/Oil-V.swf" : "financeData/Oil-H.swf";
		
		/**
		 * 
		 * 股票。
		 * 
		 */
		public static const STOCK:String       = MPCConfig.instance.isVertical 
												 ? "financeData/Stock-V.swf" : "financeData/Stock-H.swf";
		
	}
}