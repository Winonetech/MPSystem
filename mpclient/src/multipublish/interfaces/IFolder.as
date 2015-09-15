package multipublish.interfaces
{
	
	/**
	 * 
	 * 文件夹类型接口。
	 * 
	 */
	
	
	import multipublish.vo.documents.Document;
	
	
	public interface IFolder extends IThumbnail
	{
		
		/**
		 * 
		 * 添加媒体文件。
		 * 
		 */
		
		function addDocument($document:Document):Document;
		
		
		/**
		 * 
		 * 媒体文件列表。
		 * 
		 */
		
		function get documents():Vector.<Document>;
		
	}
}