package multipublish.vo.contents
{
	
	/**
	 * 
	 * 内容数据结构，可以是以下类型：<br>
	 * 1.自由排版格式；<br>
	 * 2.相册格式；<br>
	 * 3.跑马灯格式；<br>
	 * 4.图片格式；<br>
	 * 5.视频格式。
	 * 
	 * @see com.winonetech.consts.ContentTypeConsts
	 * 
	 */
	
	
	import com.winonetech.core.VO;
	
	
	public class Content extends VO
	{
		
		/**
		 * 
		 * <code>Content</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Content($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * 
		 * 内容类型。
		 * 
		 */
		
		public function get duration():uint
		{
			return getProperty("timelength", uint);
		}
		
		
		/**
		 * 
		 * 内容类型。
		 * 
		 */
		
		public function get type():String
		{
			return getProperty("fileproterty");
		}
		
		
		/**
		 * 
		 * 具体内容，不同类型对应的内容格式不同。
		 * 
		 */
		
		public function get content():String
		{
			return getProperty("getcontents");
		}
		
	}
}