package multipublish.utils
{
	
	/**
	 * 
	 * 内容工具。
	 * 
	 */
	
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.core.NoInstance;
	import cn.vision.utils.FileUtil;
	
	import multipublish.views.LayoutView;
	import multipublish.views.contents.*;
	import multipublish.views.moduleContents.AskPaperView;
	import multipublish.views.moduleContents.EmergencyBroadView;
	import multipublish.views.moduleContents.noticeView.FindPersonView;
	import multipublish.views.moduleContents.noticeView.WelcomeView;
	import multipublish.vo.contents.*;
	import multipublish.vo.moduleContents.AskPaper;
	import multipublish.vo.moduleContents.EmergencyBroad;
	import multipublish.vo.moduleContents.Notice;
	
	
	public final class ContentUtil extends NoInstance
	{
		
		/**
		 * 
		 * 获取内容视图。
		 * 
		 */
		
		public static function getContentView($content:Content):*
		{
			if ($content)
			{
				var refer:Class = VIEWS[$content.type];
				if (refer) 
				{
					var content:* = new refer;
				}
			}
			return content;
		}
		
		
		
		
		
		/**
		 * 
		 * 获取内容数据。
		 * 
		 */
		
		public static function getContentVO($content:Object):Content
		{
			if ($content.contentType == "video")
			{
				//swf -> Cartoon 
				switch (FileUtil.getFileTypeByURL($content.contentSource).toLowerCase())
				{
					case FileTypeConsts.MP4:
					case FileTypeConsts.FLV:
						var classRef:Class = VOS[$content.contentType];
						break;
					case "swf":
						classRef = Cartoon;
						break;
					case FileTypeConsts.JPEG:
					case FileTypeConsts.JPG:
					case FileTypeConsts.PNG:
						classRef = Picture;
						break;
				}
			}
			else
			{
				classRef = VOS[$content.contentType];
			}
			
			if (classRef) var content:Content = new classRef($content);    //实例化对应的视图。
			return content;
		}
		
		
		
		public static function getModuleVO($index:int):Class
		{
			return MVOS[$index];
		}
		
		
		public static function getModuleView($index:int, $noticeType:int = 0):Class
		{
			return  $index == 3 ? MVIEWS[$index][$noticeType - 1] : MVIEWS[$index];
		}
		
		/**
		 * 
		 * 模块类型字典。     <br>
		 * 0 -> 其他模块。<br>
		 * 1 -> 民意调查。<br>
		 * 2 -> 应急播报。<br>
		 * 3 -> 公告通知。
		 * 
		 */
		
		private static const MVIEWS:Object = 
		{
			0 : LayoutView,
			1 : AskPaperView,
			2 : EmergencyBroadView,
			3 : [FindPersonView, WelcomeView]
		};
		
		
		private static const MVOS:Object = 
		{
			1 : AskPaper,
			2 : EmergencyBroad,
			3 : Notice
		};
		
		/**
		 * @private
		 */
		private static const VOS:Object = 
		{
			"news" : News,
			"text" : HText,
			"html" : HTMLWeb,
			"clock" : Clock,
			"video" : Record,
			"image" : Picture,
			"flash" : Cartoon,
			"media" : Stream,
			"epaper" : EPaper,
			"button" : Button,
			"weather": Weather,
			"gallary" : Gallary,
			"marquee" : Marquee,
			"qrCode"  : QRCode
		};
		
		/**
		 * @private
		 */
		private static const VIEWS:Object = 
		{
			"news" : NewsView,
			"text" : TextView,
			"html" : HTMLView,
			"clock" : ClockView,
			"video" : RecordView,
			"image" : PictureView,
			"flash" : CartoonView,
			"media" : StreamView,
			"epaper" : EPaperView,
			"button" : ButtonView,
			"weather" : WeatherView,
			"gallary" : GallaryView,
			"marquee" : MarqueeView,
			"qrCode"  : QRCodeView
		};
		
	}
}