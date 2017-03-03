package multipublish.views
{
	
	/**
	 * 
	 * 版面视图
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.events.ControlEvent;
	
	import multipublish.consts.MPTipConsts;
	import multipublish.vo.programs.Component;
	import multipublish.vo.programs.Sheet;
	
	import mx.core.IVisualElement;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.primitives.Rect;
	
	
	public class SheetView extends MPView
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function SheetView()
		{
			super();
			
			initializeEnvironment();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processPlay():void
		{
			log(MPTipConsts.RECORD_SHEET_PLAY, data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function processReset():void
		{
			container.removeAllElements();
			removeElement(container);
			if (containsElement(background))
				removeElement(background);
			background = null;
			container = null;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function resolveData():void
		{
			sheet = data as Sheet;
			
			log(MPTipConsts.RECORD_SHEET_DATA, data);
			
			updateBackground();
			
			if (sheet.componentsArr.length)
			{
				readyCount = 0;
				
				//update children
				for each (var child:Component in sheet.componentsArr)
				{
					var component:ComponentView = new ComponentView;
					
					component.addEventListener(ControlEvent.READY, handlerReady, false, 0, true);
					
					componentsDic[child.id] = component;
					
					component.x = child.x;
					component.y = child.y;
					component.width  = child.w;
					component.height = child.h;
					
					registView(component);
					
					container.addElement(component);
				}
				
				for each (child in sheet.componentsArr) 
				{
					componentsDic[child.id].data = child;
				}
			}
			else
			{
				dispatchReady();
			}
		}
		
		
		/**
		 * @private
		 */
		private function initializeEnvironment():void
		{
			mouseEnabled = false;
			
			addElement(container);
		}
		
		
		/**
		 * 
		 * 更新背景
		 * 
		 */
		
		protected function updateBackground():void
		{
			if (sheet)
			{
				var component:IVisualElement, rect:Rect, image:Image;
				
				if(!background)
				{
					addElementAt(background = new Group, 0);
					background.percentHeight = 100;
					background.percentWidth  = 100;
				}
				
				background.alpha = sheet.backgroundAlpha;
				background.removeAllElements();
				if (StringUtil.isEmpty(sheet.background))
				{
					component = rect = new Rect;
					rect.percentHeight = 100;
					rect.percentWidth  = 100;
					rect.fill = new SolidColor(sheet.backgroundColor);
				}
				else
				{
					component = image = new Image;
					image.percentHeight = 100;
					image.percentWidth  = 100;
					image.fillMode = BitmapFillMode.SCALE;
					image.scaleMode = BitmapScaleMode.ZOOM;
					image.source = sheet.background;
					background.addElement(image);
				}
				
				background.addElement(component);
			}
		}
		
		/**
		 * @private
		 */
		private function handlerReady($e:ControlEvent):void
		{
			var temp:ComponentView = $e.target as ComponentView;
			if (temp)
			{
				temp.removeEventListener(ControlEvent.READY, handlerReady);
				if (++readyCount >= sheet.componentsArr.length) 
				{
					dispatchReady();
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private var sheet:Sheet;
		
		/**
		 * @private
		 */
		private var componentsDic:Object = {};
		
		/**
		 * @private
		 */
		private var readyCount:uint;
		
		/**
		 * @private
		 */
		private var background:Group;
		
		/**
		 * @private
		 */
		private var container:Group = new Group;
		
	}
}