package multipublish.views
{
	
	/**
	 * 
	 * 视图的基类。
	 * 
	 */
	
	
	import cn.vision.data.Tip;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.RegexpUtil;
	
	import com.winonetech.core.View;
	
	import multipublish.core.MPCConfig;
	
	import spark.effects.Rotate;
	
	
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
		 * 颠倒。
		 * 
		 * @param $tween:Boolean 相关提示。
		 * @param $meta:* (default = null) 相关数据。
		 * 
		 */
		
		public function reverse($tween:Boolean = true):void
		{
			aimRotation = aimRotation == 0 ? 180 : 0;
			if ($tween)
			{
				if (rotate)
				{
					rotate.stop();
					rotate = null;
				}
				rotate = new Rotate;
				rotate.target = this;
				rotate.angleFrom = rotation;
				rotate.angleTo = aimRotation;
				rotate.duration = config.zoomTweenTime  * 1000;
				rotate.play();
			}
			else
			{
				rotation = aimRotation;
			}
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
		
		
		/**
		 * @private
		 */
		private var aimRotation:Number = 0;
		
		/**
		 * @private
		 */
		private var rotate:Rotate;
		
	}
}