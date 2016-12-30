package multipublish.consts
{
	public final class ContentConsts
	{
		
		
		
		/**
		 * 
		 * 下载状态视频。竖屏
		 * 
		 */
		
		public static const WELCOME_VIDEO:String = "assets/video/helena.mp4"; 
		
		
		/**
		 * 
		 * 图片内容默认时长
		 * 
		 */
		
		public static const CONTENT_TIME_DEFAUALT:uint = 15;
		
		
		/**
		 * 
		 * 插播内容默认时长
		 * 
		 */
		
		public static const MODULE_TIME_DEFAUALT:uint = 60;
		
		
		
		/**
		 * 
		 * 天气默认数据
		 * 
		 */
		
		public static const WEATHER_DATA:String = 
			"{" + 
			"\"style\": {" + 
			"\"loadWeather\": \"true\"," + 
			"\"singleDay\": \"true\"," + 
			"\"layout\": {" + 
			"\"layout\" : \"horizontal\"," + 
			"\"gap\" : 50," + 
			"\"vAlign\" : \"center\"," + 
			"\"padding\" : 5," + 
			"\"display\": \"time, weather\"" + 
			"}," + 
			"\"weather\": {" + 
			"\"coordX\": \"250\"," + 
			"\"coordY\": \"5\"," + 
			"\"iconW\": \"100\"," + 
			"\"iconH\": \"100\"," + 
			"\"fontFamily\": \"微软雅黑\"," + 
			"\"fontSize\": \"20\"," + 
			"\"fontColor\": \"#FFFFFF\"," + 
			"\"iconDirPath\": \"\"," + 
			"\"listLayout\" : {" + 
			"\"layout\" : \"horizontal\"," + 
			"\"gap\" : 10" + 
			"}," + 
			"\"itemLayout\" : {" + 
			"\"layout\" : \"vertical\"," + 
			"\"gap\" : 10," + 
			"\"display\": \"icon,desc\"" + 
			"}" + 
			"}," + 
			"\"time\": {" + 
			"\"format\": \"YYYY年MM月DD日|HH:MI\"," + 
			"\"fontFamily\": \"微软雅黑\"," + 
			"\"timeColor\": \"#FFFFFF\"," + 
			"\"timeSize\": \"50\"," + 
			"\"dateColor\": \"#FFFFFF\"," + 
			"\"dateSize\": \"20\"," + 
			"\"layout\":{" + 
			"\"layout\" : \"vertical\"," + 
			"\"gap\": 20," + 
			"\"display\": \"time, date\"" + 
			"}" + 
			"}" + 
			"}," + 
			"\"weatherData\": {" + 
			"\"currentCity\": \"长沙\"" + 
			"}" + 
			"}";	
	}
}