package multipublish.commands
{
	
	/**
	 * 
	 * 发送LED
	 * 
	 */
	
	
	import cn.vision.system.VSFile;
	import cn.vision.utils.Base64Util;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.RegexpUtil;
	import cn.vision.utils.StringUtil;
	
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.URLConsts;
	import multipublish.utils.ConfigUtil;
	
	
	public final class SendLedCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function SendLedCommand($data:String = null)
		{
			super();
			
			$data = Base64Util.decode($data);
			
			data = ($data == null) ? config.sled : $data;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			sendLed();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function sendLed():void
		{
			if (!StringUtil.isEmpty(data))
			{
				try
				{
					if (config.sled!= data)
					{
						config.sled = data;
						
						ConfigUtil.saveNativeData();
						ConfigUtil.backupConfig();
						
						writeData(RegexpUtil.replaceTag(DATA, config.sled));
					}
					
				} catch(e:Error) { }
			}
		}
		
		
		/**
		 * @private
		 */
		private function writeData(str:String):void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.LED_DATA));
			var stream:FileStream = new FileStream;
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(str);
			stream.close();
		}
		
		
		/**
		 * @private
		 */
		private static const DATA:String = 
			"﻿<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + 
			"<rss columnname=\"滚动字幕\" sendtime=\"2014-10-11 14:18:34\" starttime=\"2014-10-11 08:00:00\" endtime=\"2014-10-11 18:00:00\" type=\"1\" playCount=\"\">\n" + 
			"<item title=\"\" content=\"{$self}\" />\n" + 
			"<cliplist title=\"\">\n" + 
			"<clip content=\"111\" />\n" + 
			"<clip content=\"222\" />\n" + 
			"</cliplist>\n" + 
			"</rss>";
		
		
		/**
		 * @private
		 */
		private var data:String;
		
	}
}