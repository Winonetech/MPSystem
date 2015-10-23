package multipublish.views.documents
{
	import com.winonetech.events.ControlEvent;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import multipublish.skins.ImageBrokenSkin;
	
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	
	import spark.components.Image;
	import spark.layouts.HorizontalAlign;
	import spark.layouts.VerticalAlign;

	public class ImageDocumentView extends DocumentView
	{
		public function ImageDocumentView()
		{
			super();
			
			initializeEnvironment();
		}
		
		private function initializeEnvironment():void
		{
			addElement(image = new Image);
			image.percentWidth = image.percentHeight = 100;
			image.fillMode = BitmapFillMode.SCALE;
			image.scaleMode = BitmapScaleMode.ZOOM;
			image.horizontalAlign = HorizontalAlign.CENTER;
			image.verticalAlign = VerticalAlign.MIDDLE;
			image.setStyle("skinClass", ImageBrokenSkin);
			image.smooth = true;
			image.addEventListener(Event.COMPLETE, handlerDefault);
			image.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			image.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerDefault);
		}
		
		override protected function resolveData():void
		{
			super.resolveData();
			
			image.source = media.path;
		}
		
		private function handlerDefault(event:Event):void
		{
			trace("ready");
			dispatchEvent(new ControlEvent(ControlEvent.READY));
		}
		
		private var image:Image;
		
	}
}