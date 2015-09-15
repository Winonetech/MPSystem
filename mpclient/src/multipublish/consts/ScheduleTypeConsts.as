package multipublish.consts
{
	
	/**
	 * 
	 * ScheduleTypeConsts定义了排期类型常量。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class ScheduleTypeConsts extends NoInstance
	{
		
		/**
		 * 
		 * 默认类型，无其他类型排期或其他排期已播放完毕时，播放此排期类型下的节目。<br>
		 * 此类型播放优先级最低，为1。
		 * 
		 */
		
		public static const DEFAULT:uint = 5;
		
		
		/**
		 * 
		 * 轮播类型，可以在开始至结束日期之内重复播放，只能按日期，无法控制精确时间点。<br>
		 * 此类型播放优先级高于默认优先级，为2。
		 * 
		 */
		
		public static const TURN:uint = 1;
		
		
		/**
		 * 
		 * 点播类型，可以在开始至结束时间之内重复播放，精确控制时间点。<br>
		 * 此类型播放优先级为3，高于轮播类型，更高于默认类型。
		 * 
		 */
		
		public static const DEMAND:uint = 2;
		
		
		/**
		 * 
		 * 重复类型，可以在开始至结束日期之内，按以下形式播放：<br>
		 * 1.每天，该方式类似于轮播；<br>
		 * 2.每周，可定义每周的具体某几天重复播放，如：每周二和周三重复播放；<br>
		 * 3.每月，可定义在每月的某一天或每月第几周的第几天播放；<br>
		 * 4.每年，可定义每年的某一段时间内重复播放。<br>
		 * 此类型播放优先级为4，仅低于插播类型。
		 * 
		 */
		
		public static const REPEAT:uint = 3;
		
		
		/**
		 * 
		 * 插播类型，从当前时间开始的时间段内播放<br>
		 * 此类型播放优先级为5，最高优先级。
		 * 
		 */
		
		public static const SPOTS:uint = 4;
		
	}
}