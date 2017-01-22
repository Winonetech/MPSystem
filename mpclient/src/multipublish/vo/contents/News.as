package multipublish.vo.contents
{
	
	/**
	 * 
	 * 资讯数据结构。
	 * 
	 */
	
	
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.utils.getTimer;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.events.DLStateEvent;
	import multipublish.utils.DicUtil;
	import multipublish.utils.URLUtil;
	
	
	public final class News extends ResolveContent
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function News(
			$data:Object = null, 
			$name:String = "news", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function update(...$args):void
		{
			$args = $args || [];
			ArrayUtil.unshift($args, content);
			loadContent.apply(null, $args);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveContentSource($content:*):void
		{
			loadContent(content + "&terminalId=" + config.terminalNO);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function loadContent($url:String, $useCache:Boolean = false, $method:String = "GET", $args:Object = null):void
		{
			var temp:int = getTimer();
			if (time == 0 || (temp - time > updateFrequency * 1000) || $useCache)
			{
				time = temp;
				super.loadContent($url, $useCache, $method, $args);
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function analyzeContent($data:Object):void
		{
			if ($data)
			{
				list.length = 0;
				
				for each (var item:* in $data.dataObjs)
				{
					delete item.media;
					if (StringUtil.isEmpty(item.urls))
					{
						var media:String = URLUtil.buildFTPURL(item.url);
						wt::registCache(media);
						item.media = CacheUtil.extractURI(media, PathConsts.PATH_FILE);
					}
					else
					{
						var images:Array = item.urls.split(",");
						var l:uint = Math.min(20, images.length);
						LogUtil.log("资讯：" + item.title + "图片总数：" + images.length + "，实际使用：" + l);
						for (var i:int = 0; i < l; i++)
						{
							var url:String = URLUtil.buildFTPURL(images[i]);
							wt::registCache(url);
							DicUtil.push(item, "media", CacheUtil.extractURI(url, PathConsts.PATH_FILE));
						}
					}
					
					//缩略图途径
					var ext:String = FileUtil.getFileTypeByURL(item.url);
					var image:String = item.imageUrl;
					if (StringUtil.isEmpty(image) && 
						ext != FileTypeConsts.MP4 && 
						ext != FileTypeConsts.FLV)
					{
						
						//item.image = (item.media is Array) ? item.media[0] : item.media;
						item.image = CacheUtil.extractURI(item.url, PathConsts.PATH_FILE);
					}
					else
					{
						wt::registCache(image);
						item.image = CacheUtil.extractURI(image, PathConsts.PATH_FILE);
					}
					
					item.noImage = noImage;
					
					ArrayUtil.push(list, item);
				}
			}
			
			resolved = true;
		}
		
		
		/**
		 * 
		 * 新闻列表。
		 * 
		 */
		
		public function get list():Array
		{
			return mp::list;
		}
		
		
		/**
		 * 
		 * 内容路径。
		 * 
		 */
		
		public function get content():String
		{
			return getProperty("contentSource");
		}
		
		
		/**
		 * 
		 * 更新频率（秒）。
		 * 
		 */
		
		public function get updateFrequency():uint
		{
			return getProperty("updateFreq", uint);
		}
		
		
		/**
		 * 
		 * 资讯条数。
		 * 
		 */
		
		public var totalItems:uint;
		
		
		/**
		 * 
		 * 资讯总页数。
		 * 
		 */
		
		public var pageTotal:uint;
		
		
		/**
		 * 
		 * 分页尺寸。
		 * 
		 */
		
		public var pageSize:uint = 10;
		
		
		/**
		 * 
		 * 当前页序号。
		 * 
		 */
		
		public var pageIndex:uint = 0;
		
		
		/**
		 * @private
		 */
		private var time:int;
		
		/**
		 * @private
		 */
		private var config:MPCConfig = MPCConfig.instance;
		
		
		/**
		 * 
		 * 当前页序号。
		 * 
		 */
		
		public var noImage:Boolean;
		
		
		/**
		 * @private
		 */
		mp var list:Array = [];
		
	}
}