package multipublish.commands.steps
{
	
	/**
	 * 
	 * 加载排版数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.ParallelQueue;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.Step;
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.ElementTypeConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.vo.contents.Typeset;
	import multipublish.vo.elements.*;
	
	
	public final class InitializeTypeset extends Step
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function InitializeTypeset()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_TPST);
			
			load();
		}
		
		
		/**
		 * @private
		 */
		private function load():void
		{
			//根据文件夹ID存储需要加载的文件夹数据
			temp = {};
			//根据排版ID存储需要加载的排版数据
			dict = {};
			
			queue = new ParallelQueue;
			queue.addEventListener(QueueEvent.STEP_END, stepHandler);
			queue.addEventListener(QueueEvent.QUEUE_END, endHandler);
			
			for(var id:String in config.temp)       //此temp为 temp[typesetID] -> typeset。
			{
				var model:Model = new Model;
				model.url = config.cache 
					? DataConsts.PATH_TYPESET + "-" + id + ".xml"
					: config.source + id;        //此 source为 program中 typeset中 getContents中去除了 id的字符串。
				model.extra.id = id;
				queue.execute(model);
			}
			if(!queue.executing) endHandler();
		}
		
		/**
		 * @private
		 */
		private function make($xml:XML, $data:* = null):void
		{
			source = source || XMLUtil.convert($xml["folderurl"]);
			if ($data is Array)
			{
				for each (var icon:ArrangeIcon in $data) make($xml, icon);
			}
			else
			{
				if ($data is Typeset)
				{
					var arrange:Arrange = $data.arrange = store.registData($xml, Arrange);
					arrange.level = 1;
					handlerAdvertise($xml.descendants("ad")[0], arrange);
					solv($xml, arrange);
				}
				else
				{
					icon = $data;
					icon.parse($xml);
					arrange = store.retrieveData(icon.id, Arrange);
					if(!arrange)
					{
						solv($xml, (icon.element = store.registData($xml, Arrange)) as Arrange);
					}
					else
					{
						icon.element = arrange;
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		private function solv($xml:XML, $arrange:Arrange):void
		{
			if(!solved[$arrange.id])
			{
				solved[$arrange.id] = true;
				var list:XMLList = $xml.descendants("item");
				for each (var item:XML in list)
				{
					var type:uint = XMLUtil.convert(item["bindtype"], uint);
					type == ElementTypeConsts.ARRANGE
						? handlerArrange(item, $arrange)
						: handlerFolder (item, $arrange);
				}
			}
		}
		
		/**
		 * @private
		 */
		private function seta():void
		{
			var arrs:* = store.retrieveMap(Arrange);
			
			for each (var item:* in dict)
			{
				if (item is Array)
				{
					for each (var icon:ArrangeIcon in item)
						icon.element = arrs[icon.bindID];
				}
				else
				{
					icon = item;
					icon.element = arrs[icon.bindID]
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerArrange($xml:XML, $parent:Arrange):void
		{
			var id:String = XMLUtil.convert($xml["bindid"]);
			if (uint(id) > 0)
			{
				var icon:ArrangeIcon = new ArrangeIcon($xml);
				$parent.addElement(icon);
				
				var arrange:Arrange = store.retrieveData(id, Arrange);
				if (arrange) 
				{
					icon.parse(arrange.raw);
					icon.element = arrange;
				}
				else
				{
					push(dict, icon.bindID, icon);
					if(!loadeds[id])
					{
						loadeds[id] = true;
						//子排版类型。
						var model:Model = new Model;
						model.extra.id = id;
						model.extra.sub = true;
						model.url = config.cache 
							? DataConsts.PATH_TYPESET + "-" + id + ".xml"
							: config.source + id;
						queue.execute(model);
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		private function handlerFolder($xml:XML, $parent:Arrange):void
		{
			var id:String = XMLUtil.convert($xml["bindid"]);
			if (uint(id) > 0)
			{
				var icon:ArrangeIcon = new ArrangeIcon($xml);
				$parent.addElement(icon);
				push(temp, icon.bindID, icon);
			}
		}
		
		/**
		 * @private
		 */
		private function handlerAdvertise($xml:XML, $parent:Arrange):void
		{
			var id:String = XMLUtil.convert($xml["bindid"]);
			var enabled:Boolean = XMLUtil.convert($xml["adenable"], Boolean);
			if (enabled && uint(id) > 0)
			{
				var advertise:Advertise = new Advertise($xml);
				$parent.advertise = advertise;
				advertise.parent = $parent;
				push(temp, advertise.id, advertise);
			}
		}
		
		
		/**
		 * @private
		 */
		private function stepHandler($e:QueueEvent):void
		{
			var model:Model = $e.command as Model;
			var url:String = DataConsts.PATH_TYPESET + "-" + model.extra.id + ".xml";
			model.extra.tmp = (url != model.url) ? model.url : model.extra.tmp;
			var xml:XML = XMLUtil.convert(model.data, XML);
			if (xml)
			{
				//验证加载的数据ID与需要加载的ID是否相同，有时从服务端返回的数据会有误。
				if (model.extra.id == XMLUtil.convert(xml["layout"]["id"]))
				{
					make(xml, model.extra.sub ? dict[model.extra.id] : config.temp[model.extra.id]);
					if (model.url != url) save(url, xml);
					else flag(url);
				}
				else
				{
					queue.execute(model);
				}
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
						LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_TYPESET));
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
			
			seta();
			
			config.temp = temp;
			config.source = source;
			
			var arrs:* = store.retrieveMap(Arrange);
			
			dict = temp = source = null;
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private var loadeds:Object = {};
		
		/**
		 * @private
		 */
		private var solved:Object = {};
		
		/**
		 * @private
		 */
		private var temp:Object;
		
		/**
		 * @private
		 */
		private var dict:Object;
		
		/**
		 * @private
		 */
		private var queue:ParallelQueue;
		
		/**
		 * 临时存储Element加载路径。
		 * @private
		 */
		private var source:String;
		
	}
}