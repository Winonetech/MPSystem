package multipublish.components.supportWeather.vo
{
	import cn.vision.utils.StringUtil;

	[Bindable]
	public class TimeStyle
	{
		public function TimeStyle(obj:Object )
		{
			if (obj)
			{
				if(obj.style!="")
					format = obj.format;
				
				visible = true;
				
				if(!StringUtil.isEmpty(obj.timeSize))
					timeSize = Number(obj.timeSize);
				if(!StringUtil.isEmpty(obj.dateSize))
					dateSize = Number(obj.dateSize);
				if(!StringUtil.isEmpty(obj.timeColor))
					timeColor = colorString2uint(obj.timeColor);
				if(!StringUtil.isEmpty(obj.dateColor))
					dateColor = colorString2uint(obj.dateColor);
				if(!StringUtil.isEmpty(obj.fontFamily))
					fontFamily = obj.fontFamily;
			}
			
			layout = new LayoutStyle(obj.layout);
		}
		/**
		 * 
		 * 转换颜色字符串为uint。
		 * 
		 * @param $value:String
		 * 
		 * @return uint
		 * 
		 */
		
		public static function colorString2uint($value:String):uint
		{
			if ($value.charAt(0) == "#") 
				$value = "0x" + $value.substr(1);
			return uint($value);
		}


		public var format:String;
		public var visible:Boolean = true;
		public var x:Number;
		public var y:Number;
		public var w:Number=100;
		public var h:Number=100;
		
		public var fontFamily:String;
		public var timeColor:uint;
		public var dateColor:uint;
		public var timeX:Number = 0;
		public var timeY:Number = 0;
		public var dateX:Number = 0;
		public var dateY:Number = 50;
		public var timeSize:Number = 40;
		public var dateSize:Number =20;
		
		public var layout:LayoutStyle = new LayoutStyle;
		
	}
}