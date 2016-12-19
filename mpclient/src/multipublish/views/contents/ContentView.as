package multipublish.views.contents
{
	
	/**
	 * 
	 * 内容视图基类。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.tools.LogSQLite;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import multipublish.consts.EventConsts;
	import multipublish.consts.MPTipConsts;
	import multipublish.consts.TypeConsts;
	import multipublish.views.MPView;
	import multipublish.vo.contents.Content;
	
	import mx.core.IVisualElement;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.graphics.SolidColor;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.Image;
	import spark.primitives.Rect;
	
	
	public class ContentView extends MPView
	{
		
		/**
		 * 
		 * <code>ContentViev</code>构造函数。
		 * 
		 */
		
		public function ContentView()
		{
			super();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			if (content)
			{
				LogSQLite.log(TypeConsts.FILE,
					EventConsts.EVENT_START_PLAYING, content.title,
					log(MPTipConsts.RECORD_CONTENT_PLAY, content));
			}
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			content = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			log(MPTipConsts.RECORD_CONTENT_DATA, data);
			
			content = data as Content;
			
			updateBackground();
		}
		
		
		/**
		 * 
		 * 创建timer处理
		 * 
		 */
		
		protected function createTimer($delay:uint, $repeat:uint = 0, $timer:Function = null, $complete:Function = null, $start:Boolean = true):void
		{
			if(!timer && $delay && ($timer!= null || $complete!= null))
			{
				timer = new Timer($delay * 1000, $repeat);
				if ($timer!= null)
				{
					timerHandler = $timer;
					timer.addEventListener(TimerEvent.TIMER, timerHandler);
				}
				if ($repeat && $complete!= null)
				{
					timerCompleteHandler = $complete;
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
				}
				if ($start) timer.start();
			}
		}
		
		
		/**
		 * 
		 * 重置timer
		 * 
		 */
		
		protected function resetTimer():void
		{
			if (timer) timer.reset();
		}
		
		
		/**
		 * 
		 * 移除timer处理
		 * 
		 */
		
		protected function removeTimer():void
		{
			if (timer)
			{
				if (timerHandler!= null)
				{
					timer.removeEventListener(TimerEvent.TIMER, timerHandler);
					timerHandler = null;
				}
				
				if (timerCompleteHandler!== null)
				{
					timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
					timerCompleteHandler = null;
				}
				timer.stop();
				timer = null;
			}
		}
		
		
		protected function updateModuleBackground($source:String):void
		{
			if (StringUtil.isEmpty($source)) return;
			
			var component:IVisualElement, rect:Rect, image:Image;
			
			if(!background)
			{
				addElementAt(background = new BorderContainer, 0);
				background.mouseEnabled = background.mouseChildren = false;
				background.percentHeight = 100;
				background.percentWidth  = 100;
			}
			
			background.removeAllElements();
			
			component = image = new Image;
			image.percentHeight = 100;
			image.percentWidth  = 100;
			image.fillMode = BitmapFillMode.SCALE;
			image.scaleMode = BitmapScaleMode.ZOOM;
			image.source = $source;
			background.addElement(image);
			
			background.addElement(component);
		}
		
		
		
		/**
		 * 
		 * 更新背景
		 * 
		 */
		
		protected function updateBackground():void
		{
			if (content)
			{
				var component:IVisualElement, rect:Rect, image:Image;
				
				if(!background)
				{
					addElementAt(background = new BorderContainer, 0);
					background.mouseEnabled = background.mouseChildren = false;
					background.percentHeight = 100;
					background.percentWidth  = 100;
				}
				
				background.alpha = content.backgroundAlpha;
				background.removeAllElements();
				if (StringUtil.isEmpty(content.background))
				{
					component = rect = new Rect;
					rect.percentHeight = 100;
					rect.percentWidth  = 100;
					rect.fill = new SolidColor(content.backgroundColor);
				}
				else
				{
					component = image = new Image;
					image.percentHeight = 100;
					image.percentWidth  = 100;
					image.fillMode = BitmapFillMode.SCALE;
					image.scaleMode = BitmapScaleMode.ZOOM;
					image.source = content.background;
					background.addElement(image);
				}
				
				background.addElement(component);
			}
		}
		
		
		/**
		 * @private
		 */
		[Bindable]
		protected var content:Content;
		
		
		/**
		 * @private
		 */
		private var background:BorderContainer;
//		private var background:Group;
		
		/**
		 * @private
		 */
		private var timer:Timer;
		
		/**
		 * @private
		 */
		private var timerHandler:Function;
		
		/**
		 * @private
		 */
		private var timerCompleteHandler:Function;
		
	}
}