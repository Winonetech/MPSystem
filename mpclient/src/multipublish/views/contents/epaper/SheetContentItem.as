package multipublish.views.contents.epaper
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import multipublish.core.mp;
	
	import mx.core.UIComponent;
	
	public final class SheetContentItem extends UIComponent
	{
		public function SheetContentItem()
		{
			super();
			
			buttonMode = true;
			
			mouseChildren = false;
			
			addEventListener(MouseEvent.MOUSE_DOWN, item_mouseDownHandler);
		}
		
		/**
		 * @private
		 */
		private function getNum(value:String):Number
		{
			return Number(value.substr(0, value.length - 1)) * .01;
		}
		
		/**
		 * @private
		 */
		private function update():void
		{
			var xs:Array = [];
			var ys:Array = [];
			
			for each (var item:* in data.sheetImageDown.sheetImageDown.point)
			{
				var temp:Array = item.split(",");
				xs.push(parentW * getNum(temp[0]));
				ys.push(parentH * getNum(temp[1]));
			}
			
			
			var rect:Rectangle = new Rectangle;
			rect.left   = Math.min.apply(null, xs);
			rect.right  = Math.max.apply(null, xs);
			rect.top    = Math.min.apply(null, ys);
			rect.bottom = Math.max.apply(null, ys);
			
			alpha = 0;
			
			graphics.clear();
			graphics.lineStyle(5, 0xFF0000, 1);
			graphics.beginFill(0xFF0000, 0);
			graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			graphics.endFill();
		}
		
		private function item_mouseDownHandler(e:MouseEvent):void
		{
			alpha = .5;
			stager = stage;
			stager.addEventListener(MouseEvent.MOUSE_UP, item_mouseUpHandler);
		}
		
		private function item_mouseUpHandler(e:MouseEvent):void
		{
			stager.removeEventListener(MouseEvent.MOUSE_UP, item_mouseUpHandler);
			alpha = 0;
		}
		
		
		/**
		 * 
		 * 数据源
		 * 
		 */
		
		public function get data():Object
		{
			return mp::data;
		}
		
		/**
		 * @private
		 */
		public function set data($value:Object):void
		{
			mp::data = $value;
			
			update();
		}
		
		
		/**
		 * 
		 * 父级宽度。
		 * 
		 */
		
		public var parentW:Number;
		
		
		/**
		 * 
		 * 父级高度。
		 * 
		 */
		
		public var parentH:Number;
		
		
		/**
		 * @private
		 */
		private var stager:Stage;
		
		
		/**
		 * @private
		 */
		mp var data:Object;
		
	}
}