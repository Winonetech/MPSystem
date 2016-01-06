package multipublish.views
{
	
	/**
	 * 
	 * 主界面视图。
	 * 
	 */
	
	
	import caurina.transitions.Tweener;
	
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.core.MPCView;
	import multipublish.core.mp;
	import multipublish.vo.programs.Program;
	import multipublish.vo.schedules.Schedule;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	import spark.components.WindowedApplication;
	
	
	public final class MainView extends MPView
	{
		
		/**
		 * 
		 * <code>MainViev</code>构造函数。
		 * 
		 */
		
		public function MainView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * 
		 * 自适应父容器尺寸。
		 * 
		 */
		
		public function autofitScale($view:ProgramView):void
		{
			if ($view) $view.autofitScale();
		}
		
		
		/**
		 * 
		 * 播放某一类型的节目，选取最靠近当前节目的一个，
		 * 如果当前正在播放的节目是该类型，则不切换。
		 * 
		 */
		
		public function playbackProgram($type:String):void
		{
			if (view)
			{
				
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			LogSQLite.log(
				TypeConsts.FILE,
				EventConsts.EVENT_START_PLAYING, schedule.summary,
				log(MPTipConsts.RECORD_SCHEDULE_PLAY, schedule));
			
			if (view)
			{
				view.addEventListener(ControlEvent.STOP, handlerEnd);
				view.play();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processStop():void
		{
			if (view)
			{
				view.removeEventListener(ControlEvent.STOP, handlerEnd);
				view.stop();
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			removeAllElements();
			view = next = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			log(MPTipConsts.RECORD_SCHEDULE_DATA, data);
			
			schedule = data as Schedule;
			
			if(!view)
			{
				view = generateView();
				next = generateNext();
				play();
			}
			else
			{
				if (next)
				{
					if (containsElement(next))
						removeElement(next);
				}
				next = generateView();
				next.visible = false;
				delay(1, tween);
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function updateDisplayList($unscaledWidth:Number, $unscaledHeight:Number):void
		{
			super.updateDisplayList($unscaledWidth, $unscaledHeight);
			if (lastWidth != $unscaledWidth && 
				lastHeight!= $unscaledHeight)
			{
				lastWidth  = $unscaledWidth;
				lastHeight = $unscaledHeight;
				graphics.clear();
				graphics.beginFill(0xFFFFFF);
				graphics.drawRect(0, 0, $unscaledWidth, $unscaledHeight);
				graphics.endFill();
				drawCover();
			}
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			verticalCenter = horizontalCenter = 0;
			var handlerAddedToStage:Function = function($e:Event):void
			{
				removeEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
				autofitScale(view);
			}
			addEventListener(Event.ADDED_TO_STAGE, handlerAddedToStage);
			application.addEventListener(ResizeEvent.RESIZE, handlerResize);
		}
		
		/**
		 * @private
		 */
		private function generateView():ProgramView
		{
			var program:Program = schedule.programs[index];
			var result:ProgramView = new ProgramView;
			result.width  = application.width;
			result.height = application.height;
			result.data = program;
			addElementAt(result, 0);
			neigh = index;
			return result;
		}
		
		/**
		 * @private
		 */
		private function generateNext():ProgramView
		{
			var l:uint = schedule.programs.length;
			neigh ++;
			if (neigh != index)
			{
				var program:Program = schedule.programs[neigh];
				var result:ProgramView = new ProgramView;
				result.width   = application.width;
				result.height  = application.height;
				result.data    = program;
				result.visible = false;
				addElementAt(result, 0);
				index = neigh;
			}
			if(!result && neigh != index) result = generateNext();
			return result;
		}
		
		/**
		 * @private
		 */
		private function tween():void
		{
			if (view && next)
			{
				view.stop();
				next.x = width;
				next.visible = true;
				Tweener.addTween(view, {x:-width, time:config.slideTweenTime,
					onComplete:callbackTweenOver});
				Tweener.addTween(next, {x:0, time:config.slideTweenTime});
			}
			else
			{
				stop();
			}
		}
		
		/**
		 * @private
		 */
		private function createCover():void
		{
			if(!cover)
			{
				cover = new UIComponent;
				addElement(cover);
			}
			drawCover();
		}
		
		/**
		 * @private
		 */
		private function drawCover():void
		{
			if (cover && width && height)
			{
				cover.graphics.clear();
				cover.graphics.beginFill(0xFFFFFF, .5);
				cover.graphics.drawRect(0, 0, width, height);
				cover.graphics.endFill();
			}
		}
		
		/**
		 * @private
		 */
		private function removeCover():void
		{
			if (cover)
			{
				containsElement(cover) && removeElement(cover);
				cover = null;
			}
		}
		
		/**
		 * @private
		 */
		private function delay($time:Number, $handler:Function, ...$args):void
		{
			if(!timer)
			{
				timer = new Timer($time * 1000);
				timer.addEventListener(TimerEvent.TIMER, handlerTimer);
			}
			handler = {handler:$handler, args:$args};
			timer.reset();
			timer.start();
		}
		
		
		/**
		 * @private
		 */
		private function callbackTweenOver():void
		{
			removeElement(view);
			view.reset();
			view = next;
			next = generateNext();
			view.play();
		}
		
		
		/**
		 * @private
		 */
		private function handlerResize($e:ResizeEvent):void
		{
			autofitScale(view);
		}
		
		/**
		 * @private
		 */
		private function handlerEnd($e:ControlEvent):void
		{
			view.removeEventListener(ControlEvent.STOP, handlerEnd);
			tween();
		}
		
		/**
		 * @private
		 */
		private function handlerTimer($e:TimerEvent):void
		{
			if (handler && handler.handler)
				handler.handler.apply(null, handler.args);
			timer.removeEventListener(TimerEvent.TIMER, handlerTimer);
			timer.stop();
			timer = null;
		}
		
		/**
		 * 
		 * 设定是否可交互。
		 * 不可交互状态下会有一层白色半透明蒙版。
		 * 
		 */
		
		override public function get enabled():Boolean
		{
			return Boolean(mp::enabled);
		}
		
		/**
		 * @private
		 */
		override public function set enabled($value:Boolean):void
		{
			if ($value != mp::enabled)
			{
				mp::enabled = $value;
				enabled ? removeCover() : createCover();
			}
		}
		
		
		/**
		 * @private
		 */
		private function get application():WindowedApplication
		{
			return MPCView.instance.application;
		}
		
		/**
		 * @private
		 */
		private function get index():uint
		{
			return schedule ? schedule.index : 0;
		}
		
		/**
		 * @private
		 */
		private function set index($value:uint):void
		{
			schedule.index = $value;
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
			var l:uint = schedule ? schedule.programs.length : 0;
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
		private var lastHeight:Number;
		
		/**
		 * @private
		 */
		private var lastWidth:Number;
		
		/**
		 * @private
		 */
		private var containerHeight:Number;
		
		/**
		 * @private
		 */
		private var containerWidth:Number;
		
		/**
		 * @private
		 */
		private var next:ProgramView;
		
		/**
		 * @private
		 */
		private var view:ProgramView;
		
		/**
		 * @private
		 */
		private var last:ProgramView;
		
		/**
		 * @private
		 */
		private var schedule:Schedule;
		
		/**
		 * @private
		 */
		private var cover:UIComponent;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var handler:Object;
		
		
		/**
		 * @private
		 */
		mp var enabled:Boolean;
		
		/**
		 * @private
		 */
		mp var neigh:int;
		
	}
}