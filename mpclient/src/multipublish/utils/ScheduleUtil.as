package multipublish.utils
{
	
	/**
	 * 
	 * 定义了一些排期函数。
	 * 
	 */
	
	
	import cn.vision.consts.Consts;
	import cn.vision.core.NoInstance;
	import cn.vision.utils.DateUtil;
	
	import multipublish.consts.ScheduleMonthTypeConsts;
	import multipublish.consts.ScheduleRepeatTypeConsts;
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.vo.schedules.Schedule;
	import multipublish.vo.schedules.ScheduleTypeExtra;
	
	
	public final class ScheduleUtil extends NoInstance
	{
		
		
		public static function validateTurnSchedusConflit($schedule1:Schedule, $schedule2:Schedule):Boolean
		{
			return !(
				DateUtil.compareDate($schedule1.endTime, $schedule2.startTime) == -1 || 
				DateUtil.compareDate($schedule2.endTime, $schedule1.startTime) == -1
			);
		}
		
		/**
		 * 
		 * 验证排期当前排期是否需要被另一排期替换。
		 * 
		 * <br>判定规则：优先级低的被替换。
		 * <br>优先级相等则最先修改的被替换。
		 * 
		 * @param $current:Schedule 当前的排期。
		 * @param $replace:Schedule 用于替换的排期。
		 * 
		 * @return Boolean 验证结果，true为需要替换，false为不需要替换。
		 * 
		 */
		
		public static function compareSchedules($current:Schedule, $replace:Schedule):Boolean
		{
			return(!$current || 
					 $current.priority   < $replace.priority || 
					($current.priority  == $replace.priority && 
					 $current.timeModify < $replace.timeModify));
		}
		
		
		/**
		 * 
		 * 由于网络传输问题，当前时间会晚于插播节目的起始时间，这时要对插播节目的截止时间进行一个修正。
		 * 
		 * @param $now:Date 当前时间。
		 * @param $start:Date 起始时间。
		 * @param $end:Date 截止时间。
		 * 
		 * @return Date 修正后的截止时间。
		 * 
		 */
		
		public static function modifySpotScheduleDate($now:Date, $start:Date, $end:Date):Date
		{
			if (DateUtil.validate($now) && DateUtil.validate($start) && DateUtil.validate($end))
			{
				var modify:Object = subtract($end, $start);
				var result:Date = DateUtil.clone($now);
				result.fullYear += modify.fullYear;
				result.month    += modify.month;
				result.date     += modify.date;
				result.hours    += modify.hours;
				result.minutes  += modify.minutes;
				result.seconds  += modify.seconds;
			}
			return result;
		}
		
		
		/**
		 * 
		 * 验证排期在当前时间是否可用。
		 * 
		 * @param $schedule:Schedule 需要验证的排期。
		 * 
		 * @return Boolean 验证结果，true为可用，false为不可用。
		 * 
		 */
		
		public static function validateScheduleAvailable($schedule:Schedule):Boolean
		{
			initializeTypes();
			
			return (TYPE[$schedule.type] && $schedule.hasProgram)
				? TYPE[$schedule.type]($schedule, new Date) : false;
		}
		
		
		/**
		 * 
		 * 验证排期是否在档，与validateScheduleAvailable不同，该方法只验证起始日期与截止日期。
		 * 
		 * @param $schedule:Schedule 需要验证的排期。
		 * 
		 * @return Boolean 验证结果，true为在档，false为不在档。
		 * 
		 */
		
		public static function validateScheduleInArchive($schedule:Schedule):Boolean
		{
			return $schedule.type == ScheduleTypeConsts.TURN || 
				$schedule.type == ScheduleTypeConsts.DEFAULT ||
				validateTurn($schedule, new Date);
		}
		
		
		/**
		 * 默认
		 * @private
		 */
		private static function validateDefault($schedule:Schedule, $now:Date):Boolean
		{
			return true;
		}
		
		/**
		 * 轮播
		 * @private
		 */
		private static function validateTurn($schedule:Schedule, $now:Date):Boolean
		{
			//首先日期合法；
		   //v2可以不合法，但是 v1必须合法。
			var v1:Boolean = DateUtil.validate($schedule.startDate);
			var v2:Boolean = DateUtil.validate($schedule.endDate);
			//其次当前时间晚于排期结束时间，或当前时间早于节目起始时间，都处于不在档状态。
			return v1 && v2
				?  (DateUtil.compareDate($now, $schedule.startDate)>= 0 && 
					DateUtil.compareDate($now, $schedule.endDate  )<= 0)
				: (v1 ? DateUtil.compareDate($now, $schedule.startDate)>= 0 : false);
		}
		
		/**
		 * 点播
		 * @private
		 */
		private static function validateDemand($schedule:Schedule, $now:Date):Boolean
		{
			//验证开始与截至日期部分与轮播相同，直接套用。
			var bool:Boolean = validateTurn($schedule, $now);
			//首先日期合法；
			if(!$schedule.repeatWholeDay)
			{
				//非全天点播时，需要检测时段。
				var v1:Boolean = DateUtil.validate($schedule.startTime);
				var v2:Boolean = DateUtil.validate($schedule.endTime);
				bool = (v1 && v2)
					?  (DateUtil.compareTime($now, $schedule.startTime)>= 0 && 
						DateUtil.compareTime($now, $schedule.endTime  ) < 0)
					: (v1 ? DateUtil.compareTime($now, $schedule.startTime)>= 0 : false);
			}
			return bool;
		}
		
		/**
		 * 重复
		 * @private
		 */
		private static function validateRepeat($schedule:Schedule, $now:Date):Boolean
		{
			//验证开始与截至日期部分与轮播相同，直接套用。
			var bool:Boolean = validateTurn($schedule, $now);
			//处理重复类型
			if (bool)
			{
				if(!REPT[Consts.INIT])
				{
					REPT[Consts.INIT] = true;
					REPT[ScheduleRepeatTypeConsts.DAY  ] = validateDemand;
					REPT[ScheduleRepeatTypeConsts.WEEK ] = resolveWeek;
					REPT[ScheduleRepeatTypeConsts.MONTH] = resolveMonth;
					REPT[ScheduleRepeatTypeConsts.YEAR ] = resolveYear;
				}
				var extra:ScheduleTypeExtra = $schedule.extra;
				bool = REPT[extra.repeatType] 
					?  REPT[extra.repeatType]($schedule, $now) : bool;
			}
			return bool;
		}
		
		/**
		 * 插播
		 * @private
		 */
		private static function validateSpots($schedule:Schedule, $now:Date):Boolean
		{
			//验证开始与截至日期部分与轮播相同，直接套用。
			var bool:Boolean = validateTurn($schedule, $now);
			
			//非全天点播时，需要检测时段。
			var v1:Boolean = DateUtil.validate($schedule.startTime);
			var v2:Boolean = DateUtil.validate($schedule.endTime);
			bool = (v1 && v2)
				?  (DateUtil.compareTime($now, $schedule.startTime)>= 0 && 
					DateUtil.compareTime($now, $schedule.endTime  ) < 0)
				: (v1 ? DateUtil.compareTime($now, $schedule.startTime)>= 0 : false);
			return bool;
		}
		
		
		/**
		 * @private
		 */
		private static function resolveWeek($schedule:Schedule, $now:Date):Boolean
		{
			return $schedule.extra.weekDays.indexOf($now.day) != -1
				? validateDemand($schedule, $now) : false;
		}
		
		/**
		 * @private
		 */
		private static function resolveMonth($schedule:Schedule, $now:Date):Boolean
		{
			return validateDemand($schedule, $now) && 
				($schedule.extra.monthType == ScheduleMonthTypeConsts.DAY
				?  $now.date == $schedule.extra.monthDay
				:  $now.day  == $schedule.extra.monthWeekDay 
				&& $schedule.extra.monthWeek == DateUtil.getWeekOfMonth($now));
		}
		
		/**
		 * @private
		 */
		private static function resolveYear($schedule:Schedule, $now:Date):Boolean
		{
			if(!$schedule.extra.yearMonthType)
			{
				return $now.month == $schedule.extra.yearMonth && 
						$now.date  == $schedule.extra.yearMonthDay;
			}
			else
			{
				
				return false;
			}
		}
		
		/**
		 * @private
		 */
		private static function subtract($date1:Date, $date2:Date):Object
		{
			var result:Object = {};
			result.fullYear = $date1.fullYear - $date2.fullYear;
			result.month    = $date1.month    - $date2.month;
			result.date     = $date1.date     - $date2.date;
			result.hours    = $date1.hours    - $date2.hours;
			result.minutes  = $date1.minutes  - $date2.minutes;
			result.seconds  = $date1.seconds  - $date2.seconds;
			return result;
		}
		
		/**
		 * @private
		 */
		private static function initializeTypes():void
		{
			if(!TYPE[Consts.INIT])
			{
				TYPE[Consts.INIT] = true;
				TYPE[ScheduleTypeConsts.DEFAULT] = validateDefault;
				TYPE[ScheduleTypeConsts.TURN   ] = validateDefault;   
				TYPE[ScheduleTypeConsts.DEMAND ] = validateDemand;
				TYPE[ScheduleTypeConsts.REPEAT ] = validateRepeat;
				TYPE[ScheduleTypeConsts.SPOTS  ] = validateSpots;
			}
		}
		
		
		
		/**
		 * @private
		 */
		private static const TYPE:Object = {};
		
		/**
		 * @private
		 */
		private static const REPT:Object = {};
		
	}
}