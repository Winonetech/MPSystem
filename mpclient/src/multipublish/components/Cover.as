package multipublish.components
{
	import mx.core.UIComponent;
	
	public class Cover extends UIComponent
	{
		public function Cover()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
			graphics.endFill();
		}
		
	}
}