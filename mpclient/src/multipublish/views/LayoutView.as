package multipublish.views
{
	
	/**
	 * 
	 * 排版视图。
	 * 
	 */
	
	
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.ClassUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.utils.EffectUtil;
	import multipublish.views.contents.ButtonView;
	import multipublish.views.contents.MarqueeView;
	import multipublish.vo.programs.Layout;
	import multipublish.vo.programs.Page;
	
	import mx.effects.Effect;
	import mx.effects.Sequence;
	import mx.events.EffectEvent;
	
	
	public final class LayoutView extends MPView
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function LayoutView()
		{
			super();
			
			sequence = new Sequence;
			sequence.duration = config.zoomTweenTime * 250;
			addEventListener(MouseEvent.CLICK, button_clickHandler);
		}
		
		
		/**
		 * 
		 * 返回首页。
		 * 
		 */
		
		public function home($play:Boolean = true, $rect:Rectangle = null, $force:Boolean = false):void
		{
			var level:int = history.length;
			if (level > 0) back(level - 1, $play, $rect, $force);
		}
		
		
		/**
		 * 
		 * 返回上页。
		 * 
		 */
		
		public function back($level:int, $play:Boolean = true, $rect:Rectangle = null, $force:Boolean = false):void
		{
			if(!tweening)
			{
				var index:int = history.length - 1 - $level;
				if (0 <= index && index < history.length)
				{
					var lasts:Array = [];
					var l:uint = history.length;
					for (var i:uint = l - 1; i > index; i--) lasts.push(history[i]);
					last = history[index];
					
					log(MPTipConsts.RECORD_TYPESET_BACK, last ? last.data : null);
					
					var temp:PageView = main;
					main = last;
					last = temp;
					
					if (main == last)
					{
						$play ? main.play(false) : main.stop(false, $rect, $force);
					}
					else
					{
						wt::tweening = true;
						var effectOutStart:Function = function():void
						{
							for each (var item:PageView in lasts) item.stop(false, $rect, $force);
						};
						var effectOutEnd:Function = function():void
						{
							for each (var item:PageView in lasts)
							{
								if (containsElement(item))
									removeElement(item);
								item.reset();
							}
							
							$play ? main.play(false) : main.stop(false, null, $force);
							last = index > 0 ? history[index - 1] : null;
							history.length -= lasts.length;
							wt::tweening = false;
						};
						
						if ((main.data as Page).tweenable)
						{
							effectOut = getEffectOut(last, main);
							onEffectOutStart = effectOutStart;
							onEffectOutEnd = effectOutEnd;
							effectOut.targets = lasts;
							sequence.children = [effectOut];
							sequence.play();
						}
						else
						{
							effectOutStart();
							effectOutEnd();
						}
					}
				}
			}
		}
		
		
		/**
		 * 
		 * 进入子页面。
		 * 
		 */
		
		public function view($page:Page, $button:ButtonView = null):void
		{
			if ($page && $page!= main.data && !tweening)
			{
				var index:int = indexOfHistory($page);
				if (index == -1)
				{
					wt::tweening = true;
					//新页面在历史记录中不存在，打开新页面。
					log(MPTipConsts.RECORD_TYPESET_VIEW, $page);
					
					var effects:Array = [];
					var lasts:Array = checkOfHistory($page);
					last = main;
					main = createPage($page, true);
					
					var handler:Function = function(e:ControlEvent):void
					{
						main.removeEventListener(ControlEvent.READY, handler);
						
						if (lasts) history.length -= lasts.length;
						
						//显示新页面
						var effectInStart:Function = function():void
						{
							//for each (var item:LayoutView in lasts) item.stop();
							if (last.playing)
							{
								var father:Page = main.data is Page ? (main.data as Page).father : null;
								if (father)
								{
									var rect:Rectangle = new Rectangle;
									rect.x = main.x;
									rect.y = main.y;
									rect.width = main.width;
									rect.height = main.height;
								}
								last.stop(false, rect);
							}
						};
						var resetLasts:Function = function():void
						{
							history.push(main);
							wt::tweening = false;
							for each (var item:PageView in lasts) 
							{
								if (containsElement(item)) removeElement(item);
								item.reset();
							}
						}
						var effectInEnd:Function = function():void
						{
							main.play();
							last.resume();
							if (lasts)
								TimerUtil.callLater(500, resetLasts);
							else
								resetLasts();
						};
						
						if ($page.tweenable)
						{
							effectIn  = getEffectIn (last, main);
							onEffectInStart = effectInStart;
							onEffectInEnd = effectInEnd;
							effectIn.target = main;
							
							effects.push(effectIn);
							sequence.children = effects;
							sequence.play();
						}
						else
						{
							effectInStart();
							effectInEnd();
						}
					};
					main.addEventListener(ControlEvent.READY, handler);
					main.data = $page;
				}
				else
				{
					if (index == 0)
						home();
					else if (index < history.length - 1)
						back(history.length - 1 - index);
				}
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			main && main.play();
			
			timerCreate();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			main && main.stop(false);
			
			adStop();
			
			timerDelete();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			history.length = 0;
			removeAllElements();
			
			if (main)
			{
				main.reset();
				main = null;
			}
			if (last) 
			{
				last.reset();
				last = null;
			}
			source = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			source = data as Layout;
			
			if (source.home && 
				source.pagesArr.length)    //该 pagesArr为 children 即根页面集合。
			{
				main = createPage(source.home, true);    //增加页面并进入缓存。
				main.addEventListener(ControlEvent.READY, handlerReady);
				main.data = source.home;  
				history.push(main);
			}	
			
			if (source.ad && 
				source.ad.enabled && 
				source.ad.waitTime)
			{
				ad = new ADView;
				ad.data = source.ad;
				ad.x = source.ad.x;
				ad.y = source.ad.y;
			}
		}
		
		
		/**
		 * @private
		 */
		private function createPage($page:Page, $visible:Boolean = false):PageView
		{
			var page:PageView = new PageView;   
			page.width  = $page.w;
			page.height = $page.h;
			page.x = $page.x;
			page.y = $page.y;
			addElement(page).visible = $visible;
			return page;
		}
		
		
		private function handlerReady($e:ControlEvent):void
		{
			var temp:MPView = $e.target as MPView;
			temp.removeEventListener(ControlEvent.READY, handlerReady);
			
			dispatchReady();
		}
		
		
		/**
		 * @private
		 */
		private function indexOfHistory($page:Page):int
		{
			if (history.length && $page)
			{
				for (var i:int = history.length - 1; i >= 0; i--)
					if (history[i].data == $page) return i;
			}
			return -1;
		}
		
		/**
		 * 根据当前要显示的页面检测历史中所有需要关闭的页面，并返回一个数组。
		 * @private
		 */
		private function checkOfHistory($page:Page):Array
		{
			var l:int = history.length - 2;
			if (history.length)
			{
				var flag:int = l;
				var result:Array;
				
				if ($page.father)
				{
					//如果当前显示页有父级，则遍历历史页面数组，找到与该页面父级相同的元素
					/*while ($page.father)
					{*/
						while (flag >= 0)
						{
							trace("check:", $page.father.label, history[flag].data.label, "same:" + ($page.father == history[flag].data))
							if ($page.father == history[flag].data)
							{
								for (var i:int = l + 1; i > flag; i--)
								{
									result = result || [];
									ArrayUtil.push(result, history[i]);
								}
								break;
							}
							flag--;
						}
						/*if (result)
						{
							break;
						}
						else
						{
							flag = l;
							$page = $page.father;
						}*/
					/*}*/
				}
				else
				{
					//如果当前显示页面没有父级，则需要隐藏所有历史
					if (history.length)
					{
						result = history.concat();
						result.reverse();
					}
				}
			}
			
			return result;
		}
		
		/**
		 * @private
		 */
		private function getEffectIn($last:PageView, $main:PageView):Effect
		{
			var effect:Effect = EffectUtil.getEffectIn($last.data as Page, $main.data as Page, source);
			effect.addEventListener(EffectEvent.EFFECT_START, effectIn_startHandler);
			effect.addEventListener(EffectEvent.EFFECT_END, effectIn_endHandler);
			return effect;
		}
		
		/**
		 * @private
		 */
		private function getEffectOut($last:PageView, $main:PageView):Effect
		{
			var effect:Effect = EffectUtil.getEffectOut($last.data as Page, $main.data as Page, source);
			effect.addEventListener(EffectEvent.EFFECT_START, effectOut_startHandler);
			effect.addEventListener(EffectEvent.EFFECT_END, effectOut_endHandler);
			return effect;
		}
		
		/**
		 * @private
		 */
		private function timerCreate():void
		{
			if(!timer && ad)
			{
				timer = new Timer(1000, ad.waitTime);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
				timer.start();
			}
		}
		
		/**
		 * @private
		 */
		private function timerDelete():void
		{
			if (timer)
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler);
				timer.stop();
				timer = null;
				
			}
		}
		
		/**
		 * @private
		 */
		private function timerReset():void
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
		private function adPlay():void
		{
			if (ad)
			{
				containsElement(ad) && removeElement(ad);
				
				addElement(ad);
				
				ad.play(false);
				
				var rect:Rectangle = new Rectangle(ad.x, ad.y, ad.width, ad.height);
				
				home(true, rect, true);
			}
		}
		
		/**
		 * @private
		 */
		private function adStop():void
		{
			if (ad)
			{
				containsElement(ad) && removeElement(ad);
				
				ad.stop(false);
				
				if (main) main.play();
			}
		}
		
		
		/**
		 * @private
		 */
		private function timer_completeHandler($e:TimerEvent):void
		{
			(ad && ad.data) ? (ad.data.ready ? adPlay() : timerReset()) : timerDelete();
		}
		
		/**
		 * @private
		 */
		private function effectIn_startHandler($e:EffectEvent):void
		{
			effectIn.removeEventListener(EffectEvent.EFFECT_START, effectIn_startHandler);
			
			if (onEffectInStart!= null)
			{
				onEffectInStart();
				onEffectInStart = null;
			}
		}
		
		/**
		 * @private
		 */
		private function effectIn_endHandler($e:EffectEvent):void
		{
			effectIn.removeEventListener(EffectEvent.EFFECT_END, effectIn_endHandler);
			
			if (onEffectInEnd!= null)
			{
				onEffectInEnd();
				onEffectInEnd = null;
			}
		}
		
		/**
		 * @private
		 */
		private function effectOut_startHandler($e:EffectEvent):void
		{
			effectOut.removeEventListener(EffectEvent.EFFECT_START, effectOut_startHandler);
			
			if (onEffectOutStart!= null)
			{
				onEffectOutStart();
				onEffectOutStart = null;
			}
		}
		
		/**
		 * @private
		 */
		private function effectOut_endHandler($e:EffectEvent):void
		{
			effectOut.removeEventListener(EffectEvent.EFFECT_END, effectOut_endHandler);
			
			if (onEffectOutEnd!= null)
			{
				onEffectOutEnd();
				onEffectOutEnd = null;
			}
		}
		
		/**
		 * @private
		 */
		private function button_clickHandler($e:MouseEvent):void
		{
			timerReset();
			adStop();
//			
//			if (config.debug)
//			{
//				LogUtil.log("===== clicked item's type is " + 
//					ClassUtil.getClassName(
//						$e.target, false) + " =====");
//			}
			
			if ($e.target is ButtonView || $e.target is MarqueeView)
			{
				var button:* = $e.target.data;
				var page:Page = source.pagesTol[button.pageID];
				if (page) view(page, $e.target as ButtonView);
			}
		}
		
		
		/**
		 * @private
		 */
		private var effectIn:Effect;
		
		/**
		 * @private
		 */
		private var effectOut:Effect;
		
		/**
		 * @private
		 */
		private var sequence:Sequence;
		
		/**
		 * @private
		 */
		private var onEffectInStart:Function;
		
		/**
		 * @private
		 */
		private var onEffectInEnd:Function;
		
		/**
		 * @private
		 */
		private var onEffectOutStart:Function;
		
		/**
		 * @private
		 */
		private var onEffectOutEnd:Function;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var history:Array = [];
		
		/**
		 * @private
		 */
		private var main:PageView;
		
		/**
		 * @private
		 */
		private var last:PageView;
		
		/**
		 * @private
		 */
		private var ad:ADView;
		
		/**
		 * @private
		 */
		private var source:Layout;
		
	}
}