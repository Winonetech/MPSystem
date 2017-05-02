package multipublish.commands
{
	import cn.vision.utils.StringUtil;
	
	import multipublish.tools.Controller;
	import multipublish.utils.ConfigUtil;
	
	/**
	 * 
	 * 截图命令。
	 * 
	 */
	
	
	public final class ShotcutPlayerCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>ShotcutPlayerCommand</code>构造函数。
		 * 
		 */
		
		public function ShotcutPlayerCommand($cmd:String = "config")
		{
			super();
			
			initialize($cmd);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			shotcutPlayer();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($cmd:String):void
		{
			cmd = $cmd;
		}
		
		/**
		 * @private
		 */
		private function shotcutPlayer():void
		{
			//无参数则不做任何操作。
			if (!StringUtil.empty(cmd))
			{
				if (isNaN(Number(cmd)))
				{
					if (cmd == "config")
					{
						//第一次初始化时进入。
						if (config.shotcut)
						{
							cmd = config.shotcut;
							shotcutSettime();
						}
					}
					else if (cmd != "false" && cmd.indexOf("&") == -1)
					{
						//仅为回调时反馈。
						shotcutCheckDay();
					}
					else
					{
						//仅当传入参数时会进入。
						controller.removeControlAllShotcut();   //清空之前的记录。
						config.shotcutName = {};
						shotcutSettime();
					}
				}
				else 
				{
					time = uint(cmd);   //纯数字参数继续沿用老方法。
					shotcutByGap();
				}
				
			}
		}

		private function shotcutCheckDay():void
		{
			var temp:Array = cmd.split(",");
			var t1:String  = temp[0].replace(/-/g, "/");  //格式化开始时间。
			var t2:String  = temp[1].replace(/-/g, "/"); //格式化结束时间。
			
			var s:Date = new Date(t1);
			var e:Date = new Date(t2);
			e.date ++;
			var d:Date = new Date;
			if (s.time <= d.time && d.time <= e.time) 
			{
				config.shotcuter.start(1, true, 1,  d.time.toString());
			}
			
		}
		
		
		
		private function shotcutSettime():void
		{
			if (cmd != "config")
			{
				config.shotcut = cmd;
				ConfigUtil.saveNativeData();
				ConfigUtil.backupConfig();
			}
			
			if (cmd != "null" && cmd.indexOf("false") < 0)
			{
				//截图策略多加一个日期范围限制。
				var t:Array = cmd.split("&"); //切出日期。
				
				if (t.length == 2)
				{
					var s_eDate:Array = t[1].split(",");    //分离出日期范围。
					cmd = t[0];  //分离出时间策略。
				}
				else return;
				
				//cmd格式：星期 -hh:mm:ss; 星期 -hh:mm:ss; ... ...
				var t1:Array = cmd.split(";");    //分割出每个星期所对应的关机时间。
				for each (var i:String in t1)
				{
					var t2:Array = i.split("-");  //t2[0]为星期数解析。
					var time:String = t2[1];     //t2[1]为时间解析。
					if (time != "null")
					{
						var temp:Date = new Date;
						var t3:Array = time.split(":");   //t3[0]为时，t3[1]为分，t3[2]为秒。
						//2000年 1月表示特定的 日期 =星期 -2。
						var date:Date = new Date(2000, 0, 2 + Number(t2[0]), t3[0], t3[1], t3[2]);
						controller.registControlShotcut(date, presenter.shotcutPlayer, s_eDate);
					}
				}
			}
		}
		
		//需要解析参数。如果纯数字则是每隔多久截一次图。其他格式要求不变。
		private function shotcutByGap():void
		{
			time > 0
				? config.shotcuter.start(time)
				: config.shotcuter.stop();
		}
		
		
		/**
		 * @private
		 */
		private function get controller():Controller
		{
			return config.controller;
		}
		
		private var shotcutName:Object = {};
		
		/**
		 * @private
		 */
		private var cmd:String;
		
		private var time:uint;
	}
}