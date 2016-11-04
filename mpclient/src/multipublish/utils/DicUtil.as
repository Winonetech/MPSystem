package multipublish.utils
{
	import cn.vision.core.NoInstance;
	
	public class DicUtil extends NoInstance
	{
		
		/**
		 * 
		 * 存入临时数组。
		 * 注意，存入的数据不能是Array。
		 * 
		 * @param $data:* 要保存的数据。
		 * @param $saveURL:String 文件存储路径。
		 * 
		 * @return Boolean 如果存入的数据在该键值下有其他数据，则返回true，如果没有其他数据则返回false。
		 * 
		 */
		
		public static function push($dic:*, $key:String, $obj:*):Boolean
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
					item[item.length] = $obj;
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