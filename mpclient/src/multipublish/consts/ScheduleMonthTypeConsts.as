package multipublish.consts
{
	
	/**
	 * 
	 * 定义了重复排期的按月子类型的常量，包含每月的第几天，每月的第几周的第几天两种。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class ScheduleMonthTypeConsts extends NoInstance
	{
		
		/**
		 * 
		 * 每月的第几天。
		 * 
		 */
		
		public static const DAY:uint = 0;
		
		
		/**
		 * 
		 * 每月的第几周的第几天。
		 * 
		 */
		
		public static const WEEK:uint = 1;
		
	}
}