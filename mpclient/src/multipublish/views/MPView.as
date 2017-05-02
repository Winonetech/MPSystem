package multipublish.views
{
	
	/**
	 * 
	 * 视图的基类。
	 * 
	 */
	
	
	import cn.vision.datas.Tip;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.core.VO;
	import com.winonetech.core.View;
	
	import multipublish.core.MPCConfig;
	
	
	public class MPView extends View
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function MPView()
		{
			super();
		}
		
		
		/**
		 * 
		 * 日志记录。
		 * 
		 * @param $tip:Tip 相关提示。
		 * @param $meta:* (default = null) 相关数据。
		 * 
		 */
		
		protected function log($tip:Tip, $meta:* = null):String
		{
			return LogUtil.logTip($tip, $meta);
		}
		
		
		/**
		 * @private
		 */
		protected function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
	}
}