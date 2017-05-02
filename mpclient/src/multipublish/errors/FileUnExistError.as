package multipublish.errors
{
	
	/**
	 * 
	 * 文件不存在错误。
	 * 
	 */
	
	import cn.vision.core.VSError;
	
	
	public final class FileUnExistError extends VSError
	{
		
		/**
		 * 
		 * <code>FileUnExistError</code>构造函数。
		 * 
		 */
		
		public function FileUnExistError($path:String = "")
		{
			super("文件 " + $path + " 不存在！");
		}
		
	}
}