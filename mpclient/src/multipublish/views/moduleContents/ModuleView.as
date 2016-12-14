package multipublish.views.moduleContents
{
	import caurina.transitions.Tweener;
	
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	
	import flash.display.Stage;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.core.mp;
	import multipublish.utils.ContentUtil;
	import multipublish.views.MPView;
	import multipublish.views.contents.ContentView;
	import multipublish.vo.contents.Content;
	import multipublish.vo.moduleContents.Module;
	
	import spark.components.Group;
	
	public class ModuleView extends MPView
	{
		public function ModuleView()
		{
			super();
			
			initializeEnvironment();
		}
		
//		/**
//		 * @inheritDoc
//		 */
//		
//		override protected function processPlay():void
//		{
//			if (view) 
//			{
//				stopDispatched = false;
//				
//				view.addEventListener(ControlEvent.STOP, handlerViewStop);
//				view.play(false);
//			}
//			else
//			{
//				stop();
//			}
//		}
		
		
//		/**
//		 * @inheritDoc
//		 */
//		
//		override protected function processStop():void
//		{
//			if (view)
//			{
//				view.removeEventListener(ControlEvent.STOP, handlerViewStop);
//				view.stop(false);
//			}
//		}
		
		
//		/**
//		 * @inheritDoc
//		 */
//		
//		override protected function processResume():void
//		{
//			if (view) view.resume();
//		}
		
		
//		/**
//		 * @inheritDoc
//		 */
//		
//		override protected function processReset():void
//		{
//			container.removeAllElements();
//			
//			if (view) view.reset();
//			if (next) next.reset();
//			if (prev) prev.reset();
//			
//			view = next = prev = null;
//			fore = last = null;
//			source = null;
//			index = neigh = 0;
//		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			source = data as Module;
			if (source)
			{
				log(MPTipConsts.RECORD_COMPONENT_DATA, source);
				
				navigatable = mouseEnabled = mouseChildren = false;
				
				view = generateView();
				view.data = source.moduleContent[index];
				fore = generateNext();
				last = generateNext(false);
			}
		}
		
		
		/**
		 * @private
		 */
		private function generateView():MPView
		{
			var l:uint = source.moduleContent.length;
			if (l)
			{
				var result:MPView = new source.moduleClass;
				if (result)
				{
					result.width  = width;
					result.height = height;
					container.addElement(result);
					result.addEventListener(ControlEvent.READY, handlerReady);
					neigh = index;
				}
				else
				{
					index ++;
					if (index != neigh)
						result = generateView();
				}
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private function generateNext($side:Boolean = true):MPView
		{
			var l:uint = source.moduleContent.length;
			if (l)
			{
				$side ? neigh ++ : neigh --;
				if (neigh != index)
				{
					var result:MPView = new source.moduleClass;
					if (result) 
					{
						result.width  = width;
						result.height = height;
						result.x = $side ? width : -width;
						container.addElement(result);
						neigh = index;
					}
				}
				if(!result && neigh != index) result = generateNext($side);
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			addElement(container = new Group);
		}
		
		
		
		/**
		 * @private
		 */
		private function tween($distance:Number):void
		{
			var d:Number = $distance;
			if (d)
			{
				side = d < 0;
				prev = view;
				next = side ? fore : last;
				if (prev && next)
				{
					var b:Number = Math.abs(d);
					tweenFliped = true;   //是否进行切换。
					const property:Number = width;
					var a:Number = tweenFliped ? (side ? -property : property) : 0;   //如果不切换 则当前移至 0 切换则向正方向则为 property。
					var p:Number = b / property;
					var t:Number = Math.max(.3, p * config.slideTweenTime);
					if (tweenFliped) wt::tweening = true;
					var tweenObj:Object ={time:t, onComplete:callbackTweenOver};
					var s:String = "x";
					tweenObj[s] = a;
					Tweener.addTween(container, tweenObj);
				}
				else 
				{
					wt::tweening = false;
					processPlay();
				}
			} else wt::tweening = false;
		}
		
		
		/**
		 * @private
		 */
		private function callbackTweenOver():void
		{
			if (tweenFliped)
			{
				var prop:String = "x";
				container[prop] = 0;
				container.removeElement(side ? last : fore);
				container.removeElement(view);
				view.removeEventListener(ControlEvent.STOP, handlerViewStop);
				view.reset();
				view = next;
				view[prop] = 0;
				view.addEventListener(ControlEvent.STOP, handlerViewStop);
				view.play();
				index += side ? 1 : -1;
				neigh = index;
				fore = generateNext();
				last = generateNext(false);
				
				next = prev = null;
			}
			
			wt::tweening = false;
		}
		
		/**
		 * @private
		 */
		private function handlerViewStop($e:ControlEvent):void
		{
			if (view) view.removeEventListener(ControlEvent.STOP, handlerViewStop);
			
			
			if (source)
			{
				if (index >= source.moduleContent.length - 1 && !stopDispatched) 
				{
					stopDispatched = true;
					dispatchEvent(new ControlEvent(ControlEvent.STOP));
				}
				
				tween(-width);
			}
		}
		
		/**
		 * @private
		 */
		private function handlerReady($e:ControlEvent):void
		{
			var temp:MPView = $e.target as MPView;
			temp.removeEventListener(ControlEvent.READY, handlerReady);
			
			dispatchReady();
		}
		
		
		
		
		/**
		 * @private
		 */
		private function get index():int
		{
			return mp::index;
		}
		
		/**
		 * @private
		 */
		private function set index($value:int):void
		{
			var l:uint = source ? source.moduleContent.length : 0;
			if (l)
			{
				if ($value>= l) $value = 0;
				if ($value < 0) $value = l - 1;
				mp::index = $value;
			}
		}
		
		
		/**
		 * @private
		 */
		private function get neigh():int
		{
			return mp::neigh;
		}
		
		/**
		 * 
		 * 下一个内容的标记。
		 * 
		 */
		private function set neigh($value:int):void
		{
			var l:uint = source ? source.moduleContent.length : 0;
			if (l)
			{
				if ($value>= l) $value = 0;
				if ($value < 0) $value = l - 1;
				mp::neigh = $value;
			}
		}
		
		
		
		
		/**
		 * @private
		 */
		private var start:Number;
		
		/**
		 * 
		 * 是否允许交互  && 是否存在内容。
		 * 
		 */
		private var navigatable:Boolean;
		
		/**
		 * @private
		 */
		private var down:Boolean;
		
		/**
		 * @private
		 */
		private var side:Boolean;
		
		/**
		 * @private
		 */
		private var source:Module;
		
		/**
		 * @private
		 */
		private var last:MPView;
		
		/**
		 * @private
		 */
		private var fore:MPView;
		
		/**
		 * @private
		 */
		private var prev:MPView;
		
		/**
		 * @private
		 */
		private var next:MPView;
		
		/**
		 * @private
		 */
		private var view:MPView;
		
		/**
		 * @private
		 */
		private var container:Group;
		
		/**
		 * @private
		 */
		private var tempStage:Stage;
		
		/**
		 * @private
		 */
		private var stopDispatched:Boolean = false;
		
		/**
		 * @private
		 */
		private var tweenFliped:Boolean;
		
		/**
		 * @private
		 */
		private var tweenStoped:Boolean;
		
		/**
		 * @private
		 */
		private var background:Group;
		
		
		/**
		 * @private
		 */
		mp var index:int;
		
		/**
		 * @private
		 */
		mp var neigh:int;
	}
}