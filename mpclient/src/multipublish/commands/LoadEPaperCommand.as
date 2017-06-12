package multipublish.commands
{
	import cn.vision.collections.Map;
	import cn.vision.net.FTPRequest;
	import cn.vision.net.FTPUploader;
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.Cache;
	
	import multipublish.core.MDProvider;
	import multipublish.core.mp;
	import multipublish.utils.EPaperUtil;
	
	import mx.states.OverrideBase;

	
	/**
	 * 
	 * 下载电子报。
	 * 
	 */
	
	
	public final class LoadEPaperCommand extends _InternalCommand
	{
		public function LoadEPaperCommand($url:String)
		{
			super();
			
			var arr:Array = $url.split("&");
			
			daysKeep = arr.pop();
			
			$url = arr.shift();
			
			url = $url.charAt($url.length - 1) == "/" ? $url : $url += "/";
			
			days = arr[0];
			
			LogUtil.log("重新获取报纸：", url, daysKeep, days);
		}
		
		override public function execute():void
		{
			commandStart();
			
			deletePapers();
			
			loadEPaper();
			
			commandEnd();
		}
		
		
		private function deletePapers():void
		{
			if (days)
			{
				var temp:Array = days.split(",");
				if (temp.length)
				{
					var lPath:String = "cache/" + url;
					LogUtil.log("报纸源本地路径：", lPath);
					for each (var day:String in temp)
					{
						LogUtil.log("删除报纸缓存：", lPath + day);
						var file:VSFile = new VSFile(FileUtil.resolvePathApplication(lPath + day));
						if (file.exists) file.deleteFile();
						LogUtil.log("删除报纸压缩包：", lPath + day + ".zip");
						var zip:VSFile = new VSFile(FileUtil.resolvePathApplication(lPath + day + ".zip"));
						if (zip.exists) zip.deleteFile();
						
						EPaperUtil.mp::unregArchiveUnloadable(lPath + day + ".zip");
					}
				}
			}
			
		}
		
		
		/**
		 * @private
		 */
		private function loadEPaper():void
		{
			modelog("下载电子报。");
			if (MDProvider.instance.channelNow)
			{
				var arr:Map = MDProvider.instance.channelNow.epapersMap;
				
				//强制更新。
				arr[url] && arr[url].update(true, daysKeep);
				
				Cache.start();
			}
		}
		
		
		/**
		 * @private
		 */
		private var daysKeep:String;
		
		/**
		 * @private
		 */
		private var url:String;
		
		/**
		 * @private
		 */
		private var days:String;
		
 	}
}