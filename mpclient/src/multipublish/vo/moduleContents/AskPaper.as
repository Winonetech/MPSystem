package multipublish.vo.moduleContents
{
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	public final class AskPaper extends Content
	{
		
		
		/**
		 * 
		 * 问卷调查。
		 * 
		 */
		
		public function AskPaper(
			$data:Object = null, 
			$name:String = "askPaper", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
			{
				super($data, $name, $useWait, $cacheGroup);
			}
		
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("url", String);
			if (!StringUtil.isEmpty(url))
			{
				wt::registCache(url);
				mp::bcg = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
			}
			
			resolveItem();
		}
	
		
		private function resolveItem():void
		{
			var tempItem:Array = getProperty("item", Array);
			
			for each (var o:Object in tempItem)
			{
				var tempA:Array  = []; 
				
				for each (var oo:Object in o.options)
				{
					tempA.push([oo.id, oo.opcontent]);
				}
				
				mp::contents[o.id] = [o.tptype, o.tptitle, tempA];
			}
		}
		
		
		
		public function get item():Array
		{
			return mp::item;
		}
		
		public function get bcg():String
		{
			return mp::bcg;
		}
		
		
		/**
		 * 
		 * 存储问卷标题和选项。<br>
		 * 格式为:{id:[选项类型, 题目, [选项1, 选项2, ...]]}。
		 * 
		 */
		
		public function get contents():Object
		{
			return mp::contents;
		}
		
		mp var contents:Object = {};
		
		mp var bcg:String;
		
		mp var item:Array;
	}
}