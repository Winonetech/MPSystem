package multipublish.interfaces
{
	
	/**
	 * 
	 * 缩略图接口。
	 * 
	 */
	
	
	public interface IThumbnail
	{
		
		/**
		 * 
		 * 文件夹缩略图。
		 * 
		 */
		
		function get thumbnail():String;
		
		/**
		 * @private
		 */
		function set thumbnail($value:String):void;
		
	}
}