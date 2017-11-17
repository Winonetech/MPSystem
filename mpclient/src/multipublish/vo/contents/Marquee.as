package multipublish.vo.contents
{
	import cn.vision.utils.ColorUtil;
	
	import mx.states.OverrideBase;

	public final class Marquee extends Content
	{
		public function Marquee($data:Object=null)
		{
			super($data);
			
		}
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var obj:Object = getProperty("getcontents", Object);
			
			backgroundColor = ColorUtil.colorString2uint(obj["backgroundcolor"]);
			fontColor 		= ColorUtil.colorString2uint(obj["fontcolor"]);
			fontSize		= uint(obj["fontsize"]);
			opacity			= uint(obj["opacity"]);
			txtContents		= obj["txtcontents"];
			txtSpeed		= uint(obj["txtspeed"]);
			
			if (txtSpeed == 0) txtSpeed = 30;
		}
		
		/**
		 * 
		 * 背景颜色。
		 * 
		 */
		public var backgroundColor:uint;
		
		
		/**
		 * 
		 * 字体颜色。
		 * 
		 */
		public var fontColor:uint;
		
		
		/**
		 * 
		 * 字体大小。
		 * 
		 */
		public var fontSize:uint;
		
		
		/**
		 * 
		 * 透明度。
		 * 
		 */
		public var opacity:uint;
		
		
		/**
		 * 
		 * 内容。
		 * 
		 */
		public var txtContents:String;
		
		
		/**
		 * 
		 * 移动速度。
		 * 
		 */
		public var txtSpeed:uint;
		
		/**
		 * 
		 * 播放次数。
		 *
		 */
		
		public function get playTime():int 
		{
			return getProperty("playtimes", int) || -1;
		}
	}
}