package multipublish.commands.steps
{
	
	/**
	 * 
	 * 加载解析构建节目数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.ParallelQueue;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.Step;
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.ContentTypeConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.vo.contents.*;
	import multipublish.vo.programs.Layout;
	import multipublish.vo.programs.Program;
	import multipublish.vo.schedules.Schedule;
	
	
	public class InitializeProgram extends Step
	{
		
		/**
		 * 
		 * <code>InitializeProgram</code>构造函数。
		 * 
		 */
		
		public function InitializeProgram()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_PROG);
			
			load();
		}
		
		
		/**
		 * @private
		 */
		private function load():void
		{
			temp = {};
			
			type = {};
			type[ContentTypeConsts.CARTOON] = Cartoon;
			type[ContentTypeConsts.MARQUEE] = Marquee;
			type[ContentTypeConsts.PICTURE] = Picture;
			type[ContentTypeConsts.TYPESET] = Typeset;
			type[ContentTypeConsts.RECORD ] = Record;
			
			queue = new ParallelQueue;
			queue.addEventListener(QueueEvent.STEP_END, stepHandler);
			queue.addEventListener(QueueEvent.QUEUE_END, endHandler);
			
			for (var id:String in config.temp)
			{
				var model:Model = new Model;
				model.url = config.cache 
					? DataConsts.PATH_PROGRAM + "-" + id + ".xml"
					: config.source + id;
				model.extra.id = id;
				model.extra.index = config.temp[id].index;
				queue.execute(model);
			}
			
			config.source = null;
			if(!queue.executing) endHandler();
		}
		
		/**
		 * 解析并构建节目排版，内容。
		 * @private
		 */
		private function make($xml:XML, $data:*):void
		{
			if ($data is Array)
			{
				for each (var data:Object in $data) make($xml, data);
			}
			else
			{
				var schedule:Schedule = $data.schedule;
				var list:XMLList = $xml["programmes"];
				for each (var item:XML in list)
				{
					var program:Program = store.retrieveData(item.id, Program);
					if(!program)
					{
						program = store.registData(item, Program);
						list = item["layout"];
						for each (item in list)
						{
							var layout:Layout = store.registData(item, Layout);
							program.addLayout(layout);
							list = item["contents"];
							for each (item in list)
							{
								var content:Content = gain(item);
								if (content)
								{
									if (content.type == ContentTypeConsts.TYPESET)
									{
										var typeset:Content = store.retrieveData(content.id, Typeset);
										if (typeset)
											content = typeset;
										else
											store.registData(content);
										var arr:Array = content.content.split("=");
										var ls:uint = arr.length - 1;
										var id:String = arr[ls];
										arr[ls] = "";
										config.source = config.source || arr.join("=");
										temp[id] = content;
									}
									else
									{
										store.registData(content, Content);
									}
									layout.addContent(content);
								}
							}
						}
					}
					schedule.programs[$data.index] = program;
				}
			}
		}
		
		/**
		 * 获取一个对应类型的Content。
		 * @private
		 */
		private function gain($xml:XML):Content
		{
			//根据类型构建不同类型的数据结构
			var refe:Class = type[XMLUtil.convert($xml["fileproterty"])];
			return refe ? new refe($xml) : null;
		}
		
		
		/**
		 * @private
		 */
		private function stepHandler($e:QueueEvent):void
		{
			var model:Model = $e.command as Model;
			var url:String = DataConsts.PATH_PROGRAM + "-" + model.extra.id + ".xml";
			model.extra.tmp = (url != model.url) ? model.url : model.extra.tmp;
			var xml:XML = XMLUtil.convert(model.data, XML);
			if (xml)
			{
				make(xml, config.temp[model.extra.id]);
				if (model.url != url) save(url, xml);
				else flag(url);
			}
			else
			{
				if (model.url!= url)
				{
					model.url = url;
					queue.execute(model);
				}
				else
				{
					LogSQLite.log(
						TypeConsts.FILE,
						EventConsts.EVENT_LOAD_ERROR, model.extra.tmp,
						LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_PROGRAM));
				}
			}
		}
		
		/**
		 * @private
		 */
		private function endHandler($e:QueueEvent = null):void
		{
			queue.removeEventListener(QueueEvent.STEP_END, stepHandler);
			queue.removeEventListener(QueueEvent.QUEUE_END, endHandler);
			queue = null;
			
			config.temp = temp;
			temp = type = null;
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private var queue:ParallelQueue;
		
		/**
		 * @private
		 */
		private var temp:Object;
		
		/**
		 * @private
		 */
		private var type:Object;
		
	}
}