package multipublish.managers
{
	
	import multipublish.vo.contents.Button;
	import multipublish.vo.programs.Page;
	
	
	public final class ButtonManager
	{
		
		/**
		 * 
		 * 清除所有的按钮组。
		 * 
		 */
		
		public static function clear():void
		{
			GROUP = {};
		}
		
		
		/**
		 * 
		 * 设定页面与按钮关联。
		 * 
		 */
		
		public static function setPageButtonRelation($button:Button, $page:Page):void
		{
			if ($page && $button && $button.selectable)
			{
				if (!$page.button)
				{
					$page.button = $button;
					var group:String = $button.group;
					GROUP[group] = GROUP[group] || [];
					if (GROUP[group].indexOf($button) == -1)
						GROUP[group].push($button);
				}
			}
		}
		
		
		/**
		 * 
		 * 设定组按钮为选中状态。
		 * 
		 */
		
		public static function setButtonSelected($button:Button, $selected:Boolean = true):void
		{
			if ($button && $button.selectable)
			{
				if ($selected)
				{
					var group:Array = GROUP[$button.group];
					for each (var item:Button in group) item.selected = false;
				}
				$button.selected = $selected;
			}
		}
		
		
		/**
		 * @private
		 */
		
		private static var GROUP:Object = {};
		
	}
}