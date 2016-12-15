package multipublish.views.elements
{
	
	/**
	 * 
	 * 子元素页面基类。
	 * 
	 */
	
	
	import multipublish.core.mp;
	import multipublish.views.MPView;
	import multipublish.views.contents.TypesetView;
	import multipublish.vo.elements.Element;
	
	
	public class ElementView extends MPView
	{
		
		/**
		 * 
		 * <code>ElementView</code>构造函数。
		 * 
		 */
		
		public function ElementView()
		{
			super();
		}
		
		
		/**
		 * 
		 * 返回上一级。
		 * 
		 */
		
		protected function back():void
		{
			if (!tweening && element && typeset)
				typeset.back();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			mp::element = data as Element;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function updateDisplayList($unscaledWidth:Number, $unscaledHeight:Number):void
		{
			super.updateDisplayList($unscaledWidth, $unscaledHeight);
			if (lastWidth != $unscaledWidth && 
				lastHeight!= $unscaledHeight)
			{
				lastWidth  = $unscaledWidth;
				lastHeight = $unscaledHeight;
				drawBackground($unscaledWidth, $unscaledHeight);
			}
		}
		
		
		/**
		 * 
		 * 画背景。
		 * 
		 * @param $w:Number 宽度。
		 * @param $h:Number 高度。
		 * 
		 */
		
		protected function drawBackground($w:Number, $h:Number):void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawRect(0, 0, $w, $h);
			graphics.endFill();
		}
		
		
		/**
		 * 
		 * 元素数据。
		 * 
		 */
		
		public function get element():Element
		{
			return mp::element;
		}
		
		
		/**
		 * @private
		 */
		protected function get typeset():TypesetView
		{
			return parent.parent.parent.parent as TypesetView;
		}
		
		
		/**
		 * @private
		 */
//		[Bindable]
//		protected var tweening:Boolean;
//		
		/**
		 * @private
		 */
		protected var lastWidth:Number;
		
		/**
		 * @private
		 */
		protected var lastHeight:Number;
		
		
		/**
		 * @private
		 */
		mp var element:Element;
		
	}
}