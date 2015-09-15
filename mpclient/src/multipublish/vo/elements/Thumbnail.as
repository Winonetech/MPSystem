package multipublish.vo.elements
{
	
	import cn.vision.utils.ArrayUtil;
	
	import multipublish.core.mp;
	import multipublish.interfaces.IFolder;
	import multipublish.vo.documents.Document;
	
	
	public final class Thumbnail extends Element implements IFolder
	{
		
		public function Thumbnail($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		public function addDocument($document:Document):void
		{
			ArrayUtil.push(documents, $document);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		public function get documents():Vector.<Document>
		{
			return mp::documents;
		}
		
		
		/**
		 * @private
		 */
		mp var documents:Vector.<Document>;
		
	}
}