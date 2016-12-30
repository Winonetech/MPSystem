package multipublish.vo.schedules
{
	
	/**
	 * 
	 * 排期类型的额外信息。如果排期类型属于重复，则该属性可用。
	 * <p>
	 * 1.repeatType:uint 重复类型，包括：值为0，表示每天，值为1，表示每周，值为2，表示每月，值为3，表示每年；<br>
	 * 2.weekDays:Array 如果是repeatType每周，则该属性可用，包含数字0-6对应周日至周六的一个数组，如[0,3,4,6]，意为每周日，三，四，六；<br>
	 * 3.monthType:uint 如果repeatType每月，则该属性可用，值为0，表示每月的第几天，值为1，表示每月的第几周的第几天；<br>
	 * 4.monthDay:uint 如果repeatType每月，且monthType为0时，该属性可用，表示每月的第几天，取值范围1-31；<br>
	 * 5.monthWeek:uint 如果repeatType每月，且monthType为1时，该属性可用，表示每月的第几周，取值范围1-5；<br>
	 * 6.monthWeekDay:uint 如果repeatType每月，且monthType为1时，该属性可用，表示每月第几周的第几天，取值范围0-6；<br>
	 * 7.yearMonth:uint 如果repeatType是每年，该属性可用，表示每年的第几个月，取值范围1-12；<br>
	 * 8.yearMonthType:uint 如果repeatType是每年，该属性可用，值为0，表示每年的该月的第几天，值为1，表示每年的该月第几周的第几天。<br>
	 * 9.yearMonthDay:uint 如果repeatType是每年，且yearMonthType为0时，该属性可用，表示每年的第几个月的第几天，取值范围1-31。<br>
	 * 10.yearMonthWeek:uint 如果repeatType是每年，且yearMonthType为1时，该属性可用，表示每年的该月的第几周。<br>
	 * 11.yearMonthWeekDay:uint 如果repeatType是每年，且yearMonthType为1时，该属性可用，表示每年的该月的第几周的第几天。<br>
	 * </p>
	 * 
	 */
	
	
	import cn.vision.consts.Consts;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.MathUtil;
	import cn.vision.utils.StringUtil;
	
	import multipublish.consts.ScheduleRepeatTypeConsts;
	
	
	public final class ScheduleTypeExtra
	{
		
		/**
		 * 
		 * <code>ScheduleTypeExtra</code>构造函数。
		 * 
		 * @param $extra:$extra 解析的数据。
		 * 
		 */
		
		public function ScheduleTypeExtra($extra:String)
		{
			initialize($extra);
		}
		
		/**
		 * @private
		 */
		private function initialize($extra:String):void
		{
			if(!StringUtil.isEmpty($extra))
			{
				if(!FUNC[Consts.INIT])
				{ 
					//这里改成 false是为了要一直更新这些方法对象的持有者。
				   //因为如果不实时更新该方法对象，其方法的持有者将一直是第一次进入该赋值区域的对象。
				  //故而赋值将一直赋值给方法的持有者，而不是赋值给当前对象。相当于是调用了一个第一次进入该赋值区域的对象的一个方法。
					FUNC[Consts.INIT] = false;      
					FUNC[ScheduleRepeatTypeConsts.DAY  ] = resolveDay;
					FUNC[ScheduleRepeatTypeConsts.WEEK ] = resolveWeek;
					FUNC[ScheduleRepeatTypeConsts.MONTH] = resolveMonth;
					FUNC[ScheduleRepeatTypeConsts.YEAR ] = resolveYear;
				}
				
				var array:Array = $extra.split("|");
				resolveRepeatType(array);
			    FUNC[repeatType](array);
			}
		}
		
		/**
		 * @private
		 */
		private function resolveRepeatType($array:Array):void
		{
			switch($array[0])
			{
				case "1":
				case "2":
				case "3":
				case "0":
					repeatType = $array[0];
					break;
				default:
					repeatType = 0;
					break;
			}
		}
		
		/**
		 * @private
		 */
		private function resolveDay($array:Array):void {}
		
		/**
		 * @private
		 */
		private function resolveWeek($array:Array):void
		{
			var temp:Array = $array[1].split(",");
			temp = temp.map(function($e:*, $i:int, $a:Array):uint{return MathUtil.clamp($e, 0, 6)});
			weekDays = ArrayUtil.unique(temp);
			weekDays.sort(Array.NUMERIC);
		}
		
		/**
		 * @private
		 */
		private function resolveMonth($array:Array):void
		{
			monthType = $array[1];
			
			if (monthType)
			{
				monthWeek = $array[2];
				monthWeekDay = $array[3];
			}
			else
			{
				monthDay = $array[2];
			}
		}
		
		/**
		 * @private
		 */
		private function resolveYear($array:Array):void
		{
			yearMonth  = int($array[1]) - 1;
			yearMonthType = $array[2];
			if (yearMonthType)
			{
				yearMonthWeek = $array[3];
				yearMonthWeekDay = $array[4];
			}
			else
			{
				yearMonthDay = $array[3];
			}
		}
			
		
		/**
		 * 
		 * 重复类型，包括：值为0，表示每天，值为1，表示每周，值为2，表示每月，值为3，
		 * 表示每年。
		 * 
		 */
		
		public var repeatType:uint;
		
		
		/**
		 * 
		 * 如果是repeatType每周，则该属性可用，包含数字0-6对应周日至周六的一个数组，
		 * 如[0,3,4,6]，意为每周日，三，四，六。
		 * 
		 */
		
		public var weekDays:Array;
		
		
		/**
		 * 
		 * 如果repeatType每月，则该属性可用，值为0，表示每月的第几天，值为1，
		 * 表示每月的第几周的第几天。
		 * 
		 */
		
		public var monthType:uint;
		
		
		/**
		 * 
		 * 如果repeatType每月，且monthType为0时，该属性可用，表示每月的第几天，
		 * 取值范围1-31。
		 * 
		 */
		
		public var monthDay:uint;
		
		
		/**
		 * 
		 * 如果repeatType每月，且monthType为1时，该属性可用，表示每月的第几周，
		 * 取值范围1-5。
		 * 
		 */
		
		public var monthWeek:uint;
		
		
		/**
		 * 
		 * 如果repeatType每月，且monthType为1时，该属性可用，表示每月第几周的第几天，
		 * 取值范围0-6。
		 * 
		 */
		
		public var monthWeekDay:uint;
		
		
		/**
		 * 
		 * 如果repeatType是每年，该属性可用，表示每年的第几个月，取值范围0-11。
		 * 
		 */
		
		public var yearMonth:uint;
		
		
		/**
		 * 
		 * 如果repeatType是每年，该属性可用，为0，表示每年的第几个月的第几天，为1，表示每年的第几个月的第几周的第几天。
		 * 
		 */
		
		public var yearMonthType:uint;
		
		
		/**
		 * 
		 * 如果repeatType是每年，yearMonthType为0时，该属性可用，表示每年的第几个月的第几天，取值范围1-31。
		 * 
		 */
		
		public var yearMonthDay:uint;
		
		
		/**
		 * 
		 * 如果repeatType是每年，yearMonthType为1时，该属性可用，表示每年的第几个月的第几周，取值范围1-5。
		 * 
		 */
		
		public var yearMonthWeek:uint;
		
		
		/**
		 * 
		 * 如果repeatType是每年，yearMonthType为1时，该属性可用，表示每年的第几个月的第几周第几天，取值范围0-6。
		 * 
		 */
		
		public var yearMonthWeekDay:uint;
		
		
		/**
		 * @private
		 */
		private static const FUNC:Object = {};
		
	}
}