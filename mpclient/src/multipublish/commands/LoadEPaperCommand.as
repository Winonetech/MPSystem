package multipublish.commands
{
	import cn.vision.net.FTPRequest;
	import cn.vision.net.FTPUploader;
	
	import multipublish.core.MDProvider;
	
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
			
			daysKeep = $url.split("&").pop();
			
			$url = $url.split("&").shift();
			
			
			url = $url.charAt($url.length - 1) == "/" ? $url : $url += "/";
			
//			url  = $url.charAt() == "/" ? $url : "/" + $url;
		}
		
		override public function execute():void
		{
			commandStart();
			
			loadEPaper();
			
			commandEnd();
		}
		
		
		
		private function loadEPaper():void
		{
			modelog("下载电子报。");
			
			//强制更新。
			MDProvider.instance.ePaperMap[url] && MDProvider.instance.ePaperMap[url].update(true, daysKeep);
		}
		
		private var daysKeep:String;
		
		private var url:String;
 	}
}