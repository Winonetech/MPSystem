package multipublish.utils
{
	
	/**
	 * 
	 * 内容工具，用于获取内容视图与数据结构。
	 * 
	 */
	
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.core.NoInstance;
	import cn.vision.utils.FileUtil;
	
	import multipublish.views.CacheView;
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
					//如果是不需要等待的模块，则需要创建一个CacheView壳来包含对应的视图。
					var content:* = (UNWAIT_CONTENTS_VIEW.indexOf(refer) >= 0)
						? getCacheView(refer)
						: new refer;
				}
			}
			return content;
		}
		
		
		/**
		 * 
		 * 获取内容数据。
		 * 
		 */
		
		public static function getContentVO($content:Object, $useWait:Boolean, $cacheGroup:String, $resolveWait:Boolean):Content
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
			
			if (classRef) 
			{
				var content:Content = new classRef($content, "content", 
					(UNWAIT_CONTENTS_VO.indexOf(classRef) >= 0) ? $resolveWait : $useWait, $cacheGroup);
				//实例化对应的视图。
			}
			return content;
		}
		
		
		/**
		 * @private
		 */
		private static function getCacheView(refer:Class):CacheView
		{
			var content:CacheView = new CacheView;
			content.refer = refer;
			return content;
		}
		
		
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
			"stream" : Stream,
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
			"stream" : StreamView,
			"epaper" : EPaperView,
			"button" : ButtonView,
			"weather" : WeatherView,
			"gallary" : GallaryView,
			"marquee" : MarqueeView,
			"qrCode"  : QRCodeView
		};
		
		/**
		 * @private
		 */
		private static const UNWAIT_CONTENTS_VIEW:Array = [NewsView, GallaryView, EPaperView];
		
		/**
		 * @private
		 */
		private static const UNWAIT_CONTENTS_VO:Array = [News, Gallary, EPaper];
		
	}
}