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
	 * 8.yearMonthDay:uint 如果repeatType是每年，该属性可用，表示每年的第几个月的第几天，取值范围1-31。
	 * </p>
	 * 
	 */
	
	
	import cn.vision.consts.Consts;
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
					FUNC[Consts.INIT] = true;
					FUNC[ScheduleRepeatTypeConsts.DAY  ] = resolveDay;
					FUNC[ScheduleRepeatTypeConsts.WEEK ] = resolveWeek;
					FUNC[ScheduleRepeatTypeConsts.MONTH] = resolveMonth;
					FUNC[ScheduleRepeatTypeConsts.YEAR ] = resolveYear;
				}
				var array:Array = $extra.split(" ");
				resolveRepeatType(array);
				FUNC[repeatType](array);
			}
		}
		
		/**
		 * @private
		 */
		private function resolveRepeatType($array:Array):void
		{
			if ($array[3] == "?" && $array[4] == "*")
			{
				repeatType = $array[5].indexOf("#") == -1 ? 1 : 2;
			}
			else if (!isNaN($array[3]))
			{
				repeatType = isNaN($array[4]) ? 2 : 3;
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
			var temp:Array = $array[5].split(",");
			weekDays = temp.map(function($e:*, $i:int, $a:Array):uint{return --$e});
		}
		
		/**
		 * @private
		 */
		private function resolveMonth($array:Array):void
		{
			monthType = isNaN(Number($array[3])) ? 1 : 0;
			if (monthType)
			{
				var temp:Array = $array[5].split("#");
				monthWeek = temp[1];
				monthWeekDay = --temp[0];
			}
			else
			{
				monthDay = $array[3];
			}
		}
		
		/**
		 * @private
		 */
		private function resolveYear($array:Array):void
		{
			yearMonth  = --$array[4];
			yearMonthDay = $array[3];
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
		 * 如果repeatType是每年，该属性可用，表示每年的第几个月的第几天，取值范围1-31。
		 * 
		 */
		
		public var yearMonthDay:uint;
		
		
		/**
		 * @private
		 */
		private static const FUNC:Object = {};
		
	}
}