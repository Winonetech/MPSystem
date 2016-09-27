package multipublish.views.contents.epaper
{
	
	/**
	 * 
	 * 画布视图。
	 * 
	 */
	
	
	import caurina.transitions.Tweener;
	
	import cn.vision.utils.MathUtil;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import multipublish.core.mp;
	
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import org.gestouch.core.gestouch_internal;
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.TransformGesture;
	
	import spark.components.Group;
	
	
	[Bindable]
	public class Viewer extends Group
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function Viewer()
		{
			super();
		}
		
		
		/**
		 * 
		 * 重置缩放与位置。
		 * 
		 */
		
		public function reset($tween:Boolean = false):void
		{
			aimScale = isNaN(resetScale) ? 1 : resetScale;
			aimp.x = isNaN(resetX)
				?(width - scaledWidth) * .5
				:-resetX * aimScale + width * .5;
			aimp.y = isNaN(resetY)
				?(height - scaledHeight) * .5
				:-resetY * aimScale + height * .5;
			
			restrictScale();
			restrictXY();
			
			Tweener.removeTweens(this);
			
			if ($tween)
			{
				updateTween();
			}
			else
			{
				contentScale = aimScale;
				contentX = aimp.x;
				contentY = aimp.y;
			}
		}
		
		
		/**
		 * 
		 * 移动
		 * 
		 */
		
		public function moveTo(x:Number, y:Number, $tween:Boolean = false):void
		{
			aimp.x = x;
			aimp.y = y;
			
			restrictXY();
			
			if ($tween)
			{
				updateTween();
			}
			else
			{
				Tweener.removeTweens(this);
				
				contentX = aimp.x;
				contentY = aimp.y;
			}
		}
		
		
		/**
		 * 
		 * 缩放
		 * 
		 */
		
		public function scaleTo(scale:Number, $tween:Boolean = false, $center:Point = null):void
		{
			aimScale = scale;
			
			$center = $center || new Point(width * .5, height * .5);
			
			restrictScale($center.x, $center.y);
			
			if ($tween)
			{
				updateTween();
			}
			else
			{
				Tweener.removeTweens(this);
				
				contentScale = aimScale;
				contentX = aimp.x;
				contentY = aimp.y;
			}
		}
		
		
		public function update():void
		{
			caculateScale();
			
			resetScale = minScale;
			
			reset();
		}
		
		
		/**
		 * 
		 * 计算缩放最大最小值。
		 * 
		 */
		
		protected function caculateScale():void
		{
			var ow:Number = originWidth;
			var oh:Number = originHeight;
			var ww:Number = width;
			var wh:Number = height;
			
			maxScale = 1;
			minScale = (ow == 0 || oh == 0 || ww == 0 || wh == 0) 
				? 1 :(ow / oh < ww / wh ? wh / oh : ww / ow);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			gesture = new TransformGesture(this);
			gesture.addEventListener(GestureEvent.GESTURE_BEGAN, gestureBegin);
			
			addElement(back = new UIComponent);
			addElement(container = new Group);
			addElement(cover = new UIComponent);
			back.mouseChildren = false;
			container.mask = cover;
			container.mouseEnabled = false;
			cover.mouseEnabled = cover.mouseChildren = false;
			
			resizeWindow();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			resizeWindow();
		}
		
		
		/**
		 * @private
		 */
		private function resizeWindow():void
		{
			if (lastWidth != width || lastHeight != height)
			{
				lastWidth  = width;
				lastHeight = height;
				back.graphics.clear();
				back.graphics.beginFill(0, .05);
				back.graphics.drawRect(0, 0, width, height);
				back.graphics.endFill();
				
				cover.graphics.clear();
				cover.graphics.beginFill(0);
				cover.graphics.drawRect(0, 0, width, height);
				cover.graphics.endFill();
				
				if (content)
				{
					caculateScale();
					
					restrictScale();
					restrictXY();
					
					contentScale = isNaN(aimScale) ? 1 : aimScale;
					contentX = isNaN(aimp.x) ? 0 : aimp.x;
					contentY = isNaN(aimp.y) ? 0 : aimp.y;
				}
			}
		}
		
		
		//----------------------
		// 内容缩放移动限制检测
		//----------------------
		
		/**
		 * @private
		 */
		private function restrictScale($x:Number = 0, $y:Number = 0):void
		{
			aimScale = MathUtil.clamp(aimScale, minScale, maxScale);
			if (aimScale!= contentScale)
			{
				//the rate of scale
				var s:Number = aimScale / contentScale;
				//the aim position after scale
				aimp.x = $x - ($x - contentX) * s;
				aimp.y = $y - ($y - contentY) * s;
				if (aimScale < contentScale) restrictXY();
			}
		}
		
		/**
		 * @private
		 */
		private function restrictXY():void
		{
			aimp.x = scaledWidth  < width  ? (width  - scaledWidth ) * .5 : MathUtil.clamp(aimp.x, minX, maxX);
			aimp.y = scaledHeight < height ? (height - scaledHeight) * .5 : MathUtil.clamp(aimp.y, minY, maxY);
		}
		
		/**
		 * @private
		 */
		private function updateTween():void
		{
			Tweener.removeTweens(this);
			Tweener.addTween(this, {
				contentScale:aimScale, 
				contentX:aimp.x, 
				contentY:aimp.y, 
				time:1
			});
		}
		
		/**
		 * @private
		 */
		private function updateContent():void
		{
			if (container && lastContent &&  
				container.containsElement(lastContent))
				container.removeElement(lastContent);
			
			if (content)
			{
				container.addElementAt(content, 0);
				caculateScale();
				
				resetScale = minScale;
				
				reset();
			}
		}
		
		/**
		 * @private
		 */
		private function updateContentScale():void
		{
			if (container) container.scaleX = container.scaleY = contentScale;
		}
		
		/**
		 * @private
		 */
		private function updateContentX():void
		{
			if (container) container.x = Math.floor(100 * contentX) * .01;
		}
		
		/**
		 * @private
		 */
		private function updateContentY():void
		{
			if (container) container.y = Math.floor(100 * contentY) * .01;
		}
		
		
		/**
		 * @private
		 */
		private function mouseDown(e:MouseEvent):void
		{
			if (content) 
			{
				last = new Point(mouseX, mouseY);
				plus = new Point(contentX, contentY);
				aimp.x = contentX;
				aimp.y = contentY;
				aimScale = contentScale;
				Tweener.removeTweens(this);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP  , mouseUp);
			}
		}
		
		/**
		 * @private
		 */
		private function mouseMove(e:MouseEvent):void
		{
			var mouse:Point = new Point(mouseX, mouseY);
			if (!gesturing && Point.distance(last, mouse) > 5)
			{
				aimp.x = mouseX - last.x + plus.x;
				aimp.y = mouseY - last.y + plus.y;
				restrictXY();
				updateTween();
			}
		}
		
		/**
		 * @private
		 */
		private function mouseUp(e:MouseEvent):void
		{
			restrictXY();
			updateTween();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		/**
		 * @private
		 */
		private function mouseWheel(e:MouseEvent):void
		{
			if (!gesturing && content)
			{
				aimScale *= e.delta > 0 ? 1.05 : .95;
				restrictScale(mouseX, mouseY);
				updateTween();
			}
		}
		
		/**
		 * @private
		 */
		private function gestureBegin(e:GestureEvent):void
		{
			gesture.addEventListener(GestureEvent.GESTURE_CHANGED, gestureChanged);
			gesture.addEventListener(GestureEvent.GESTURE_POSSIBLE, gesturePossible);
		}
		
		/**
		 * @private
		 */
		private function gesturePossible(e:GestureEvent):void
		{
			gesture.removeEventListener(GestureEvent.GESTURE_CHANGED, gestureChanged);
			gesture.removeEventListener(GestureEvent.GESTURE_POSSIBLE, gesturePossible);
			gesturing = false;
		}
		
		/**
		 * @private
		 */
		private function gestureChanged(e:GestureEvent):void
		{
			if (e.newState.gestouch_internal::isEndState)
			{
				gesture.removeEventListener(GestureEvent.GESTURE_CHANGED, gestureChanged);
				gesture.removeEventListener(GestureEvent.GESTURE_POSSIBLE, gesturePossible);
				gesturing = false;
			}
			else
			{
				if (gesture.touchesCount == 2)
				{
					if(!gesturing)
					{
						gesturing = true;
					}
					else
					{
						aimScale *= gesture.scale;
						gestureCenter = globalToLocal(gesture.location);
						restrictScale(gestureCenter.x, gestureCenter.y);
						updateTween();
					}
				}
				else
				{
					if (gesturing) gesturing = false;
				}
			}
		}
		
		
		/**
		 * 
		 * 是否显示网格。
		 * 
		 */
		
		public function get showGrid():Boolean
		{
			return mp::showGrid as Boolean;
		}
		
		/**
		 * @private
		 */
		public function set showGrid($value:Boolean):void
		{
			mp::showGrid = $value;
		}
		
		
		/**
		 * 
		 * 最小缩放
		 * 
		 */
		
		public function get minScale():Number
		{
			return mp::minScale;
		}
		
		/**
		 * @private
		 */
		public function set minScale(value:Number):void
		{
			mp::minScale = Math.min(value, maxScale);
		}
		
		
		/**
		 * 
		 * 最大缩放
		 * 
		 */
		
		public function get maxScale():Number
		{
			return mp::maxScale;
		}
		
		/**
		 * @private
		 */
		public function set maxScale(value:Number):void
		{
			mp::maxScale = Math.max(value, minScale);
		}
		
		
		/**
		 * 
		 * 内容
		 * 
		 */
		
		public function get content():IVisualElement
		{
			return mp::content;
		}
		
		/**
		 * @private
		 */
		public function set content(value:IVisualElement):void
		{
			lastContent = content;
			mp::content = value;
			
			updateContent();
		}
		
		
		/**
		 * 
		 * 内容缩放
		 * 
		 */
		
		public function get contentScale():Number
		{
			return mp::contentScale;
		}
		
		/**
		 * @private
		 */
		public function set contentScale($value:Number):void
		{
			mp::contentScale = $value;
			
			updateContentScale();
		}
		
		
		/**
		 * 
		 * 内容X坐标
		 * 
		 */
		
		public function get contentX():Number
		{
			return mp::contentX;
		}
		
		/**
		 * @private
		 */
		public function set contentX(value:Number):void
		{
			mp::contentX = value;
			
			updateContentX();
		}
		
		
		/**
		 * 
		 * 内容Y坐标
		 * 
		 */
		
		public function get contentY():Number
		{
			return mp::contentY;
		}
		
		/**
		 * @private
		 */
		public function set contentY(value:Number):void
		{
			mp::contentY = value;
			
			updateContentY();
		}
		
		
		/**
		 * 
		 * 内容原始宽度
		 * 
		 */
		
		public function get originWidth():Number
		{
			return content ? content.width : 0;
		}
		
		
		/**
		 * 
		 * 内容原始高度
		 * 
		 */
		
		public function get originHeight():Number
		{
			return content ? content.height : 0;
		}
		
		
		/**
		 * 
		 * 内容缩放后宽度
		 * 
		 */
		
		public function get scaledWidth():Number
		{
			return originWidth * aimScale;
		}
		
		
		/**
		 * 
		 * 内容缩放后高度
		 * 
		 */
		
		public function get scaledHeight():Number
		{
			return originHeight * aimScale;
		}
		
		
		/**
		 * @private
		 */
		private function get cenX():Number
		{
			return (width * .5 - contentX) / contentScale;
		}
		
		/**
		 * @private
		 */
		private function get cenY():Number
		{
			return (height * .5 - contentY) / contentScale;
		}
		
		/**
		 * @private
		 */
		private function get minX():Number
		{
			return width - scaledWidth;
		}
		
		/**
		 * @private
		 */
		private function get maxX():Number
		{
			return 0;
		}
		
		/**
		 * @private
		 */
		private function get minY():Number
		{
			return height - scaledHeight;
		}
		
		/**
		 * @private
		 */
		private function get maxY():Number
		{
			return 0;
		}
		
		
		/**
		 * 
		 * 重置时移动至的X坐标
		 * 
		 */
		
		public var resetScale:Number = 1;
		
		
		/**
		 * 
		 * 重置时移动至的X坐标
		 * 
		 */
		
		public var resetX:Number = 0;
		
		
		/**
		 * 
		 * 重置时移动至的Y坐标
		 * 
		 */
		
		public var resetY:Number = 0;
		
		
		//------------------------------------------------------------
		// 当前移动或缩放时移动的目标值
		//当前移动或缩放时缩放的目标值，该值在计算坐标限制时有效
		//------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var aimp:Point = new Point;
		
		/**
		 * @private
		 */
		private var aimScale:Number;
		
		
		//------------------------------------------------------------
		// 鼠标移动使用的临时变量
		// 鼠标按下时容器的mouseX mouseY
		//鼠标按下时this的mouseX mouseY
		//------------------------------------------------------------
		
		
		/**
		 * @private
		 */
		private var plus:Point;
		
		/**
		 * @private
		 */
		private var last:Point;
		
		
		
		//------------------------------------------------------------
		//手势控制临时变量
		//------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var gesturing:Boolean;
		
		/**
		 * @private
		 */
		private var lastScale:Number;
		
		/**
		 * @private
		 */
		private var gestureCenter:Point;
		
		
		
		//------------------------------------------------------------
		// 上一次的宽高
		//------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var lastWidth:Number;
		
		/**
		 * @private
		 */
		private var lastHeight:Number;
		
		
		//------------------------------------------------------------
		//其他变量
		//------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var container:Group;
		
		/**
		 * @private
		 */
		private var lastContent:IVisualElement;
		
		
		/**
		 * @private
		 */
		private var back:UIComponent;
		
		/**
		 * @private
		 */
		private var cover:UIComponent;
		
		/**
		 * @private
		 */
		private var gesture:TransformGesture;
		
		
		/**
		 * @private
		 */
		mp var content:IVisualElement;
		
		/**
		 * @private
		 */
		mp var minScale:Number = 1;
		
		/**
		 * @private
		 */
		mp var maxScale:Number = 1;
		
		/**
		 * @private
		 */
		mp var contentScale:Number = 1;
		
		/**
		 * @private
		 */
		mp var contentX:Number = 0;
		
		/**
		 * @private
		 */
		mp var contentY:Number = 0;
		
		/**
		 * @private
		 */
		mp var showGrid:Boolean = true;
		
	}
}