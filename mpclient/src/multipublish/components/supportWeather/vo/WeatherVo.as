package multipublish.components.supportWeather.vo
{
	import multipublish.components.supportWeather.ChineseToPinyin;
	
	[Bindable]
	public class WeatherVo
	{
		public var weather:String;
		public var wind:String;
		public var temperature:String;
		public var date:String;
		public var image:String;
		public function WeatherVo(obj:Object=null,$ctpy:ChineseToPinyin=null,$url:String="")
		{
			if(obj){
				if(obj.temperature&&obj.temperature!="")
					temperature = obj.temperature;
				if(obj.wind&&obj.wind!="")
					wind = obj.wind;
				if(obj.weather&&obj.weather!="")
				{
					weather = obj.weather;
					if(weather=="晴天")
						image = $url+$ctpy.toPinyin("晴")+".png";
					else
						image = $url+$ctpy.toPinyin(weather)+".png";
				}
			}
			
		}
		
	}
}