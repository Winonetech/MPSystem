package multipublish.views
{
	
	/**
	 * 
	 * 布局视图。
	 * 
	 */
	
	
	import caurina.transitions.Tweener;
	
	import com.winonetech.events.ControlEvent;
	
	import flash.events.MouseEvent;
	import flash.system.System;
	
	import multipublish.consts.ContentTypeConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.core.mp;
	import multipublish.views.contents.*;
	import multipublish.vo.contents.Content;
	import multipublish.vo.programs.Layout;
	
	import spark.components.Group;
	
	
	public final class LayoutView extends MPView
	{
		
		/**
		 * 
		 * <code>LayoutView</code>构造函数。
		 * 
		 */
		
		public function LayoutView()
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
				view.stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			view  = next   = null;
			type  = source = null;
			index = neigh  = 0;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			source = data as Layout;
			if (source)
			{
				log(MPTipConsts.RECORD_LAYOUT_DATA, source);
				
				width  = source.width;
				height = source.height;
				navigatable = source.dragable && source.contents.length > 1;
				x = source.x;
				y = source.y;
				initializeType();
				view = generateView();
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
				var content:Content = source.contents[index];
				if (content)
				{
					if (type[content.type])
					{
						if (content.type == ContentTypeConsts.PICTURE || 
							content.type == ContentTypeConsts.RECORD)
						{
							var cache:CacheView = new CacheView;
							cache.refer  = type[content.type];
							var result:MPView = cache;
						}
						else
						{
							result = new type[content.type];
						}
					}
				}
				
				if (result)
				{
					result.width  = width;
					result.height = height;
					result.data   = content;
					container.addElement(result);
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
					var content:Content = source.contents[neigh];
					if (content)
					{
						if (type[content.type])
						{
							if (content.type == ContentTypeConsts.PICTURE || 
								content.type == ContentTypeConsts.RECORD)
							{
								var cache:CacheView = new CacheView;
								cache.refer  = type[content.type];
								var result:MPView = cache;
							}
							else
							{
								result = new type[content.type];
							}
						}
						if (result) 
						{
							result.data    = content;
							result.width   = width;
							result.height  = height;
							result.x       = $side ? width : -width;
							container.addElement(result);
							neigh = index;
						}
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
		 * @private
		 */
		private function initializeType():void
		{
			if(!type)
			{
				type = {};
				//type[ContentTypeConsts.GALLERY] = GalleryView;
				//type[ContentTypeConsts.MARQUEE] = MarqueeView;
				type[ContentTypeConsts.PICTURE] = PictureView;
				type[ContentTypeConsts.TYPESET] = TypesetView;
				type[ContentTypeConsts.RECORD ] = RecordView;
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
					var f:Boolean = b > distance;
					var a:Number = f ? (side ? -width : width) : 0;
					var p:Number = b / width;
					var t:Number = Math.max(.3, p * config.slideTweenTime);
					if (f) tweening = true;
					Tweener.addTween(container, {x:a, time:t, 
						onComplete:callbackTweenOver, 
						onCompleteParams:[f]});
				} else tweening = false;
			} else tweening = false;
		}
		
		
		/**
		 * @private
		 */
		private function callbackTweenOver($generate:Boolean = false):void
		{
			if ($generate)
			{
				container.x = 0;
				container.removeElement(side ? last : fore);
				container.removeElement(view);
				var gcable:Boolean = (view.data as Content).type == ContentTypeConsts.RECORD;
				view.removeEventListener(ControlEvent.STOP, handlerViewStop);
				view.reset();
				view = next;
				view.x = 0;
				view.addEventListener(ControlEvent.STOP, handlerViewStop);
				view.play();
				index += side ? 1 : -1;
				neigh = index;
				fore = generateNext();
				last = generateNext(false);
				
				next = prev = null;
				
				if (gcable) System.gc();
			}
			
			tweening = false;
		}
		
		/**
		 * @private
		 */
		private function handlerViewStop($e:ControlEvent):void
		{
			if (view) view.removeEventListener(ControlEvent.STOP, handlerViewStop);
			
			if (down)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
			}
			tween(-width);
			if (index >= source.contents.length - 1)
			{
				stop();
			}
		}
		
		
		/**
		 * @private
		 */
		private function handlerMouseDown($e:MouseEvent):void
		{
			if(navigatable && !tweening)
			{
				down = true;
				tweening = true;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
				start = mouseX;
			}
		}
		
		/**
		 * @private
		 */
		private function handlerMouseMove($e:MouseEvent):void
		{
			container.x = mouseX - start;
		}
		
		/**
		 * @private
		 */
		private function handlerMouseUp($e:MouseEvent):void
		{
			if (navigatable && tweening)
			{
				down = false;
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, handlerMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, handlerMouseUp);
				var d:Number = mouseX - start;
				tween((Math.abs(d) > distance) ? (d > 0 ? width - d : -width - d) : d);
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
		 * @private
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
		private var distance:Number = 150;
		
		/**
		 * @private
		 */
		private var start:Number;
		
		/**
		 * @private
		 */
		private var navigatable:Boolean;
		
		/**
		 * @private
		 */
		private var tweening:Boolean;
		
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
		private var source:Layout;
		
		/**
		 * @private
		 */
		private var type:Object;
		
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
		mp var index:int;
		
		/**
		 * @private
		 */
		mp var neigh:int;
		
	}
}