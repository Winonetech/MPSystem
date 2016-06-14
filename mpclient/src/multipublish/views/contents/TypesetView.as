package multipublish.views.contents
{
	
	/**
	 * 
	 * 排版内容。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ClassUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.core.VO;
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import input.Input;
	
	import multipublish.consts.ArrangeLayoutTypeConsts;
	import multipublish.consts.ElementTypeConsts;
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.views.CacheView;
	import multipublish.views.elements.*;
	import multipublish.vo.contents.Typeset;
	import multipublish.vo.elements.*;
	
	import mx.effects.Sequence;
	import mx.events.EffectEvent;
	
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
		
		public function back($level:uint = 1, $tween:Boolean = true, $play:Boolean = true):void
		{
			if(!tweening)
			{
				var index:int = history.length - 1 - $level;
				if (0 <= index && index < history.length)
				{
					log(MPTipConsts.RECORD_TYPESET_BACK, last ? last.data : null);
					var lasts:Array = [];
					var l:uint = history.length;
					for (var i:uint = l - 1; i > index; i--) lasts.push(history[i]);
					last = history[index];
					var temp:CacheView = main;
					main = last;
					last = temp;
					
					var fadeOutStart:Function = function():void
					{
						for each (var item:CacheView in lasts) item.stop();
					};
					var fadeOutEnd:Function = function():void
					{
						for each (var item:CacheView in lasts) 
						{
							item.visible = false;
							item.reset();
							if (container.containsElement(item))
								container.removeElement(item);
						}
						if ($play) main.play();
						last = index > 0 ? history[index - 1] : null;
						history.length -= lasts.length;
					};
					
					if ($tween)
					{
						onFadeOutStart = fadeOutStart;
						onFadeOutEnd = fadeOutEnd;
						fadeOut.target = null;
						fadeOut.targets = lasts;
						sequence.children = [fadeOut];
						sequence.play();
					}
					else
					{
						fadeOutStart();
						fadeOutEnd();
					}
				}
			}
		}
		
		
		/**
		 * 
		 * 返回首页。
		 * 
		 */
		
		public function home($tween:Boolean = true, $play:Boolean = true):void
		{
			var level:int = history.length;
			if (level > 0) back(level - 1, $tween, $play);
		}
		
		
		/**
		 * 
		 * 进入子页面。
		 * 
		 */
		
		public function view($data:ArrangeIcon, $rect:Rectangle = null):void
		{
			//非缓动
			if (!tweening)
			{
				var index:int = indexOfHistory($data);
				if (index == -1)
				{
					//新页面在历史记录中不存在，打开新页面。
					log(MPTipConsts.RECORD_TYPESET_VIEW, $data.element);
					
					if ($data.element && $data.element != main.data)
					{
						var effects:Array = [];
						lasts = check($data);
						last = main;
						main = createElement($data);
						if (lasts)
						{
							history.length -= lasts.length;
							var fadeOutStart:Function = function():void
							{
								for each (var item:CacheView in lasts) item.stop();
							};
							var fadeOutEnd:Function = function():void
							{
								for (var i:int = lasts.length - 1; i >= 0; i--) 
								{
									var item:CacheView = lasts[i];
									item.visible = false;
									item.reset();
								}
							};
							if ($data.tween)
							{
								onFadeOutStart = fadeOutStart;
								onFadeOutEnd = fadeOutEnd;
								fadeOut.targets = lasts;
								effects.push(fadeOut);
							}
							else
							{
								fadeOutStart();
								fadeOutEnd();
							}
						}
						
						//显示新页面
						var fadeInStart:Function = function():void
						{
							main.alpha = 0;
							main.visible = true;
						};
						var fadeInEnd:Function = function():void
						{
							main.alpha = 1;
							main.play();
							history.push(main);
						};
						
						if ($data.tween)
						{
							onFadeInStart = fadeInStart;
							onFadeInEnd = fadeInEnd;
							fadeIn.target = main;
							effects.push(fadeIn);
							sequence.children = effects;
							sequence.play();
						}
						else
						{
							TimerUtil.callLater(250, function():void{
								fadeInStart();
								fadeInEnd();
							});
						}
					}
				}
				else
				{
					if (index == 0)
						home($data.tween);
					else if (index < history.length - 1)
						back(history.length - 1 - index, $data.tween);
				}
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
				
				container.addElement(main = new CacheView);
				main.refer  = ArrangeView;
				main.width  = width;
				main.height = height;
				main.data   = typeset.arrange;
				history.push(main);
				
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
			sequence = new Sequence;
			sequence.duration = config.zoomTweenTime * 250;
			fadeIn.alphaFrom = fadeOut.alphaTo = 0;
			fadeIn.alphaTo = fadeOut.alphaFrom = 1;
			fadeIn.addEventListener(EffectEvent.EFFECT_START, handlerFadeInStart);
			fadeIn.addEventListener(EffectEvent.EFFECT_END, handlerFadeInEnd);
			fadeOut.addEventListener(EffectEvent.EFFECT_START, handlerFadeOutStart);
			fadeOut.addEventListener(EffectEvent.EFFECT_END, handlerFadeOutEnd);
			history = new Vector.<CacheView>;
			addElement(container = new Group);
			container.percentWidth  = 100;
			container.percentHeight = 100;
			/*addElement(zoomer = new Zoomer);
			zoomer.percentWidth  = 100;
			zoomer.percentHeight = 100;
			zoomer.time          =(config.zoomTweenTime || 1);*/
			/*zoomer.onPlay        = callbackFadeOutStart;
			zoomer.onStop        = callbackFadeInEnd;*/
			
			type = {};
			type[ElementTypeConsts.ADVERTISE] = NavableAdView;
			type[ElementTypeConsts.ARRANGE  ] = ArrangeView;
			type[ElementTypeConsts.GENERAL  ] = CommanView;
			type[ElementTypeConsts.OFFICE   ] = OfficeView;
			type[ElementTypeConsts.NEWSPAPER] = NewsPaperView;
			//type[ElementTypeConsts.POPWINDOW] = PopWindowView;
			//type[ElementTypeConsts.THUMBNAIL] = ThumbnailView;
			//type[ElementTypeConsts.TIMELINE ] = TimelineView;
			type[ElementTypeConsts.WEBSITE  ] = WebsiteView;
		}
		
		/**
		 * @private
		 */
		private function createElement(item:ArrangeIcon):CacheView
		{
			var temp:CacheView = new CacheView;
			var arrange:CacheView = getArrangeViewFromHistory(item);
			//判断$data的排版类型，应用不同布局
			switch (item.layoutType)
			{
				case ArrangeLayoutTypeConsts.CUSTOM_LAYOUT:
					//自定义排版，设置新页面布局
					temp.x = arrange ? arrange.x + item.customX : item.customX;
					temp.y = arrange ? arrange.y + item.customY : item.customY;
					temp.width  = item.customW;
					temp.height = item.customH;
					break;
				case ArrangeLayoutTypeConsts.PARENT_LAYOUT:
					//使用父级排版布局
					temp.x = arrange ? arrange.x : 0;
					temp.y = arrange ? arrange.y : 0;
					temp.width  = arrange ? arrange.width  : 0;
					temp.height = arrange ? arrange.height : 0;
					break;
				case ArrangeLayoutTypeConsts.FULL_SCREEN:
				default:
					temp.fullscreen = true;
					temp.x = 0;
					temp.y = 0;
					temp.width  = width;
					temp.height = height;
					break;
			}
			temp.refer   = type[item.element.type];
			temp.data    = item.element;
			temp.visible = false;
			temp.historyID = item.vid;
			container.addElement(temp);
			//每个item的vid一定不同，用vid存储
			return temp;
		}
		
		/**
		 * @private
		 */
		private function getArrangeViewFromHistory(item:ArrangeIcon):CacheView
		{
			var arrange:Arrange = item.element as Arrange;
			if (arrange)
			{
				for (var i:int = history.length - 1; i >= 0; i--)
				{
					if (arrange == history[i].data)
					{
						var result:CacheView = history[i];
						break;
					}
				}
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private function check($data:ArrangeIcon):Array
		{
			if (history.length)
			{
				var flag:int = history.length - 1;
				var result:Array;
				while (flag >= 0)
				{
					if ($data.parent == history[flag].data)
					{
						for (var i:uint = history.length - 1; i > flag; i--)
						{
							result = result || [];
							result.push(history[i]);
						}
						break;
					}
					flag--;
				}
			}
			return result;
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
			if (history.length && $data.element)
			{
				for (var i:int = history.length - 1; i >= 0; i--)
				{
					if (history[i].data.className == $data.element.className && 
						history[i].data == $data.element) return i;
				}
			}
			return -1;
		}
		
		
		/**
		 * @private
		 */
		private function handlerTimerComplete($e:TimerEvent):void
		{
			if (advertise)
			{
				if ((advertise.data as VO).ready)
				{
					LogSQLite.log(
						TypeConsts.FILE,
						EventConsts.EVENT_START_PLAYING,
						advertise.data,
						log(MPTipConsts.RECORD_TYPESET_PLAY_AD, advertise.data));
					
					timer.stop();
					
					var fadeInStart:Function = function():void
					{
						main.stop();
						Input.close();
						advertise.visible = true;
					};
					
					var fadeInEnd:Function = function():void
					{
						advertise.play();
						home();
					};
					
					onFadeInStart = fadeInStart;
					onFadeInEnd = fadeInEnd;
					fadeIn.target = advertise;
					fadeIn.play();
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
		private function handlerFadeInStart($e:EffectEvent):void
		{
			if (onFadeInStart!= null)
			{
				onFadeInStart();
				onFadeInStart = null;
			}
		}
		
		/**
		 * @private
		 */
		private function handlerFadeInEnd($e:EffectEvent):void
		{
			if (onFadeInEnd!= null)
			{
				onFadeInEnd();
				onFadeInEnd = null;
			}
		}
		
		/**
		 * @private
		 */
		private function handlerFadeOutStart($e:EffectEvent):void
		{
			if (onFadeOutStart!= null)
			{
				onFadeOutStart();
				onFadeOutStart = null;
			}
		}
		
		/**
		 * @private
		 */
		private function handlerFadeOutEnd($e:EffectEvent):void
		{
			if (onFadeOutEnd!= null)
			{
				onFadeOutEnd();
				onFadeOutEnd = null;
			}
		}
		
		
		/**
		 * @private
		 */
		private var onFadeInStart:Function;
		
		/**
		 * @private
		 */
		private var onFadeInEnd:Function;
		
		/**
		 * @private
		 */
		private var onFadeOutStart:Function;
		
		/**
		 * @private
		 */
		private var onFadeOutEnd:Function;
		
		/**
		 * @private
		 */
		private var tweening:Boolean;
		
		/**
		 * @private
		 */
		private var container:Group;
		
		/**
		 * @private
		 */
		//private var zoomer:Zoomer;
		
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
		private var lasts:Array;
		
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
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var fadeIn:Fade;
		
		/**
		 * @private
		 */
		private var fadeOut:Fade;
		
		/**
		 * @private
		 */
		private var sequence:Sequence;
		
	}
}