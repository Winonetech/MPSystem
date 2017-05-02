package multipublish.commands.steps
{
	
	/**
	 * 
	 * 加载文档数据。
	 * 
	 */
	
	
	import cn.vision.events.QueueEvent;
	import cn.vision.queue.ParallelQueue;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import multipublish.commands.Step;
	import multipublish.consts.ClientStateConsts;
	import multipublish.consts.DataConsts;
	import multipublish.consts.DocumentTypeConsts;
	import multipublish.consts.ElementTypeConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.interfaces.IFolder;
	import multipublish.vo.documents.Document;
	import multipublish.vo.documents.FlashDocument;
	import multipublish.vo.documents.ImageDocument;
	import multipublish.vo.documents.VideoDocument;
	import multipublish.vo.elements.Advertise;
	import multipublish.vo.elements.ArrangeIcon;
	import multipublish.vo.elements.CallBtn;
	import multipublish.vo.elements.Comman;
	import multipublish.vo.elements.Elecmap;
	import multipublish.vo.elements.Element;
	import multipublish.vo.elements.FinanceBtn;
	import multipublish.vo.elements.HoloGrahpic;
	import multipublish.vo.elements.Office;
	import multipublish.vo.elements.Slide;
	import multipublish.vo.elements.Website;
	
	
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
			type[ElementTypeConsts.SLIDE    ] = handlerSlide;
			type[ElementTypeConsts.MAP      ] = handlerMap;
			type[ElementTypeConsts.CALLBTN	] = handlerCall;
			type[ElementTypeConsts.FINANCE  ] = handlerFinance;
			type[ElementTypeConsts.HOLO     ] = handlerHolo;
			
			func = {};
			func[DocumentTypeConsts.IMAGE] = handlerImage;
			func[DocumentTypeConsts.VIDEO] = handlerVideo;
			func[DocumentTypeConsts.FLASH] = handlerFlash;
			
			queue = new ParallelQueue;
			queue.addEventListener(QueueEvent.STEP_END, stepHandler);
			queue.addEventListener(QueueEvent.QUEUE_END, endHandler);
			
			for(var id:String in config.temp)    //此 temp为 temp[bindID] -> icon
			{
				var model:Model = new Model;
				model.url = config.cache 
					? DataConsts.PATH_FOLDER + "-" + id + ".xml"
					: config.source + id;       //此 source为 typeset中的 folderurl。
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
					var name:uint = ObjectUtil.convert($xml["folder"]["type"], uint);
					solv(type[name] ? type[name]($data, $xml) : null, $xml);
				}
			}
		}
		
		
		private function handlerCall($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new CallBtn($data.raw);
		}
		
		
		private function handlerFinance($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new FinanceBtn($data.raw);
		}
		
		private function handlerHolo($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new HoloGrahpic($data.raw);
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
		private function handlerSlide($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			var slide:Slide = new Slide($data.raw);
			slide.reverse = $data.reverse;
			$data.element = slide;
			return $data.element;
		}
		
		/**
		 * @private
		 */
		private function handlerMap($data:ArrangeIcon, $xml:XML):Element
		{
			$data.parse($xml);
			return $data.element = new Elecmap($data.raw);
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
						var name:String = ObjectUtil.convert(item["filetype"], String);
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
			var xml:XML = ObjectUtil.convert(model.data, XML);
			if (xml)
			{
				//验证加载的数据ID与需要加载的ID是否相同，有时从服务端返回的数据会有误。
				if (model.extra.id == ObjectUtil.convert(xml["folder"]["id"]))
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
					LogSQLite.log(
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