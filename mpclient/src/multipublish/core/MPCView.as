package multipublish.core
{
	
	/**
	 * 
	 * 视图管理器，定义了一些视图变量。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.core.VSObject;
	import cn.vision.errors.SingleTonError;
	
	import com.winonetech.components.progress.ProgressWindow;
	
	import flash.media.Video;
	
	import input.Input;
	
	import multipublish.consts.ContentConsts;
	import multipublish.views.*;
	
	import spark.components.VideoDisplay;
	import spark.components.WindowedApplication;
	
	
	public final class MPCView extends VSObject
	{
		
		/**
		 * 
		 * <code>MPCView</code>构造函数。
		 * 
		 */
		
		public function MPCView()
		{
			if(!instance) 
			{
				super();
				treeVideo = initTreeVideo();
			}
			else throw new SingleTonError(this);
		}
		
		private function initTreeVideo():VideoDisplay
		{
			var video:VideoDisplay = new VideoDisplay;
			video.width = application.width;
			video.height = application.height;
			video.autoDisplayFirstFrame = true;
			video.loop = true;
			video.scaleMode = "letterbox";
			return video;
		}
		
		
		/**
		 * 
		 * 主窗口。
		 * 
		 */
		
		public function get application():WindowedApplication
		{
			return MPCPresenter.instance.application;
		}
		
		
		/**
		 * 
		 * 欢迎页。
		 * 
		 */
		
		public var guild:GuildView;
		
		
		/**
		 * 
		 * 主页面。
		 * 
		 */
		
		public var main:MainView;
		
		
		/**
		 * 
		 * 设置页面。
		 * 
		 */
		
		public var installer:InstallerView;
		
		
		/**
		 * 
		 * 键盘。
		 * 
		 */
		
		public var keyboard:Input;
		
		
		/**
		 * 
		 * 进度。
		 * 
		 */
		
		public var progress:ProgressWindow = new ProgressWindow;
		
		
		/**
		 * 
		 * 下载演示视频。
		 * 
		 */
		
		public var treeVideo:VideoDisplay;
		
		
		/**
		 * 
		 * 单例引用。
		 * 
		 */
		
		public static const instance:MPCView = new MPCView;
		
	}
}