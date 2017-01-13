package multipublish.vo.contents
{
	
	/**
	 * 
	 * 图集数据结构。
	 * 
	 */
	
	
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import flash.utils.getTimer;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.utils.URLUtil;
	
	
	public final class Gallary extends ResolveContent
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Gallary($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function update(...$args):void
		{
			loadContent(content + "&terminalId=" + config.terminalNO);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveContentSource($content:*):void
		{
			loadContent(content);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function loadContent($url:String, $useCache:Boolean = false, $method:String = "GET", $args:Object = null):void
		{
			var temp:int = getTimer();
			if (time == 0 || temp - time > updateFrequency * 1000 || $useCache)
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
					if (item && item.url)
					{
						var ext:String = FileUtil.getFileTypeByURL(item.url);
						if (ext == FileTypeConsts.JPG || 
							ext == FileTypeConsts.PNG || 
							ext == FileTypeConsts.JPEG || 
							ext == FileTypeConsts.MP4 || 
							ext == FileTypeConsts.FLV)
						{
							//资源路径，图片或视频
							var source:String = item.url;
							wt::registCache(source);
							item.source = CacheUtil.extractURI(source, PathConsts.PATH_FILE);
							//缩略图途径
							var image:String = item.imageUrl;
							if (StringUtil.isEmpty(image) && 
								ext != FileTypeConsts.MP4 && 
								ext != FileTypeConsts.FLV)
							{
								item.image = item.source;
							}
							else
							{
								wt::registCache(image);
								item.image  = CacheUtil.extractURI(image, PathConsts.PATH_FILE);
							}
							
							//存入数组
							ArrayUtil.push(list, item);
						}
					}
				}
			}
			
//			list.sortOn("order", Array.NUMERIC);
			
			resolved = true;
			
			inited = true;
			
			Cache.start();
			
			if (ready) dispatchEvent(new ControlEvent(ControlEvent.READY));
		}
		
		
		/**
		 * 
		 * 图集列表。
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
		 * 内容路径。
		 * 
		 */
		
		public function get updateFrequency():uint
		{
			return getProperty("updateFreq", uint);
		}
		
		
		/**
		 * @private
		 */
		private var time:int;
		
		/**
		 * @private
		 */
		private var config:MPCConfig = MPCConfig.instance;
		
		
		/**
		 * @private
		 */
		mp var list:Array = [];
		
	}
}