package multipublish.views.elements.arrange
{
	
	/**
	 * 
	 * 排版按钮。
	 * 
	 */
	
	
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.controls.ImageButton;
	
	import flash.events.IOErrorEvent;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.core.mp;
	import multipublish.skins.ImageBrokenSkin;
	import multipublish.vo.elements.ArrangeIcon;
	
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	
	
	public final class ArrangeButton extends ImageButton
	{
		
		/**
		 * 
		 * <code>ArrangeButton</code>构造函数。
		 * 
		 */
		
		public function ArrangeButton()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			fillMode  = BitmapFillMode .SCALE;
			scaleMode = BitmapScaleMode.ZOOM;
			
			setStyle("skinClass", ImageBrokenSkin);
		}
		
		
		/**
		 * 
		 * 数据源。
		 * 
		 */
		
		public function get data():ArrangeIcon
		{
			return mp::data;
		}
		
		/**
		 * @private
		 */
		public function set data($value:ArrangeIcon):void
		{
			mp::data = $value;
			x = data.iconX;
			y = data.iconY;
			width  = data.iconWidth;
			height = data.iconHeight;
			addEventListener(IOErrorEvent.IO_ERROR, handlerIOError, false, 0, true);
			source = data.thumbnail;
			
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		
		/**
		 * @private
		 */
		private function handlerIOError($e:IOErrorEvent):void
		{
			LogUtil.logTip(MPTipConsts.NOTICE_COVER_UNEXIST, this);
		}
		
		
		/**
		 * @private
		 */
		mp var data:ArrangeIcon;
		
	}
}