package multipublish.vo.contents
{
	
	/**
	 * 
	 * 图片格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	
	
	public final class Picture extends Content
	{
		
		/**
		 * 
		 * <code>Picture</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Picture($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("gainContents");
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			wt::registCache(url);
		}
		
		
		/**
		 * 
		 * 图片地址。
		 * 
		 */
		
		override public function get content():String
		{
			return mp::content;
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}