package multipublish.vo.schedules
{
	
	/**
	 * 
	 * 排期数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	
	import com.winonetech.core.VO;
	
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.core.mp;
	import multipublish.utils.ScheduleUtil;
	

	public final class Schedule extends VO
	{
		
		/**
		 * 
		 * <code>Schedule</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Schedule($data:Object = null)
		{
			super($data);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 清除所有的Program。
		 * 
		 */
		
		public function removeAllPrograms():void
		{
			mp::programs = new Map;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::programs = new Map;
		}
		
		/**
		 * @private
		 */
		private function resolveExtra():ScheduleTypeExtra
		{
			if (type == ScheduleTypeConsts.REPEAT)
				var extra:ScheduleTypeExtra = new ScheduleTypeExtra(getProperty("cronexpression"));
			return  extra;
		}
		
		
		/**
		 * 
		 * 是否为全天。
		 * 
		 */
		
		public function get allDay():Boolean
		{
			return getProperty("allday", Boolean);
		}
		
		
		/**
		 * 
		 * 结束日期。
		 * 
		 */
		
		public function get dateEnd():Date
		{
			return getProperty("endcron", Date);
		}
		
		
		/**
		 * 
		 * 排期类型的额外信息。如果排期类型属于重复，则该属性可用，包含以下属性。
		 * 
		 */
		
		public function get extra():ScheduleTypeExtra
		{
			return mp::extra || (mp::extra = resolveExtra());
		}
		
		
		/**
		 * 
		 * 开始日期。
		 * 
		 */
		
		public function get dateStart():Date
		{
			return getProperty("startcron", Date);
		}
		
		
		/**
		 * 
		 * 是否有节目。
		 * 
		 */
		
		public function get hasProgram():Boolean
		{
			return mp::programs.length > 0;
		}
		
		
		/**
		 * 
		 * 当前排期节目播放次序。
		 * 
		 */
		
		public function get index():uint
		{
			return mp::index;
		}
		
		/**
		 * @private
		 */
		public function set index($value:uint):void
		{
			if ($value != mp::index)
			{
				if ($value >= mp::programs.length) $value = 0;
				mp::index = $value;
			}
		}
		
		
		public function get programs():Map
		{
			return mp::programs;
		}
		
		/**
		 * 
		 * 结束时间。
		 * 
		 */
		
		public function get timeEnd():Date
		{
			if (type == ScheduleTypeConsts.SPOTS)
			{
				var start:Date = getProperty("start", Date);
				var end  :Date = getProperty("end"  , Date);
				var date :Date = ScheduleUtil.modifySpotScheduleDate(timeStart, start, end);
			}
			else
			{
				date = getProperty("end"  , Date);
			}
			return date;
		}
		
		
		/**
		 * 
		 * 修改时间。
		 * 
		 */
		
		public function get timeModify():Date
		{
			return getProperty("modifydt", Date);
		}
		
		
		/**
		 * 
		 * 开始时间。
		 * 
		 */
		
		public function get timeStart():Date
		{
			if (type == ScheduleTypeConsts.SPOTS)
				mp::time = mp::time || new Date;
			else
				mp::time = getProperty("start", Date);
			return mp::time;
		}
		
		
		/**
		 * 
		 * 摘要。
		 * 
		 */
		
		public function get summary():String
		{
			return getProperty("summary");
		}
		
		
		/**
		 * 
		 * 排期类型，可以是默认，轮播，点播，重复，插播。
		 * 
		 */
		
		public function get type():uint
		{
			return getProperty("type", uint);
		}
		
		
		/**
		 * 
		 * 排期优先级，值越高，优先级越高。
		 * 
		 */
		
		public function get priority():uint
		{
			return PRIORITY[type] || 0;
		}
		
		
		/**
		 * @private
		 */
		mp var time:Date;
		
		/**
		 * @private
		 */
		mp var extra:ScheduleTypeExtra;
		
		/**
		 * @private
		 */
		mp var index:uint;
		
		/**
		 * @private
		 */
		mp var programs:Map;
		
		
		/**
		 * @private
		 */
		private static const PRIORITY:Object = {5:1, 1:2, 2:3, 3:4, 4:5};
		
	}
}