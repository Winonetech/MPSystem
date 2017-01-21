package multipublish.utils
{
	
	/**
	 * 
	 * 其他模块工具，用于获取视图与数据结构。
	 * 包含的模块：民意调查，应急播报，公告通知。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	
	import multipublish.views.LayoutView;
	import multipublish.views.moduleContents.AskPaperView;
	import multipublish.views.moduleContents.EmergencyBroadView;
	import multipublish.views.moduleContents.noticeView.FindPersonView;
	import multipublish.views.moduleContents.noticeView.WelcomeView;
	import multipublish.vo.moduleContents.AskPaper;
	import multipublish.vo.moduleContents.EmergencyBroad;
	import multipublish.vo.moduleContents.Notice;
	
	
	public final class ModuleUtil extends NoInstance
	{
		
		/**
		 * 
		 * 获取其他模块数据结构。
		 * 
		 */
		
		public static function getModuleVO($index:int):Class
		{
			return MVOS[$index];
		}
		
		
		/**
		 * 
		 * 获取其他模块视图。
		 * 
		 */
		
		public static function getModuleView($index:int, $noticeType:int = 0):Class
		{
			return  $index == 3 ? MVIEWS[$index][$noticeType - 1] : MVIEWS[$index];
		}
		
		/**
		 * @private
		 * 模块类型字典。     <br>
		 * 0 -> 其他模块。<br>
		 * 1 -> 民意调查。<br>
		 * 2 -> 应急播报。<br>
		 * 3 -> 公告通知。
		 */
		private static const MVIEWS:Object = 
		{
			0 : LayoutView,
			1 : AskPaperView,
			2 : EmergencyBroadView,
			3 :[FindPersonView, WelcomeView]
		};
		
		/**
		 * @private
		 */
		private static const MVOS:Object = 
		{
			1 : AskPaper,
			2 : EmergencyBroad,
			3 : Notice
		};
		
	}
}