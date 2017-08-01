package multipublish.tools
{
	
	/**
	 * 
	 * 统计工具。
	 * 
	 */
	
	
	import cn.vision.core.Command;
	import cn.vision.queue.SequenceQueue;
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.RegexpUtil;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	
	import multipublish.core.MDProvider;
	import multipublish.core.MPCView;
	import multipublish.skins.MPPanelSkin;
	import multipublish.vo.Channel;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class Statistics extends Command
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Statistics($type:String, $args:Array)
		{
			super();
			
			type = $type;
			$args.forEach(forEach);
			args = $args;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			open();
			
			commandEnd();
		}
		
		/**
		 * @private
		 */
		private function create():void
		{
			stm.text = CREATE_TERMINAL;
			stm.execute();
			
			stm.text = CREATE_RESOURCE;
			stm.execute();
			
			stm.text = CREATE_BUTTON;
			stm.execute();
			
			stm.text = CREATE_EPAPER;
			stm.execute();
			
			stm.text = CREATE_NEWS;
			stm.execute();
		}
		
		/**
		 * @private
		 */
		private function open():void
		{
			if(!con.connected)
			{
				var url:String = FileUtil.resolvePathApplication("statistics");
				//如果文件夹不存在，先创建文件夹，否则调用SQL出错。
				var dir:VSFile = new VSFile(url);
				if(!dir.exists) dir.createDirectory();
				var name:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD") + ".sqlite";
				url += "/" + name;
				file = file || new VSFile(url);
				
				var exist:Boolean = file.exists;
				
				con.open(file);
				
				stm.sqlConnection = con;
				
				if(!exist)
				{
					create();
				}
				
			}
			
			insert();
		}
		
		/**
		 * @private
		 */
		private function insert():void
		{
			if (con.connected && stm.sqlConnection)
			{
				switch (type)
				{
					case "terminal":
						stm.text = RegexpUtil.replaceTag(INSERT_TERMINAL, args);
						stm.execute();
						break;
					case "resource":
						stm.text = RegexpUtil.replaceTag(INSERT_RESOURCE, args);
						stm.execute();
						break;
					case "button":
						stm.text = RegexpUtil.replaceTag(INSERT_BUTTON, args);
						stm.execute();
						break;
					case "epaper":
						stm.text = RegexpUtil.replaceTag(INSERT_EPAPER, args);
						stm.execute();
						break;
					case "news":
						stm.text = RegexpUtil.replaceTag(INSERT_NEWS, args);
						stm.execute();
						break;
					default:
						break;
				}
			}
		}
		
		
		/**
		 * 
		 * 统计素材。
		 * 
		 */
		
		public static function censusTerminal($id:uint, $event:String):void
		{
			var time:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD HH:MI:SS");
			queue.execute(new Statistics("terminal", [$id, $event, time]));
		}
		
		
		
		/**
		 * 
		 * 统计素材。
		 * 
		 */
		
		public static function censusResource($id:uint, $type:uint, $path:String, $playTime:uint):void
		{
			var date:Date = new Date;
			date.seconds -= $playTime;
			var time:String = ObjectUtil.convert(date, String, "YYYY-MM-DD HH:MI:SS");
			queue.execute(new Statistics("resource", [getChannelID(), $id, $type, $path, time, $playTime]));
		}
		
		
		/**
		 * 
		 * 统计按钮。
		 * 
		 */
		
		public static function censusButton($id:uint):void
		{
			var time:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD HH:MI:SS");
			queue.execute(new Statistics("button", [getChannelID(), $id, time]));
		}
		
		
		/**
		 * 
		 * 统计电子报。
		 * 
		 */
		
		public static function censusEpaper($path:String, $day:String):void
		{
			var time:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD HH:MI:SS");
			queue.execute(new Statistics("epaper", [getChannelID(), $path, $day, time]));
		}
		
		
		/**
		 * 
		 * 统计资讯，图集。
		 * 
		 */
		
		public static function censusNews($id:uint):void
		{
			var time:String = ObjectUtil.convert(new Date, String, "YYYY-MM-DD HH:MI:SS");
			queue.execute(new Statistics("news", [getChannelID(), $id, time]));
		}
		
		
		/**
		 * @private
		 */
		private static function forEach($item:*, $index:int, $array:Array):void
		{
			if ($item is String) 
				$array[$index] = "'" + $item + "'";
		}
		
		/**
		 * @private
		 */
		private static function getChannelID():uint
		{
			var s:Schedule = MPCView.instance.main.data as Schedule;
			return uint(s ? s.id : "0");
		}
		
		
		/**
		 * @private
		 */
		private var type:String;
		
		/**
		 * @private
		 */
		private var args:Array;
		
		
		/**
		 * @private
		 */
		private static var file:VSFile;
		
		/**
		 * @private
		 */
		private static var con:SQLConnection = new SQLConnection;
		
		/**
		 * @private
		 */
		private static var stm:SQLStatement = new SQLStatement;
		
		/**
		 * @private
		 */
		private static var queue:SequenceQueue = new SequenceQueue;
		
		
		/**
		 * @private
		 */
		private static const CREATE_TERMINAL:String = 
			"CREATE TABLE IF NOT EXISTS TERMINAL_STATISTICS (" +
				"TERMINAL_ID INTEGER," +
				"TERMINAL_EVENT VARCHAR," +
				"TERMINAL_OCCURTIME VARCHAR" +
			")";
		
		/**
		 * @private
		 */
		private static const CREATE_RESOURCE:String = 
			"CREATE TABLE IF NOT EXISTS RESOURCE_STATISTICS (" +
				"CHANNEL_ID INTEGER," +
				"RESOURCE_ID INTEGER," +
				"RESOURCE_TYPE INTEGER," +
				"RESOURCE_PATH VARCHAR," +
				"RESOURCE_STARTTIME VARCHAR," +
				"RESOURCE_PLAYTIME INTEGER" +
			")";
		
		/**
		 * @private
		 */
		private static const CREATE_BUTTON:String = 
			"CREATE TABLE IF NOT EXISTS BUTTON_STATISTICS (" +
				"CHANNEL_ID INTEGER," +
				"BUTTON_ID INTEGER," +
				"BUTTON_CLICKTIME VARCHAR" +
			")";
		
		/**
		 * @private
		 */
		private static const CREATE_EPAPER:String = 
			"CREATE TABLE IF NOT EXISTS EPAPER_STATISTICS (" +
				"CHANNEL_ID INTEGER," +
				"EPAPER_SOURCEPATH VARCHAR," +
				"EPAPER_DAY VARCHAR," +
				"EPAPER_CLICKTIME VARCHAR" +
			")";
		
		/**
		 * @private
		 */
		private static const CREATE_NEWS:String = 
			"CREATE TABLE IF NOT EXISTS NEWS_STATISTICS (" +
				"CHANNEL_ID INTEGER," +
				"NEWS_ID INTEGER," +
				"NEWS_CLICKTIME VARCHAR" +
			")";
		
		/**
		 * @private
		 */
		private static const INSERT_TERMINAL:String = "INSERT INTO TERMINAL_STATISTICS (" +
				"TERMINAL_ID," +
				"TERMINAL_EVENT," +
				"TERMINAL_OCCURTIME" +
			") VALUES ({$self})";
		
		/**
		 * @private
		 */
		private static const INSERT_RESOURCE:String = "INSERT INTO RESOURCE_STATISTICS (" +
				"CHANNEL_ID," +
				"RESOURCE_ID," +
				"RESOURCE_TYPE," +
				"RESOURCE_PATH," +
				"RESOURCE_STARTTIME," +
				"RESOURCE_PLAYTIME" +
			") VALUES ({$self})";
		
		/**
		 * @private
		 */
		private static const INSERT_BUTTON:String = "INSERT INTO BUTTON_STATISTICS (" +
				"CHANNEL_ID," +
				"BUTTON_ID," +
				"BUTTON_CLICKTIME" +
			") VALUES ({$self})";
		
		/**
		 * @private
		 */
		private static const INSERT_EPAPER:String = "INSERT INTO EPAPER_STATISTICS (" +
				"CHANNEL_ID," +
				"EPAPER_SOURCEPATH," +
				"EPAPER_DAY," +
				"EPAPER_CLICKTIME" +
			") VALUES ({$self})";
		
		/**
		 * @private
		 */
		private static const INSERT_NEWS:String = "INSERT INTO NEWS_STATISTICS (" +
				"CHANNEL_ID," +
				"NEWS_ID," +
				"NEWS_CLICKTIME" +
			") VALUES ({$self})";
		
	}
}