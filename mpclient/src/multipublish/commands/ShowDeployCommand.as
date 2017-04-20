package multipublish.commands
{
	
	/**
	 * 
	 * 显示设置窗口命令。
	 * 
	 */
	
	
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.URLConsts;
	import multipublish.utils.ConfigUtil;
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
			ConfigUtil.saveNativeData();
			ConfigUtil.backupConfig();
			
			ApplicationUtil.execute(FileUtil.resolvePathApplication(URLConsts.APPLICATION));
			ApplicationUtil.exit();
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
		
	}
}