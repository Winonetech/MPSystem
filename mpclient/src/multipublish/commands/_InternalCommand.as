package multipublish.commands
{
	
	/**
	 * 
	 * 命令基类。
	 * 
	 */
	
	
	import cn.vision.data.Tip;
	import cn.vision.pattern.core.Command;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.RegexpUtil;
	
	import com.winonetech.core.Store;
	import com.winonetech.utils.TipUtil;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCPresenter;
	import multipublish.core.MPCView;
	
	
	internal class _InternalCommand extends Command
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function _InternalCommand()
		{
			super();
		}
		
		
		/**
		 * 
		 * 阐述当前状态。
		 * 
		 * @param $state:String 状态描述。
		 * 
		 */
		
		protected function modelog($state:String):void
		{
			LogUtil.log("State:" + (config.state = $state));
		}
		
		
		/**
		 * 
		 * 弹出提示框。
		 * 
		 * @param $tip:Tip 提示数据结构。
		 * @param $flags:uint (default = 4) 显示的按钮。
		 * @param $handler:Function (default = null) 按下任意按钮时将调用的事件处理函数。
		 * @param $default:uint (default = 4) 指定默认按钮的位标志。
		 * 
		 */
		
		protected function tip($tip:Tip, $flags:uint = 4, $handler:Function = null, $default:uint = 4):void
		{
			TipUtil.tip($tip, $flags, $handler, $default);
		}
		
		
		/**
		 * 
		 * 设置。
		 * 
		 */
		
		protected function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		
		/**
		 * 
		 * 核心处理。
		 * 
		 */
		
		protected function get presenter():MPCPresenter
		{
			return MPCPresenter.instance;
		}
		
		
		/**
		 * 
		 * 存储管理。
		 * 
		 */
		
		protected function get store():Store
		{
			return Store.instance;
		}
		
		
		/**
		 * 
		 * 视图管理。
		 * 
		 */
		
		protected function get view():MPCView
		{
			return MPCView.instance;
		}
		
	}
}