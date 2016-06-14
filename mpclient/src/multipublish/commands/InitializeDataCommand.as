package multipublish.commands
{
	
	/**
	 * 
	 * 初始化数据，步骤如下：<br>
	 * 1.InitializeSchedule，加载，构建排期；<br>
	 * 2.InitializeProgram，加载，构建节目，布局，内容；<br>
	 * 3.InitializeTypeset，加载并构建子排版；<br>
	 * 4.InitializeFolder，加载，构建文件夹。
	 * 
	 */
	
	
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.SequenceQueue;
	import cn.vision.utils.LogUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.steps.*;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.tools.Controller;
	import multipublish.vo.contents.Content;
	import multipublish.vo.contents.Typeset;
	import multipublish.vo.documents.Document;
	import multipublish.vo.elements.Arrange;
	import multipublish.vo.elements.Element;
	import multipublish.vo.programs.Layout;
	import multipublish.vo.programs.Program;
	
	
	public final class InitializeDataCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function InitializeDataCommand($source:String = null)
		{
			super();
			
			initialize($source);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			if (config.importData || 
				config.loadable || 
				config.cache)
				load();
			else
				commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($source:String):void
		{
			config.loadable = Boolean(source = $source);
		}
		
		/**
		 * @private
		 */
		private function load():void
		{
			LogSQLite.log(
				TypeConsts.NETWORK,
				EventConsts.EVENT_UPDATE_SCHEDULE,
				LogUtil.logTip(MPTipConsts.RECORD_DATA_UPDATE));
			
			//清除排期以外的其他数据。
			store.clear();
			//清楚所有已注册的排期时间点。
			controller.removeControlAllBroadcast();
			//清除等待推送使用缓存控制
			controller.removeControlUsecache();
			
			config.source = source;
			
			queue = new SequenceQueue;
			queue.addEventListener(QueueEvent.QUEUE_END, queueEndHandler);
			
			queue.execute(new InitializeSchedule);
			queue.execute(new InitializeProgram);
			queue.execute(new InitializeTypeset);
			queue.execute(new InitializeDocument);
		}
		
		
		/**
		 * @private
		 */
		private function queueEndHandler($e:QueueEvent):void
		{
			queue.removeEventListener(QueueEvent.QUEUE_END, queueEndHandler);
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private function get controller():Controller
		{
			return config.controller;
		}
		
		
		/**
		 * @private
		 */
		private var queue:SequenceQueue;
		
		/**
		 * @private
		 */
		private var source:String;
		
	}
}