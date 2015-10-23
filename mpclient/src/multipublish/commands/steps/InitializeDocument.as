package multipublish.commands.steps
{
	
	/**
	 * 
	 * 加载文档数据。
	 * 
	 */
	
	
	import cn.vision.events.pattern.QueueEvent;
	import cn.vision.pattern.queue.ParallelQueue;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.tools.LogSaver;
	
	import multipublish.commands.Step;
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.DocumentTypeConsts;
	import multipublish.consts.ElementTypeConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.interfaces.IFolder;
	import multipublish.vo.documents.*;
	import multipublish.vo.elements.*;
	
	
	public final class InitializeDocument extends Step
	{
		
		/**
		 * 
		 * <code>InitializeDocument</code>构造函数。
		 * 
		 */
		
		public function InitializeDocument()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			modelog(ClientStateConsts.INIT_DOCU);
			
			load();
		}
		
		
		/**
		 * @private
		 */
		private function load():void
		{
			type = {};
			type[ElementTypeConsts.ADVERTISE] = handlerAdvertise;
			type[ElementTypeConsts.GENERAL  ] = handlerComman;
			type[ElementTypeConsts.WEBSITE  ] = handlerWebsite;
			type[ElementTypeConsts.OFFICE   ] = handlerOffice;
			
			func = {};
			func[DocumentTypeConsts.IMAGE] = handlerImage;
			func[DocumentTypeConsts.VIDEO] = handlerVideo;
			func[DocumentTypeConsts.FLASH] = handlerFlash;
			
			queue = new ParallelQueue;
			queue.addEventListener(QueueEvent.STEP_END, stepHandler);
			queue.addEventListener(QueueEvent.QUEUE_END, endHandler);
			
			for(var id:String in config.temp)
			{
				var model:Model = new Model;
				model.url = config.cache 
					? DataConsts.PATH_FOLDER + "-" + id + ".xml"
					: config.source + id;
				model.extra.id = id;
				queue.execute(model);
			}
			if(!queue.executing) endHandler();
		}
		
		/**
		 * @private
		 */
		private function make($xml:XML, $data:*):void
		{
			if ($data is Array)
			{
				for each (var folder:* in $data) make($xml, folder);
			}
			else
			{
				if ($data)
				{
					var name:uint = XMLUtil.convert($xml["folder"]["type"], uint);
					solv(type[name] ? type[name]($data, $xml) : null, $xml);
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerAdvertise($data:*, $xml:XML):Element
		{
			if ($data is Advertise)
			{
				var result:Advertise = $data;
			}
			else
			{
				$data.parse($xml);
				$data.element = result = new Advertise($data.raw);
				result.time = $data.time;
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private function handlerComman($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new Comman($data.raw);
		}
		
		/**
		 * @private
		 */
		private function handlerOffice($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new Office($data.raw);
		}
		
		/**
		 * @private
		 */
		private function handlerWebsite($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new Website($data.raw);
		}
		
		
		/**
		 * @private
		 */
		private function solv($element:Element, $xml:XML):void
		{
			if ($element)
			{
				$element.parse($xml);
				
				if ($element is IFolder)
				{
					var folder:IFolder = $element as IFolder;
					for each (var item:XML in $xml["folder"]["item"])
					{
						var name:String = XMLUtil.convert(item["filetype"], String);
						if (func[name]) folder.addDocument(func[name](item));
					}
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerImage($data:XML):ImageDocument
		{
			return store.registData(new ImageDocument($data), Document);
		}
		
		/**
		 * @private
		 */
		private function handlerVideo($data:XML):VideoDocument
		{
			return store.registData(new VideoDocument($data), Document);
		}
		
		/**
		 * @private
		 */
		private function handlerFlash($data:XML):FlashDocument
		{
			return store.registData(new FlashDocument($data), Document);
		}
		
		
		/**
		 * @private
		 */
		private function stepHandler($e:QueueEvent):void
		{
			var model:Model = $e.command as Model;
			var url:String = DataConsts.PATH_FOLDER + "-" + model.extra.id + ".xml";
			var xml:XML = XMLUtil.convert(model.data, XML);
			if (xml)
			{
				//验证加载的数据ID与需要加载的ID是否相同，有时从服务端返回的数据会有误。
				if (model.extra.id == XMLUtil.convert(xml["folder"]["id"]))
				{
					make(xml, config.temp[model.extra.id]);
					model.url != url ? save(url, xml) : flag(url);
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
					LogSaver.log(
						TypeConsts.FILE,
						EventConsts.EVENT_LOAD_ERROR,
						LogUtil.logTip(MPTipConsts.RECORD_LOAD_FAILURE_DOCUMENT, model.extra));
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
			func = queue  = null;
			config.source = null;
			
			commandEnd();
		}
		
		
		/**
		 * @private
		 */
		private var queue:ParallelQueue;
		
		/**
		 * @private
		 */
		private var func:Object;
		
		/**
		 * @private
		 */
		private var type:Object;
		
	}
}