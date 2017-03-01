package multipublish.commands
{
	
	/**
	 * 
	 * 重新下载失败的文件。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.Cache;
	
	
	public class ReloadFilesCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ReloadFilesCommand($data:String)
		{
			super();
			
			data = $data;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			reloadFiles();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function reloadFiles():void
		{
			if(!StringUtil.isEmpty(data))
			{
				data = data.replace(" ", "");
				var temp:Array = data.split(",");
				for each (var item:String in temp) Cache.cache(item);
				Cache.start();
			}
		}
		
		
		/**
		 * @private
		 */
		private var data:String;
		
	}
}