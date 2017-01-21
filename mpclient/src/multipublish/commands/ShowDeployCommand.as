package multipublish.commands
{
	
	/**
	 * 
	 * 显示设置窗口命令。
	 * 
	 */
	
	
	import cn.vision.net.FileSaver;
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.Cache;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	import multipublish.utils.DataUtil;
	import multipublish.views.InstallerView;
	
	
	public final class ShowDeployCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ShowDeployCommand</code>构造函数。
		 * 
		 */
		
		public function ShowDeployCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			showDeploy();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function showDeploy():void
		{
			if(!view.installer)
			{ 
				LogUtil.logTip(MPTipConsts.RECORD_COMMAND_DEPLOY);
				view.main.enabled = false;
				view.application.addElement(view.installer = new InstallerView);
				view.installer.onSubmit = save;
				view.installer.onCancel = exit;
			}
		}
		
		/**
		 * @private
		 */
		private function save():void
		{
			var saver:FileSaver = Cache.save(URLConsts.NATIVE_CONFIG, DataUtil.getConfig());
			saver.addEventListener(Event.COMPLETE, handlerDefault);
			saver.addEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
		}
		
		/**
		 * @private
		 */
		private function exit():void
		{
			view.main.enabled = true;
			view.application.removeElement(view.installer);
			view.installer.onSubmit = null;
			view.installer.onCancel = null;
			view.installer = null;
		}
		
		
		/**
		 * @private
		 */
		private function handlerDefault($e:Event):void
		{
			var saver:FileSaver = $e.target as FileSaver;
			saver.removeEventListener(Event.COMPLETE, handlerDefault);
			saver.removeEventListener(IOErrorEvent.IO_ERROR, handlerDefault);
			
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
			ApplicationUtil.exit();
		}
		
	}
}