package multipublish.vo.schedules
{
	
	/**
	 * 
	 * 排期数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ObjectUtil;
	
	import com.winonetech.core.VO;
	
	import multipublish.consts.ScheduleTypeConsts;
	import multipublish.core.mp;
	import multipublish.utils.ScheduleUtil;
	import multipublish.vo.programs.Program;
	

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
		
		
		public function removeAllPrograms():void
		{
			programs.length = 0;
		}
		
		
		/**
		 * 
		 * 添加节目。
		 * 
		 */
		
		public function addProgram($program:Program):void
		{
			programs[programs.length] = $program;
		}
		
		
		/**
		 * 
		 * 获取节目。
		 * 
		 */
		
		public function getProgram($id:String):Program
		{
			for each (var program:Program in programs)
			{
				if (program.id == $id) 
				{
					var result:Program = program;
					break;
				}
			}
			return result;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::programs = new Vector.<Program>;
		}
		
		/**
		 * @private
		 */
		private function resolveExtra():ScheduleTypeExtra
		{
			if (type == ScheduleTypeConsts.REPEAT)
				var extra:ScheduleTypeExtra = new ScheduleTypeExtra(getProperty("dateExpression"));
			return  extra;
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
		 * 是否为全天。
		 * 
		 */
		
		public function get repeatWholeDay():Boolean
		{
			return getProperty("repeatWholeDay", Boolean);
		}
		
		
		/**
		 * 
		 * 开始日期。
		 * 
		 */
		
		public function get startDate():Date
		{
			return getProperty("startDate", Date, DATE_FORMATER);
		}
		
		/**
		 * @private
		 */
		public function set startDate($value:Date):void
		{
			setProperty("startDate", ObjectUtil.convert($value, String, DATE_FORMATER));
		}
		
		
		/**
		 * 
		 * 结束日期。
		 * 
		 */
		
		public function get endDate():Date
		{
			return getProperty("endDate", Date, DATE_FORMATER);
		}
		
		/**
		 * @private
		 */
		public function set endDate($value:Date):void
		{
			setProperty("endDate", ObjectUtil.convert($value, String, DATE_FORMATER));
		}
		
		
		/**
		 * 
		 * 开始时间。
		 * 
		 */
		
		public function get startTime():Date
		{
			var bool:Boolean = type == ScheduleTypeConsts.SPOTS;
			
			mp::startTime = bool ? new Date
				: ( mp::startTime || getProperty("startTime", Date, TIME_FORMATER) );
			
			return mp::startTime;
		}
		
		
		/**
		 * 
		 * 结束时间。
		 * 
		 */
		
		public function get endTime():Date
		{
			if(!mp::endTime)
			{
				if (type == ScheduleTypeConsts.SPOTS)
				{
					var start:Date = getProperty("startTime", Date, TIME_FORMATER);
					var end  :Date = getProperty("endTime", Date, TIME_FORMATER);
					mp::endTime = ScheduleUtil.modifySpotScheduleDate(startTime, start, end);
				}
				else
				{
					mp::endTime = getProperty("endTime", Date, TIME_FORMATER);
				}
			}
			return mp::endTime;
		}
		
		
		/**
		 * 
		 * 修改时间。
		 * 
		 */
		
		public function get timeModify():Date
		{
			return getProperty("modifyDate", Date, TIME_FORMATER);
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
		
		
		public function get programs():Vector.<Program>
		{
			return mp::programs;
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
		mp var startTime:Date;
		
		/**
		 * @private
		 */
		mp var endTime:Date;
		
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
		mp var programs:Vector.<Program>;
		
		
		/**
		 * @private
		 */
		private static const PRIORITY:Object = {5:1, 1:2, 2:3, 3:4, 4:5};
		
		/**
		 * @private
		 */
		private static const DATE_FORMATER:String = "YYYY-MM-DD HH:MI:SS";
		
		/**
		 * @private
		 */
		private static const TIME_FORMATER:String = "YYYY-MM-DD HH:MI:SS";
		
	}
}