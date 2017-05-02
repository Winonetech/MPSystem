package multipublish.components.supportWeather
{
	
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import multipublish.components.WeatherComponent;
	import multipublish.components.supportWeather.vo.*;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.components.Group;
	
	
	public class WeatherWithJson
	{
		private var weatherArr:Array; 
		private var currentCity:String;
		private var weatherStyle:WeatherStyle;
		
		private var timeStyle:TimeStyle;
		private var dataObj:Object;
		private var weatherView:WeatherView;
		private var timeView:TimeView;
		private var singleDayView:SingleDayView;
		private var componentView:WeatherComponent;
		private var imageUrl:String = "assets/weather/style2/";
		private var httpservice:HTTPService;
		private var url:String;
		private var timer:Timer;
		private var errorCount:uint;
		
		
		public function initData(json:String, $componentView:WeatherComponent):void
		{
			componentView = $componentView;
			weatherView = $componentView.weather;
			timeView = $componentView.time;
			
			dataObj = (JSON.parse(json) as Object);
			
			if(!StringUtil.empty(dataObj.style.weather.iconDirPath))
			{
				imageUrl = dataObj.style.weather.iconDirPath;
				imageUrl = imageUrl.replace("\\", "/");
				if(imageUrl.charAt(imageUrl.length-1) != "/")
					imageUrl = imageUrl + "/";
			}
			
			componentView.layoutStyle = new LayoutStyle(dataObj.style.layout);
			
			timeStyle = new TimeStyle(dataObj.style.time);
			timeView.timeStyle = timeStyle;
			
			weatherStyle = new WeatherStyle(dataObj.style.weather);
			
			var cityName:String = urlencodeUtf8(dataObj.weatherData.currentCity);
			var cityCode:String  = CityCode.getCode()[dataObj.weatherData.currentCity];
			if(dataObj.style.loadWeather == "true")
			{
				//				url = "http://apis.baidu.com/apistore" +
				//					"/weatherservice/recentweathers?cityname=" + cityName; http://www.weather.com.cn/data/cityinfo/101010100.html
				url = "http://weather.51wnl.com/weatherinfo/GetMoreWeather?cityCode="+cityCode+"&weatherType=0";
				trace(url);
				getDataByInterface();
			}
			else
			{
				objToView(dataObj.weatherData);
			}
		}
		
		private function createTimer():void
		{
			if(!timer)
			{
				timer = new Timer(60000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
				timer.start();
			}
		}
		
		private function removeTimer():void
		{
			if (timer)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
				timer = null;
			}
		}
		
		private function timerCompleteHandler(e:TimerEvent):void
		{
			getDataByInterface();
		}
		
		//链接天气接口得到数据
		private function getDataByInterface():void
		{
			httpservice = new HTTPService;
			httpservice.url = url;
			httpservice.method = "GET";
			
			httpservice.addEventListener(ResultEvent.RESULT, http_defaultHandler);
			httpservice.addEventListener(FaultEvent.FAULT,faultHandler);
			httpservice.send(); 
			
		}
	
		private function faultHandler(e:Event):void 
		{ 
			//CuPlayer.com提示：处理失败 
		} 
		
		private function http_defaultHandler(e:ResultEvent):void
		{
			httpservice.removeEventListener(ResultEvent.RESULT, http_defaultHandler);
			httpservice.removeEventListener(FaultEvent.FAULT, http_defaultHandler);
			trace("------",e.result);
			if (e.type == ResultEvent.RESULT)
			{
				trace((e as ResultEvent).result.toString());
				var temp:Object = JSON.parse((e as ResultEvent).result.toString());
				if (temp.weatherinfo)
				{
					//将网上api得到的json组装成规定的json
					var weaObj:Object = new Object;
					//今天的天气
					var todayWeather:WeatherVo = new WeatherVo;
					todayWeather.weather = temp.weatherinfo.weather1;
					todayWeather.wind =temp.weatherinfo.wind1;
					todayWeather.temperature = temp.weatherinfo.temp1;
					weaObj.today = todayWeather;
					//多天天气
					var weathArr:Array = new Array;
					for(var i:int=1;i<5;i++){
						var wea:WeatherVo = new WeatherVo;
						var weather:String = "weather"+i;
						var wind:String = "wind"+i;
						var temperature:String = "temp"+i;
						
						wea.weather = temp.weatherinfo[weather];
						wea.wind =temp.weatherinfo[wind];
						wea.temperature = temp.weatherinfo[temperature];
						
						weathArr.push(wea);
					}
					weaObj.forecast = weatherArr;
					var complete:Boolean = true;
					dataObj.weatherData = weaObj;
					objToView(dataObj.weatherData);
				}
			}
			if(!complete)
			{
				if(++errorCount < 2)
				{
					getDataByInterface();
				}
				else
				{
					errorCount = 0;
					createTimer();
				}
			}
		}
		
		private function send_error(e:Event):void
		{
			trace("数据接收失败");
		}
		
		private function objToView(obj:Object):void
		{
			
			weatherArr = new Array;
			var chineseToPinyin:ChineseToPinyin = new ChineseToPinyin;
			if(obj.today)
			{
				var today:WeatherVo = new WeatherVo(obj.today,chineseToPinyin,imageUrl);
				weatherArr.push(today);
			}
			if(obj.forecast)
			{
				for(var i:int=0;i<obj.forecast.length;i++)
				{
					var weather:WeatherVo = new WeatherVo(obj.forecast[i],chineseToPinyin,imageUrl);
					weatherArr.push(weather);
				}
			}
			
			weatherView.weatherStyle = weatherStyle;
			weatherView.removeAllElements();
			
			for each (var item:* in weatherArr)
			{
				weatherView.addWeatherItem(item);
				if (ObjectUtil.convert(dataObj.style.singleDay, Boolean)) break;
			}
			
		}
		private function urlencodeUtf8(str:String):String
		{
			var result:String ="";
			var byte:ByteArray = new ByteArray;
			//如果需要转换成其他的类型，如gbk，big5直接把gb2312改成gbk或者big5就行了
			byte.writeMultiByte(str, "utf-8");
			var l:uint = byte.length;
			for(var i:int; i < l; i++) result += escape(String.fromCharCode(byte[i]));
			return result;
		}
		
	}
	
}