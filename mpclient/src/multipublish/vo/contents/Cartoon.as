package multipublish.vo.contents
{
	
	/**
	 * 
	 * FLASH动画格式。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.utils.VOUtil;
	
	
	public final class Cartoon extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Cartoon(
			$data:Object = null, 
			$name:String = "cartoon", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			setProperty("contentType", "flash");
			
			var url:String = getProperty("contentSource");
			wt::registCache(url);
			mp::content = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent(value:VO):void
		{
			super.parent = value;
			
			VOUtil.registCacheParent(parent, content as String);
		}
		
		
		/**
		 * 
		 * 内容时长，秒。
		 * 
		 */
		
		public function get duration():uint
		{
			return getProperty("timeLength", uint);
		}
		
		
		/**
		 * 
		 * 图片地址。
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