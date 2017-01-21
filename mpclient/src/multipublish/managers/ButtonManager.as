package multipublish.managers
{
	
	import multipublish.core.MDProvider;
	import multipublish.skins.MPPanelSkin;
	import multipublish.vo.Channel;
	import multipublish.vo.contents.Button;
	import multipublish.vo.programs.Page;
	
	
	public final class ButtonManager
	{
		
		/**
		 * 
		 * 设定组按钮为选中状态。
		 * 
		 */
		
		public static function setButtonSelected($button:Button, $selected:Boolean = true):void
		{
			var channel:Channel = MDProvider.instance.channelNow;
			if (channel) channel.setButtonSelected($button, $selected);
		}
		
	}
}