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
	
	
	public final class Gallary extends ResolveContent
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Gallary(
			$data:Object = null, 
			$name:String = "gallary", 
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
			allowed = true;
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
		
		override protected function loadContent($url:String, $repeat:Boolean = false, $method:String = "GET", $args:Object = null):void
		{
			var temp:int = getTimer();
			if (time == 0 || temp - time > updateFrequency * 1000 || $repeat)
			{
				time = temp;
				super.loadContent($url, $repeat, $method, $args);
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
				
				LogUtil.log("----------------------------");
				LogUtil.log("---------- 该图集有 -> " + $data.dataObjs.length + " 个item --------------");
				LogUtil.log("----------------------------");
				
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
							if (StringUtil.empty(image) && 
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
			
			resolved = true;
			
			downloadWhenUpt();
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