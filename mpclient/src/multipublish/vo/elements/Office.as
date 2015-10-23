package multipublish.vo.elements
{
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	
	/**
	 * 
	 * 办公文档数据结构。
	 * 
	 */
	
	
	public final class Office extends Element
	{
		
		/**
		 * 
		 * <code>Office</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Office($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var list:* = data["folder"]["item"];
			if (list is Array) list = list[0];
			
			var temp:String = list["filepath"];
			var index:uint = temp.lastIndexOf("/");
			temp = temp.substr(0, index);
			var script:* = list["script"];
			if (script is Array)
			{
				for each (var item:* in script)
				{
					if (item is String && !StringUtil.isEmpty(item))
					{
						script = item;
						break;
					}
				}
			}
			if (script is String)
			{
				var items:Array = script.split(";");
				mp::documents = new Vector.<String>;
				for each (item in items) 
				{
					var oto:Array = item.split("_");
					item = oto[oto.length - 1];
					item = temp + "/" + item;
					var url:String = CacheUtil.extractURI(item, PathConsts.PATH_FILE);
					wt::registCache(item);
					mp::documents.push(url);
				}
				
			}
			
		}
		
		
		public function get documents():Vector.<String>
		{
			return mp::documents;
		}
		
		
		mp var documents:Vector.<String>;
		
	}
}