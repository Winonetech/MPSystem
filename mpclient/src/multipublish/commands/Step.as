package multipublish.commands
{
	
	/**
	 * 
	 * Step是Command的子项，一个Command可能包含多个Step。
	 * 
	 */
	
	
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.Cache;
	
	import multipublish.consts.MPTipConsts;
	
	
	public class Step extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>Step</code>构造函数。
		 * 
		 */
		
		public function Step()
		{
			super();
		}
		
		
		/**
		 * 
		 * 标记并保存文件。
		 * 
		 * @param $data:* 要保存的数据。
		 * @param $saveURL:String 文件存储路径。
		 * 
		 */
		
		protected function flagSave($loadURL:String, $saveURL:String, $data:*):void
		{
			$loadURL!= $saveURL
				? save($saveURL, $data)
				: flag($saveURL);
		}
		
		
		/**
		 * 
		 * 保存文件。
		 * 
		 * @param $data:* 要保存的数据。
		 * @param $saveURL:String 文件存储路径。
		 * 
		 */
		
		protected function save($saveURL:String, $data:*):void
		{
			LogUtil.logTip(MPTipConsts.RECORD_CACHE_SAVE, $saveURL);
			
			Cache.save($saveURL, $data);
		}
		
		
		/**
		 * 
		 * 标记文件在使用。
		 * 
		 * @param $url:String 文件相对路径。
		 * 
		 */
		
		protected function flag($url:String):void
		{
			Cache.used($url, true);
		}
		
		/**
		 * 
		 * 存入临时数组。
		 * 注意，存入的数组不能是Array。
		 * 
		 * @param $data:* 要保存的数据。
		 * @param $saveURL:String 文件存储路径。
		 * 
		 * @return Boolean 如果存入的数据在该键值下有其他数据，则返回true，如果没有其他数据则返回false。
		 * 
		 */
		
		protected function push($dic:*, $key:String, $obj:*):Boolean
		{
			var item:* = $dic[$key];
			if (item)
			{
				if(!(item is Array))
				{
					if (item != $obj) $dic[$key] = [item, $obj];
				}
				else
				{
					if (item.indexOf($obj) == -1) item[item.length] = $obj;
				}
			}
			else
			{
				$dic[$key] = $obj;
			}
			return item != null;
		}
		
	}
}