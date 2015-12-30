package multipublish.commands
{
	
	/**
	 * 
	 * 时间同步。
	 * 
	 */
	
	
	import cn.vision.net.FileSaver;
	import cn.vision.utils.ApplicationUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.Cache;
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.Event;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.consts.URLConsts;
	
	
	public final class LockTimeCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * <code>LockTimeCommand</code>构造函数。
		 * 
		 */
		
		public function LockTimeCommand($message:String)
		{
			super();
			
			initialize($message);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			locktime();
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($message:String):void
		{
			message = $message;
		}
		
		/**
		 * @private
		 */
		private function locktime():void
		{
			var temp:Array = message.split(" ");
			var date:String = "date " + temp[0];
			var time:String = "time " + temp[1];
			var exit:String = "del %0";
			var cmd:String = date + StringUtil.lineEnding + time + StringUtil.lineEnding + exit;
			
			LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_SYNC_SERVER_TIME,
				LogUtil.log(MPTipConsts.RECORD_COMMAND_LOCKTIME));
			
			var saver:FileSaver = Cache.save(URLConsts.TOOL_TIME, cmd);
			saver.addEventListener(Event.COMPLETE, handlerSaveComplete);
		}
		
		
		/**
		 * @private
		 */
		private function handlerSaveComplete($e:Event):void
		{
			var saver:FileSaver = FileSaver($e.currentTarget);
			saver.removeEventListener(Event.COMPLETE, handlerSaveComplete);
			saver.close();
			ApplicationUtil.execute(
				FileUtil.resolvePathApplication(URLConsts.TOOL_SYNC), 
				FileUtil.resolvePathApplication(URLConsts.TOOL_TIME));
		}
		
		
		/**
		 * @private
		 */
		
		private var message:String;
		
	}
}