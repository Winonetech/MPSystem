package multipublish.utils
{
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;

	public class VOUtil
	{
		
		/**
		 * 
		 * 为父级注册子集缓存资源。
		 * 
		 */
		
		public static function registCacheParent(parent:VO, path:String):void
		{
			parent && parent.wt::registCache(Cache.gain(path));
		}
		
	}
}