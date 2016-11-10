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
	
	import multipublish.views.CacheView;
	import multipublish.views.contents.*;
	import multipublish.vo.contents.*;
	
	
	public final class ContentUtil extends NoInstance
	{
		
		/**
		 * 
		 * 获取内容视图。
		 * 
		 */
		
		public static function getContentView($content:Content):CacheView
		{
			if ($content)
			{
				var refer:Class = VIEWS[$content.type];
				if (refer) 
				{
					var content:CacheView = new CacheView;
					content.refer = refer;
					content.data  = $content;
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
			
			if (classRef) var content:Content = new classRef($content);
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