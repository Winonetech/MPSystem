package multipublish.commands
{
	import cn.vision.utils.FileUtil;
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import multipublish.consts.DataConsts;

	public class InitDelayModuleCommand extends _InternalCommand
	{
		
		
		public function InitDelayModuleCommand()
		{
			super();
		}
		
		
		
		override public function execute():void
		{
			commandStart();
			
			delay(1, dealDelay);    //延迟 1s是为了让 new排期生成 dat文件而不是生成 tmp文件。
		}
		
		
		private function delay($time:uint, $f:Function):void
		{
			var timer:Timer = new Timer($time * 1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, $f);
			timer.start();
		}
		
		
		private function dealDelay(e:TimerEvent = null):void
		{
			var source:File = new File(File.applicationDirectory.
				resolvePath(DataConsts.NEW_CHANNEL).nativePath);
			var target:File = new File(File.applicationDirectory.
				resolvePath(DataConsts.PATH_CHANNEL).nativePath);
			
			if (!source.exists) 
			{
				commandEnd();
				return;
			}
			else if (FileUtil.compareFile(source, target))
			{
				source.deleteFile();
				commandEnd();
				return;
			}
			
			
			if (count == 0)
			{
				presenter.initializeModule("fromDelay", true);
			}
			else if (count == 1)
			{
				source.moveTo(target, true);
				
				if (source.exists) source.deleteFile();
			}
			
			count++;
			
			commandEnd();
		}
		
		/**
		 * 
		 * 一个控制器。<br>
		 * 当count为0的时候为解析新排期。<br>
		 * 当count为1的时候为新排期替换至老排期。
		 * 
		 */
		
		public static var count:uint = 0;
		
	}
}