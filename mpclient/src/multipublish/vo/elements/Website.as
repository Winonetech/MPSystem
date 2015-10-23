package multipublish.vo.elements
{
	
	/**
	 * 
	 * 网页类型。
	 * 
	 */
	
	
	import cn.vision.utils.XMLUtil;
	
	import multipublish.core.mp;
	import multipublish.interfaces.IFolder;
	import multipublish.vo.documents.Document;
	
	
	public final class Website extends Element
	{
		
		/**
		 * 
		 * <code>Website</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Website($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			var list:* = data["folder"];
			if (list)
			{
				mp::url = XMLUtil.convert(list["item"]["web_url"]);
			}
		}
		
		
		/**
		 * 
		 * 网址。
		 * 
		 */
		
		public function get url():String
		{
			return mp::url;
		}
		
		
		/**
		 * @private
		 */
		mp var url:String;
		
	}
}