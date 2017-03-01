package multipublish.views
{
	
	/**
	 * 
	 * 布局视图。
	 * 
	 */
	
	
	import caurina.transitions.Tweener;
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import multipublish.consts.ContentTypeConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.core.mp;
	import multipublish.utils.ContentUtil;
	import multipublish.views.contents.NewsView;
	import multipublish.vo.contents.News;
	import multipublish.vo.programs.Component;
	
	import mx.core.IVisualElement;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.primitives.Rect;
	
	
	public final class ComponentView extends MPView
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ComponentView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			if (view) 
			{
				stopDispatched = false;
				
				view.addEventListener(ControlEvent.STOP, handlerViewStop);
				view.play(false);
			}
			else
			{
				stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			if (view)
			{
				view.removeEventListener(ControlEvent.STOP, handlerViewStop);
				view.stop(false);
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processResume():void
		{
			if (view) view.resume();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			
			if (view) view.reset();
			if (next) next.reset();
			if (prev) prev.reset();
			
			view = next = prev = null;
			fore = last = null;
			source = null;
			index = neigh = 0;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			source = data as Component;
			if (source)
			{
				log(MPTipConsts.RECORD_COMPONENT_DATA, source);
				
				mouseEnabled = mouseChildren = source.interactable;
				
				if (source.interactable)
					buttonMode = (source.code == ContentTypeConsts.BUTTON) && Boolean(source.linkID);
				
				navigatable = source.interactable && source.contents.length > 1;    //是否允许交互  && 存在内容。
				
				updateBackground();
				
				view = generateView();
				view.data = source.contents[index];
				fore = generateNext();
				last = generateNext(false);
			}
		}
		
		
		/**
		 * @private
		 */
		private function generateView():MPView
		{
			var l:uint = source.contents.length;
			if (l)
			{
				var result:MPView = ContentUtil.getContentView(source.contents[index]);
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
			var l:uint = source.contents.length;
			if (l)
			{
				$side ? neigh ++ : neigh --;
				if (neigh != index)
				{
					var result:MPView = ContentUtil.getContentView(source.contents[neigh]);
					if (result) 
					{
						result.data = source.contents[neigh];
						result.width  = width;
						result.height = height;
						if (direction)
							result.x = $side ? width : -width;
						else
							result.y = $side ? height : -height;
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
			container.addEventListener(MouseEvent.MOUSE_DOWN, handlerMouseDown);
		}
		
		
		/**
		 * 
		 * 更新背景
		 * 
		 */
		
		protected function updateBackground():void
		{
			if (source)
			{
				var component:IVisualElement, rect:Rect, image:Image;
				
				if(!background)
				{
					addElementAt(background = new Group, 0);
					background.percentHeight = 100;
					background.percentWidth  = 100;
				}
				
				background.alpha = source.backgroundAlpha;
				background.removeAllElements();
				if (StringUtil.isEmpty(source.background))
				{
					component = rect = new Rect;
					rect.percentHeight = 100;
					rect.percentWidth  = 100;
					rect.fill = new SolidColor(source.backgroundColor);
				}
				else
				{
					component = image = new Image;
					image.percentHeight = 100;
					image.percentWidth  = 100;
					image.fillMode = BitmapFillMode.SCALE;
					image.scaleMode = BitmapScaleMode.ZOOM;
					image.source = source.background;
					background.addElement(image);
				}
				
				background.addElement(component);
			}
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
					tweenFliped = b > distance;   //是否进行切换。
					const property:Number = direction ? width : height;
					var a:Number = tweenFliped ? (side ? -property : property) : 0;   //如果不切换 则当前移至 0 切换则向正方向则为 property。
					var p:Number = b / property;
					var t:Number = Math.max(.3, p * config.slideTweenTime);
					if (tweenFliped) wt::tweening = true;
					var tweenObj:Object ={time:t, onComplete:callbackTweenOver};
					var s:String = direction ? "x" : "y";
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
				var prop:String = direction ? "x" : "y";
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
			
			if (down)
			{
				down = false;
				tempStage.removeEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				tempStage.removeEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
			}
			
			if (source)
			{
				if (index >= source.contents.length - 1 && !stopDispatched) 
				{
					stopDispatched = true;
					dispatchEvent(new ControlEvent(ControlEvent.STOP));
				}
				
				tween(-(direction ? width : height));
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
		private function handlerMouseDown($e:MouseEvent):void
		{
			if(navigatable && !tweening)
			{
				down = true;
				wt::tweening = true;
				tempStage = stage;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
				start = direction ? mouseX : mouseY;   //上下为 false 左右为 true。
			}
		}
		
		/**
		 * @private
		 */
		private function handlerMouseMove($e:MouseEvent):void
		{
			if (direction)
			{
				container.x = mouseX - start;
			}
			else
			{
				container.y = mouseY - start;
			}
		}
		
		/**
		 * @private
		 */
		private function handlerMouseUp($e:MouseEvent):void
		{
			if (navigatable && tweening)
			{
				down = false;
				tempStage.removeEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				tempStage.removeEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
				const d:Number = (direction ? mouseX : mouseY) - start;   //最后的位移。
				const property:Number = direction ? width : height;	
				
				//当位移大于宽 /高的10%后，会切换。
				tween((Math.abs(d) > distance) ? (d > 0 ? property - d : -property - d) : d);
			}
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
			var l:uint = source ? source.contents.length : 0;
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
			var l:uint = source ? source.contents.length : 0;
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
		private function get distance():Number
		{
			return (direction ? width * .1 : height * .1);
		}
		
		/**
		 * 上下为false 左右为true。
		 */
		private function get direction():Boolean
		{
			return source ? source.transition : true;
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
		private var source:Component;
		
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