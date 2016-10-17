package multipublish.commands
{
	
	/**
	 * 
	 * 视图初始化。
	 * 
	 */
	
	
	import cn.vision.managers.KeyboardManager;
	import cn.vision.utils.LogUtil;
	
	import flash.events.Event;
	
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.views.MainView;
	
	
	public final class InitializeViewCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>InitializeViewCommand</code>构造函数。
		 * <br>初始化视图  & 快捷键设置
		 * 
		 */
		
		public function InitializeViewCommand()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_VIEW);
			
			initializeView();
			
			initializeKeyboard();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initializeView():void
		{
			view.application.addElementAt(view.main = new MainView, 0);
			view.installer = null;
		}
		
		/**
		 * @private
		 */
		private function initializeKeyboard():void
		{
			if (view.application.stage)
			{
				LogUtil.logTip(MPTipConsts.RECORD_KEYBOARD_REG);
				
				manager.initialize(view.application.stage);
				
				//ctrl + i
				manager.registControl(presenter.showDeploy, [17, 73], false);
			}
			else
			{
				var handlerAddedToStage:Function = function($e:Event):void
				{
					view.application.removeEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
					
					LogUtil.logTip(MPTipConsts.RECORD_KEYBOARD_REG);
					
					manager.initialize(view.application.stage);
					
					//ctrl + i
					manager.registControl(presenter.showDeploy, [17, 73], false);
				};
				view.application.addEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
			}
		}
		
		
		/**
		 * @private
		 */
		private function get manager():KeyboardManager
		{
			return KeyboardManager.keyboardManager;
		}
		
	}
}