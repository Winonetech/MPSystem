package multipublish.vo.contents
{
	
	/**
	 * 
	 * 网页内容。
	 * 
	 */
	
	
	import cn.vision.utils.HTTPUtil;
	
	import com.winonetech.utils.ConvertUtil;
	
	import multipublish.core.mp;
	

	public final class HTMLWeb extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function HTMLWeb($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			mp::content = HTTPUtil.normalize(getProperty("contentSource"));
		}
		
		
		/**
		 * 
		 * 背景颜色。
		 * 
		 */
		
		override public function get backgroundColor():uint
		{
			var temp:String = getProperty("backgroundColor");
			return temp ? ConvertUtil.touint(temp) : 0xFFFFFF;
		}
		
		
		/**
		 * 
		 * 网址。
		 * 
		 */
		
		public function get content():String
		{
			return mp::content;
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}