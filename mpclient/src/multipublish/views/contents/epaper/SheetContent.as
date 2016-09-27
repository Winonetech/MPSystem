package multipublish.views.contents.epaper
{
	import cn.vision.utils.FileUtil;
	
	import multipublish.core.mp;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.Image;
	
	public final class SheetContent extends Group
	{
		public function SheetContent()
		{
			super();
			
			mouseEnabled = false;
		}
		
		
		/**
		 * @private
		 */
		private function update():void
		{
			if (data)
			{
				width  = data.width;
				height = data.height;
				
				removeAllElements();
				
				var image:Image = new Image;
				image.source = data.image;
				image.smooth = true;
				
				addElement(image);
				
				try
				{
					for each (var item:* in data.source.smallStyle)
					{
						var child:SheetContentItem = new SheetContentItem;
						child.parentW = width;
						child.parentH = height;
						child.data = item;
						addElement(child);
					}
				}
				catch (e:Error){}
			}
			
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
		 * @private
		 */
		mp var data:Object;
		
	}
}