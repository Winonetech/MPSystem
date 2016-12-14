package multipublish.components.supportWeather.vo
{
	[Bindable]
	public class WeatherStyle
	{
		public function WeatherStyle(obj:Object)
		{
			if (obj)
			{
				if(obj.iconW&&obj.iconW!="")
					iconW = Number(obj.iconW);
				if(obj.iconH&&obj.iconH!="")
					iconH =Number(obj.iconH);
				if(obj.fontSize&&obj.fontSize!="")
					fontSize = Number(obj.fontSize);
				if(obj.fontFamily&&obj.fontFamily)
					fontFamily = obj.fontFamily;
				if(obj.fontColor&&obj.fontColor!="")
					fontColor = colorString2uint(obj.fontColor);
				if(obj.iconGap!="")
					iconGap = Number(obj.iconGap);
				
				listLayout = new LayoutStyle(obj.listLayout);
				itemLayout = new LayoutStyle(obj.itemLayout);
			}
		}
		public static function colorString2uint($value:String):uint
		{
			if ($value.charAt(0) == "#") 
				$value = "0x" + $value.substr(1);
			return uint($value);
		}
		
		public var iconW:Number = 42;
		public var iconH:Number = 30;
		public var w:Number = 100;
		public var h:Number = 100;
		public var x:Number = 100;
		public var y:Number =100;
		public var fontSize:Number =15;
		public var fontFamily:String = "微软雅黑";
		public var fontColor:uint ;
		public var iconDirPath:String;
		public var iconGap:Number = 5;
		public var iconX:Number;
		public var iconY:Number;
		public var labelX:Number;
		public var labelY:Number;
		
		public var listLayout:LayoutStyle = new LayoutStyle;
		
		public var itemLayout:LayoutStyle = new LayoutStyle;
	}
}