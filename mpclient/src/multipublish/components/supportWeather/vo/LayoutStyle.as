package multipublish.components.supportWeather.vo
{
	public class LayoutStyle
	{
		public function LayoutStyle($data:Object = null)
		{
			if ($data)
			{
				layout = validateLayout($data.layout);
				gap = validateGap($data.gap);
				horizontalAlign = validateHorizontalAlign($data.hAlign);
				verticalAlign = validateVerticalAlign($data.vAlign);
				padding = validatePadding($data.padding);
				display = $data.display;
			}
		}
		
		private function validateLayout($value:String):String
		{
			return $value != "horizontal" ? "vertical" : "horizontal";
		}
		
		private function validateGap($value:Number):Number
		{
			return isNaN($value) ? 50 : Math.max(Math.min(500, $value), -500);
		}
		
		private function validateHorizontalAlign($value:String):String
		{
			return ($value == "left" || $value == "right") ? $value : "center";
		}
		
		private function validateVerticalAlign($value:String):String
		{
			return ($value == "top" || $value == "bottom") ? $value : "middle";
		}
		
		private function validatePadding($value:Number):Number
		{
			return isNaN($value) ? 5 : Math.max(Math.min(100, $value), 0);
		}
		
		
		public var layout:String = "vertical";
		
		public var gap:Number = 50;
		
		public var horizontalAlign:String = "center";
		
		public var verticalAlign:String = "middle";
		
		public var padding:Number = 5;
		
		public var display:String;
		
	}
}