package multipublish.vo.contents
{
	
	/**
	 * 
	 * 天气数据结构。
	 * 
	 */
	
	
	import cn.vision.utils.Base64Util;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.events.ControlEvent;
	
	import multipublish.consts.ContentConsts;
	import multipublish.core.mp;
	
	
	public final class Weather extends ResolveContent
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Weather(
			$data:Object = null, 
			$name:String = "weather", 
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
			loadContent(content);
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
		
		override protected function analyzeContent($data:Object):void
		{
			if ($data is String)
			{
				$data = Base64Util.decode($data as String);
			}
			
			mp::weatherData = ($data is String) ? $data : JSON.stringify($data);
			
			try
			{
				JSON.parse(weatherData);
			}
			catch (e:Error)
			{
				LogUtil.log("解析天气出错，尝试使用Base64解密...");
				mp::weatherData = Base64Util.decode(weatherData);
			}
			
			resolved = true;
			
			if (ready) dispatchEvent(new ControlEvent(ControlEvent.READY));
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processResult($success:Boolean, $data:* = null):void
		{
			if ($success)
			{
				try
				{
					var data:Object = $data is String ? JSON.parse($data) : $data;
				}
				catch(o:Error)
				{
					LogUtil.log("天气：解析天气JSON出错，使用Base64解密...");
					data = Base64Util.decode($data as String);
				}
				analyzeContent(data);
			}
			else
			{
				mp::weatherData = ContentConsts.WEATHER_DATA;
				
				resolved = true;
				LogUtil.log(tip.message = "天气：加载天气样式出错，使用默认天气样式。");
				if (ready) dispatchEvent(new ControlEvent(ControlEvent.READY));
			}
			
			dispatchInit();
			
			dispatchReady();
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
		 * 天气数据。
		 * 
		 */
		
		public function get weatherData():String
		{
			return mp::weatherData;
		}
		
		
		/**
		 * @private
		 */
		mp var weatherData:String;
		
	}
}