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
		public function WeatherVo(obj:Object,$ctpy:ChineseToPinyin,$url:String)
		{
			if(obj.week&&obj.week!="")
				date = obj.week;
			if(obj.lowtemp&&obj.lowtemp!=""&&obj.hightemp&&obj.hightemp!="")
				temperature = obj.lowtemp+"~"+obj.hightemp;
			if(obj.fengli&&obj.fengli!="")
				wind = obj.fengli;
			if(obj.type&&obj.type!="")
			{
				weather = obj.type;
				image = $url+$ctpy.toPinyin(weather)+".png";
			}
			
			
		}
	}
}