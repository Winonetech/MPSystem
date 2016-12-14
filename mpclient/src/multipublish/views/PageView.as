package multipublish.views
{
	
	/**
	 * 
	 * 页面视图
	 * 
	 */
	
	
	import multipublish.managers.ButtonManager;
	import multipublish.vo.programs.Page;
	
	
	public final class PageView extends SheetView
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function PageView()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			//设定相关按钮为非选中状态。
			ButtonManager.setButtonSelected(page.button, false);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			super.processPlay();
			
			//设定相关按钮为选中状态。
			ButtonManager.setButtonSelected(page.button);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			super.resolveData();
			
			//设定相关按钮为选中状态。
			ButtonManager.setButtonSelected(page.button);
		}
		
		
		/**
		 * 
		 * 层级
		 * 
		 */
		
		public function get level():uint
		{
			return page ? page.level : 0;
		}
		
		
		/**
		 * 
		 * 顺序
		 * 
		 */
		
		public function get order():uint
		{
			return page ? page.order : 0;
		}
		
		
		/**
		 * 
		 * 顺序
		 * 
		 */
		
		public function get tweenable():Boolean
		{
			return page ? page.tweenable : 0;
		}
		
		
		/**
		 * 
		 * 是否首页。
		 * 
		 */
		
		public function get home():Boolean
		{
			return page ? page.home : 0;
		}
		
		
		/**
		 * 
		 * 页面数据引用。
		 * 
		 */
		
		public function get page():Page
		{
			return data as Page;
		}
		
		
		/**
		 * 
		 * 父级视图。
		 * 
		 */
		
		public var father:PageView;
		
	}
}