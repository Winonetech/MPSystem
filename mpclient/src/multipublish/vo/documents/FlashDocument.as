package multipublish.vo.documents
{
	
	/**
	 * 
	 * FLASH类型文档。
	 * 
	 */
	
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.interfaces.IThumbnail;
	
	
	public final class FlashDocument extends Document implements IThumbnail
	{
		
		/**
		 * 
		 * <code>FlashDocument</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function FlashDocument($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("thumbnailpath");
			mp::thumbnail = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			wt::registCache(url);
			registThumbnail();
			
			mp::time = getProperty("runningtime", uint);
		}
		
		
		/**
		 * @private
		 */
		private function registThumbnail():void
		{
			parent && parent.wt::registCache(Cache.gain(thumbnail));
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent($value:VO):void
		{
			super.parent = $value;
			
			registThumbnail();
		}
		
		/**
		 * @inheritDoc
		 */
		[Bindable]
		public function get thumbnail():String
		{
			return mp::thumbnail;
		}
		
		/**
		 * @private
		 */
		public function set thumbnail($value:String):void
		{
			mp::thumbnail = $value;
		}
		
		
		/**
		 * 
		 * 时间长度。
		 * 
		 */
		
		public function get time():uint
		{
			return mp::time;
		}
		
		
		/**
		 * @private
		 */
		mp var thumbnail:String;
		
		/**
		 * @private
		 */
		mp var time:uint;
		
	}
}