package multipublish.vo.elements
{
	
	/**
	 * 
	 * 普通元素数据结构。
	 * 
	 */
	
	
	import cn.vision.utils.ArrayUtil;
	
	import multipublish.consts.ConvertConsts;
	import multipublish.core.mp;
	import multipublish.interfaces.IFolder;
	import multipublish.vo.documents.Document;
	
	
	public class Comman extends Element implements IFolder
	{
		
		/**
		 * 
		 * <code>Comman</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Comman($data:Object = null)
		{
			super($data);
			
			initialize();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		public function addDocument($document:Document):Document
		{
			if ($document)
			{
				$document.parent = this;
				ArrayUtil.push(documents, $document);
			}
			return $document;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			var list:* = data["interval"];
			if (list)
			{
				mp::time = getProperty("interval", uint);
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function toString():String
		{
			return id;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::documents = new Vector.<Document>;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		public function get documents():Vector.<Document>
		{
			return mp::documents;
		}
		
		
		/**
		 * 
		 * 播放时间。
		 * 
		 */
		
		public function get time():uint
		{
			return mp::time;
		}
		
		/**
		 * @private
		 */
		public function set time($value:uint):void
		{
			mp::time = $value;
		}
		
		
		/**
		 * @private
		 */
		mp var documents:Vector.<Document>;
		
		/**
		 * @private
		 */
		mp var time:uint;
		
	}
}