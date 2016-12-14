package multipublish.consts
{
	
	/**
	 * 
	 * ContentTypeConsts 定义了几种内容格式常量。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	
	public final class ContentTypeConsts extends NoInstance
	{
		
		/**
		 * 
		 * 图片格式。
		 * 
		 * @default image
		 * 
		 * @see com.winonetech.vo.contents.Picture
		 * 
		 */
		
		public static const PICTURE:String = "image";
		
		
		/**
		 * 
		 * 视频格式。
		 * 
		 * @default video
		 * 
		 * @see com.winonetech.vo.contents.Video
		 * 
		 */
		
		public static const RECORD:String = "video";
		
		
		/**
		 * 
		 * FLASH格式。
		 * 
		 * @default flash
		 * 
		 */
		
		public static const CARTOON:String = "flash";
		
		
		/**
		 * 
		 * 文本格式。
		 * 
		 * @default text
		 * 
		 */
		
		public static const TEXT:String = "text";
		
		
		/**
		 * 
		 * 跑马灯格式。
		 * 
		 * @default marquee
		 * 
		 */
		
		public static const MARQUEE:String = "marquee";
		
		
		/**
		 * 
		 * 电子报格式
		 * 
		 * @default epaper
		 * 
		 */
		
		public static const EPAPER:String = "epaper";
		
		
		/**
		 * 
		 * 按钮格式
		 * 
		 * @default epaper
		 * 
		 */
		
		public static const BUTTON:String = "button";
		
		
		
		//---------------------------------------------------------
		// 以下不再支持
		//---------------------------------------------------------
		
		
		/**
		 * 
		 * 自由排版格式。
		 * 
		 * @default interactive
		 * 
		 * @see com.winonetech.vo.contents.Typeset
		 * 
		 */
		
		public static const TYPESET:String = "interactive";
		
		
		/**
		 * 
		 * 相册格式。
		 * 
		 * @default gallery
		 * 
		 * @see com.winonetech.vo.contents.Gallery
		 * 
		 */
		
		public static const GALLERY:String = "gallery";
		
	}
}