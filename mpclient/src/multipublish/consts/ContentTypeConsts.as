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
		 * @default flash
		 * 
		 * @see com.winonetech.vo.contents.Gallery
		 * 
		 */
		
		public static const GALLERY:String = "flash";
		
		
		/**
		 * 
		 * 跑马灯格式。
		 * 
		 * @default text
		 * 
		 * @see com.winonetech.vo.contents.Marquee
		 * 
		 */
		
		public static const MARQUEE:String = "text";
		
		
		/**
		 * 
		 * 图片格式。
		 * 
		 * @default iamge
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
		
	}
}