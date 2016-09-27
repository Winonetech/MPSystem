package multipublish.utils
{
	import cn.vision.core.NoInstance;
	
	import com.winonetech.tools.Cache;
	
	public class ReportUtil extends NoInstance
	{
		
		/**
		 * 
		 * 是否需要汇报
		 * 
		 */
		
		public static function responsable($cache:Cache):Boolean
		{
			return !($cache.extra && $cache.extra.response == false);
		}
	}
}