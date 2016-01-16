package multipublish.vo.documents
{
	
	/**
	 * 
	 * 图片类型文档。
	 * 
	 */
	
	
	public final class ImageDocument extends Document
	{
		
		/**
		 * 
		 * <code>ImageDocument</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function ImageDocument($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * 
		 * 对应产品。
		 * 
		 */
		
		public function get expansion():String
		{
			return getProperty("expansion");
		}
		
	}
}