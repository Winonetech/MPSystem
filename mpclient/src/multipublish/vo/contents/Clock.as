package multipublish.vo.contents
{
	
	/**
	 * 
	 * 时间数据结构。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	
	[Bindable]
	public final class Clock extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Clock($data:Object=null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("contentSource");
			wt::registCache(url);
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
		}
		
		
		/**
		 * 
		 * 时间FLASH地址。
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