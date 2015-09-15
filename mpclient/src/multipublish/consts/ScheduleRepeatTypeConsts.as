package multipublish.consts
{
	
	/**
	 * 
	 * 定义了重复排期的子类型常量，包含每天，每周，每月，每年四种。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class ScheduleRepeatTypeConsts extends NoInstance
	{
		
		/**
		 * 
		 * 每天。
		 * 
		 */
		
		public static const DAY:uint = 0;
		
		
		/**
		 * 
		 * 每周。
		 * 
		 */
		
		public static const WEEK:uint = 1;
		
		
		/**
		 * 
		 * 每月。
		 * 
		 */
		
		public static const MONTH:uint = 2;
		
		
		/**
		 * 
		 * 每年。
		 * 
		 */
		
		public static const YEAR:uint = 3;
		
	}
}