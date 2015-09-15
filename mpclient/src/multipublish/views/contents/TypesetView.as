package multipublish.views.contents
{
	
	/**
	 * 
	 * 排版内容。
	 * 
	 */
	
	
	import com.winonetech.controls.Zoomer;
	import com.winonetech.core.VO;
	import com.winonetech.tools.LogSaver;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import input.Input;
	
	import multipublish.consts.ElementTypeConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.views.CacheView;
	import multipublish.views.elements.*;
	import multipublish.vo.contents.Typeset;
	import multipublish.vo.elements.*;
	
	import spark.components.Group;
	import spark.effects.Fade;
	
	
	public final class TypesetView extends ContentView
	{
		
		/**
		 * 
		 * <code>TypesetView</code>构造函数。
		 * 
		 */
		
		public function TypesetView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * 
		 * 返回上一级。
		 * 
		 * @param $level
		 * 
		 */
		
		public function back($level:uint = 1):void
		{
			if(!zoomer.playing)
			{
				var index:int = history.length - $level;
				if (0 <= index && index < history.length)
				{
					last = history[index];
					history.length = index;
					
					log(MPTipConsts.RECORD_TYPESET_BACK, last.data);
					
					if (last)
					{
						var temp:CacheView = main;
						main = last;
						last = temp;
						zoomer.play(last, main, null, true);
					}
				}
			}
		}
		
		
		/**
		 * 
		 * 返回首页。
		 * 
		 */
		
		public function home():void
		{
			log(MPTipConsts.RECORD_TYPESET_HOME, typeset.arrange);
			last = (history.length) ? history[0] : null;
			if (last && main)
			{
				history.length = 0;
				main.stop(false);
				var temp:CacheView = main;
				main = last;
				last = temp;
				zoomer.play(last, main, null, true);
			}
		}
		
		
		/**
		 * 
		 * 进入子页面。
		 * 
		 */
		
		public function view($data:ArrangeIcon, $rect:Rectangle = null):void
		{
			var index:int = indexOfHistory($data);
			if (index == -1)
			{
				if(!zoomer.playing)
				{
					log(MPTipConsts.RECORD_TYPESET_VIEW, $data.element);
					
					if (elements[$data.vid])
					{
						last = main;
						main = elements[$data.vid];
						delete elements[$data.vid];
						history.push(last);
						zoomer.play(last, main, $rect);
					}
				}
			}
			else
			{
				if (index == 0)
					home();
				else
					back(history.length - index);
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			main && main.play();
			timer && timer.start();
			addEventListener(MouseEvent.MOUSE_DOWN, handlerMouseDown, true);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			zoomer.stop();
			main && main.stop(false);
			advertise && advertise.stop(false);
			timer && timer.stop();
			removeEventListener(MouseEvent.MOUSE_DOWN, handlerMouseDown, true);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			elements = null;
			typeset = null;
			history.length = 0;
			if (timer)
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
				timer = null;
			}
			if (advertise && containsElement(advertise))
			{
				removeElement(advertise);
				advertise = null;
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			typeset = data as Typeset;
			if (typeset.arrange)
			{
				log(MPTipConsts.RECORD_TYPESET_DATA, typeset.arrange);
				
				prepareElements(typeset.arrange);
				container.addElement(main = new CacheView);
				main.refer  = ArrangeView;
				main.width  = width;
				main.height = height;
				main.data   = typeset.arrange;
				if (typeset.arrange.advertise)
				{
					var ad:Advertise = typeset.arrange.advertise;
					if (ad.wait > 0)
					{
						addElement(advertise = new CacheView).visible = false;
						advertise.refer = AdvertiseView;
						advertise.width = width;
						advertise.height = height;
						advertise.data = ad;
						
						advertise.setStyle("showEffect", fadeIn);
						advertise.setStyle("hideEffect", fadeOut);
						
						if(!timer)
						{
							timer = new Timer(1000, ad.wait);
							timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
						}
					}
				}
			}
			
			playing && processPlay();
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			fadeIn = new Fade;
			fadeOut = new Fade;
			fadeIn.alphaFrom = fadeOut.alphaTo = 0;
			fadeIn.alphaTo = fadeOut.alphaFrom = 1;
			fadeIn.duration = fadeOut.duration = 500;
			history = new Vector.<CacheView>;
			addElement(container = new Group);
			container.percentWidth  = 100;
			container.percentHeight = 100;
			addElement(zoomer = new Zoomer);
			zoomer.percentWidth  = 100;
			zoomer.percentHeight = 100;
			zoomer.time          =(config.zoomTweenTime || 1);
			zoomer.onPlay        = callbackTweenPlay;
			zoomer.onStop        = callbackTweenStop;
			
			type = {};
			type[ElementTypeConsts.ADVERTISE] = NavableAdView;
			type[ElementTypeConsts.ARRANGE  ] = ArrangeView;
			type[ElementTypeConsts.GENERAL  ] = CommanView;
			//type[ElementTypeConsts.OFFICE   ] = OfficeView;
			//type[ElementTypeConsts.POPWINDOW] = PopWindowView;
			//type[ElementTypeConsts.THUMBNAIL] = ThumbnailView;
			//type[ElementTypeConsts.TIMELINE ] = TimelineView;
			type[ElementTypeConsts.WEBSITE  ] = WebsiteView;
		}
		
		/**
		 * @private
		 */
		private function prepareElements($data:VO):void
		{
			if ($data is Arrange)
			{
				var count:uint = 0;
				var arrange:Arrange = Arrange($data);
				for each (var view:CacheView in elements)
				{
					view.reset();
					if (container.containsElement(view))
						container.removeElement(view);
				}
				elements = {};
				
				for each (var item:ArrangeIcon in arrange.icons)
				{
					if (type[item.element.type])
					{
						count++;
						view = new CacheView;
						view.refer   = type[item.element.type];
						view.width   = width;
						view.height  = height;
						view.data    = item.element;
						view.visible = false;
						container.addElement(view);
						//每个item的vid一定不同，因此用vid存储，而id有可能相同。
						elements[item.vid] = view;
					}
				}
				trace("prepareElements:", $data.id, "-", count);
			}
		}
		
		/**
		 * @private
		 */
		private function resetTimer():void
		{
			if (timer)
			{
				timer.reset();
				timer.start();
			}
		}
		
		/**
		 * @private
		 */
		private function indexOfHistory($data:ArrangeIcon):int
		{
			if (history.length)
			{
				for (var i:int = history.length - 1; i >=0; i--)
					if (history[i].data.id == $data.element.id) return i;
			}
			return -1;
		}
		
		
		/**
		 * @private
		 */
		private function callbackTweenPlay():void
		{
			last.stop();
		}
		
		/**
		 * @private
		 */
		private function callbackTweenStop():void
		{
			main.play();
			last.visible = false;
			main.visible = true;
			prepareElements(main.data);
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			if (advertise)
			{
				if (advertise.data.ready)
				{
					LogSaver.log(
						TypeConsts.FILE,
						EventConsts.EVENT_START_PLAYING,
						advertise.data,
						log(MPTipConsts.RECORD_TYPESET_PLAY_AD, advertise.data));
					
					timer.stop();
					advertise.visible = true;
					advertise.play(false);
					home();
					Input.close();
				}
				else
				{
					resetTimer();
				}
			}
			else
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handlerTimerComplete);
			}
		}
		
		/**
		 * @private
		 */
		private function handlerMouseDown($e:MouseEvent = null):void
		{
			if (advertise)
			{
				if (advertise.visible && !fadeOut.isPlaying)
				{
					log(MPTipConsts.RECORD_TYPESET_STOP_AD);
					
					advertise.stop(false);
					advertise.visible = false;
				}
				resetTimer();
			}
		}
		
		
		/**
		 * @private
		 */
		private var container:Group;
		
		/**
		 * @private
		 */
		private var zoomer:Zoomer;
		
		/**
		 * @private
		 */
		private var advertise:CacheView;
		
		/**
		 * @private
		 */
		private var main:CacheView;
		
		/**
		 * @private
		 */
		private var last:CacheView;
		
		/**
		 * @private
		 */
		private var history:Vector.<CacheView>;
		
		/**
		 * @private
		 */
		private var type:Object;
		
		/**
		 * @private
		 */
		private var typeset:Typeset;
		
		/**
		 * @private
		 */
		private var elements:Object;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var fadeIn:Fade;
		
		/**
		 * @private
		 */
		private var fadeOut:Fade;
		
	}
}