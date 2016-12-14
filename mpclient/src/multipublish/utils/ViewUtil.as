package multipublish.utils
{
	import cn.vision.core.NoInstance;
	import cn.vision.utils.ScreenUtil;
	
	import flash.geom.Rectangle;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.MPCView;
	import multipublish.views.GuildView;
	
	public final class ViewUtil extends NoInstance
	{
		
		/**
		 * 
		 * 显示或隐藏引导界面。
		 * 
		 */
		
		public static function guild($visible:Boolean, $message:String = null):void
		{
			if ($visible)
			{
				view.guild = view.guild || new GuildView;
				
				if(!view.application.contains(view.guild))
				{
					var rect:Rectangle = ScreenUtil.getMainScreenBounds();
					view.guild.width = rect.width;
					view.guild.height = rect.height;
					view.application.addElement(view.guild);
				}
				if ($message) config.state = $message;
			}
			else
			{
				if (view.guild && view.application.contains(view.guild))
				{
					view.application.removeElement(view.guild);
					view.guild = null;
				}
			}
			if (view.main) view.main.enabled = !$visible;
		}
		
		
		/**
		 * @private
		 */
		private static function get view():MPCView
		{
			return MPCView.instance;
		}
		
		/**
		 * @private
		 */
		private static function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
	}
}