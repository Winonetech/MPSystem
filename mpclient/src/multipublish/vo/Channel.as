package multipublish.vo
{
	
	/**
	 * 
	 * 频道数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.TimerUtil;
	import cn.vision.utils.XMLUtil;
	
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import multipublish.core.mp;
	import multipublish.utils.ContentUtil;
	import multipublish.utils.ModuleUtil;
	import multipublish.vo.contents.Button;
	import multipublish.vo.contents.Content;
	import multipublish.vo.contents.EPaper;
	import multipublish.vo.contents.Marquee;
	import multipublish.vo.contents.News;
	import multipublish.vo.contents.ResolveContent;
	import multipublish.vo.programs.AD;
	import multipublish.vo.programs.Component;
	import multipublish.vo.programs.Layout;
	import multipublish.vo.programs.Page;
	import multipublish.vo.programs.Program;
	import multipublish.vo.programs.Sheet;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class Channel extends VO
	{
		
		/**
		 * 
		 * 构造函数
		 * 
		 */
		
		public function Channel($data:Object = null, $name:String = "channel", $useWait:Boolean = true, $resolveWait:Boolean = false)
		{
			resolveWait = $resolveWait;
			
			super($data, $name, $useWait);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			if ($data)
			{
				wt::raw = $data;
				if ($data is String)
				{
					var src:String = StringUtil.trim(String($data));
					data = XMLUtil.validate(src)
						?  ObjectUtil.convert(XML(src), Object)
						:  JSON.parse(src);
				}
				else if ($data is XML)
				{
					data = ObjectUtil.convert($data, Object);
				}
				else
				{
					data = ObjectUtil.clone($data);
				}
			}
			else data = {};
			
			schedulesMap.clear();
			epapersMap.clear();
			contentsMap.clear();
			clearPageButtonRelation();
			
			cacheGroup = vid.toString();
			
			initSchedule(data);
			
			if (contentsMap.length == 0) TimerUtil.callLater(5, dispatchInit);
		}
		
		
		/**
		 * 
		 * 设定组按钮为选中状态。
		 * 
		 */
		
		public function setButtonSelected($button:Button, $selected:Boolean = true):void
		{
			if ($button && $button.selectable)
			{
				if ($selected)
				{
					var group:Array = buttonGroup[$button.group];
					for each (var item:Button in group) item.selected = false;
				}
				$button.selected = $selected;
			}
		}
		
		
		/**
		 * @private
		 */
		private function initSchedule(datChannel:*):void
		{
			for each (var datSchedule:Object in datChannel)
			{
				var rawSchedule:Object = ObjectUtil.clone(datSchedule);
				delete rawSchedule.program;
				var schedule:Schedule = new Schedule(rawSchedule);
				schedulesMap[schedule.id] = schedule;
				initProgram(datSchedule["program"], schedule);
			}
		}
		
		/**
		 * @private
		 */
		private function initProgram(datProgram:*, schedule:Schedule):void
		{
			if (datProgram)
			{
				var rawProgram:Object = ObjectUtil.clone(datProgram);
				delete rawProgram.layout;
				var program:Program = new Program(rawProgram, "program", useWait, cacheGroup);
				schedule.addProgram(program);
				program.moduleType
					? initModuleContent(datProgram["contents"], program)
					: initLayout(datProgram["layout"], program);
			}
		}
		
		
		/**
		 * @private
		 */
		private function initLayout(datLayout:*, program:Program):void
		{
			if (datLayout)
			{
				var rawLayout:Object = ObjectUtil.clone(datLayout);
				delete rawLayout.ad;
				delete rawLayout.pages;
				var layout:Layout = new Layout(rawLayout, "layout", useWait, cacheGroup);
				program.layout = layout;
				
				initAD   (datLayout["ad"], layout);
				
				initPages(datLayout["pages"], layout);
				
				initButtons(layout);
				
				layout.home = layout.home || layout.pagesArr[0];
			}
		}
		
		/**
		 * @private
		 */
		private function initAD(datAD:*, layout:Layout):void
		{
			if (datAD is Array && datAD.length) datAD = datAD[0];
			if (datAD)
			{
				var rawAD:Object = ObjectUtil.clone(datAD);
				delete rawAD.components;
				var ad:AD = new AD(rawAD, "ad", useWait, cacheGroup);
				layout.ad = ad;
				
				initComponents(datAD["components"], ad, layout);
			}
		}
		
		/**
		 * @private
		 */
		private function initPages(datPage:*, layout:Layout, father:* = null):void
		{
			if (datPage)
			{
				if (datPage is Array)
				{
					if (datPage.length) for each (var item:Object in datPage) initPages(item, layout, father);
				}
				else
				{
					father = father || layout;
					var rawPage:Object = ObjectUtil.clone(datPage);
					delete rawPage.pages;
					delete rawPage.components;
					var page:Page = new Page(datPage, "page", useWait, cacheGroup);
					//provider.sheetsMap[page.id] = page;
					layout.pagesTol[page.id] = page;
					father.mp::addPage(page);     //可能调用的方法：Page & Layout。即子页面和 Children的关系。
					
					initComponents(datPage["components"], page, layout);
					
					initPages     (datPage["pages"], layout, page);   //初始化子页面。
				}
			}
		}
		
		/**
		 * @private
		 */
		private function initComponents(datComponents:*, sheet:Sheet, layout:Layout):void
		{
			for each (var datComponent:Object in datComponents)
			{
				var rawComponent:Object = ObjectUtil.clone(datComponent);
				delete rawComponent.contents;
				var component:Component = new Component(rawComponent, "component", useWait, cacheGroup);
				sheet.mp::addComponent(component);
				
				initContents(datComponent["contents"], component, layout);
			}
			
			sheet.mp::updateComponentsOrder();
		}
		
		/**
		 * @private
		 */
		private function initModuleContent(dataContent:*, program:Program):void
		{
			var voRef  :Class = ModuleUtil.getModuleVO(program.moduleType);
			var viewRef:Class = ModuleUtil.getModuleView(program.moduleType, program.noticeType); 
			for each (var tempContent:Object in dataContent)
			{
				var tempData:Object = ObjectUtil.clone(tempContent);
				var content:Content = new voRef(tempData, "module", useWait, cacheGroup);
				program.mp::addContent(content, viewRef);
			}
		}
		
		
		private function setTimer($function:Function, ...$args):void
		{
			var timer:Timer;
			var tempFunction:Function = function($e:TimerEvent):void
			{
				$function($args[0]);
				timer = null;
			};
			timer = new Timer(33, 1);
			timer.addEventListener(TimerEvent.TIMER, tempFunction);
			timer.start();
		}
		
		/**
		 * @private
		 */
		private function initContents(datContents:*, component:Component, layout:Layout):void
		{
			
//			var createEpaper:Function = function($ep:EPaper):void
//			{
//				if ($ep)
//				{
//					var temp:EPaper = $ep as EPaper;
//					epapersMap[temp.content] = temp;
//				}
//			};
			
			for each (var datContent:Object in datContents)
			{
				var rawContent:Object = ObjectUtil.clone(datContent);
				
				if (rawContent.contentType == "epaper")
				{
					creatingEpapers.push({component:component, content:rawContent});
				}
				else
				{
					var content:Content = ContentUtil.getContentVO(rawContent, useWait, cacheGroup, resolveWait);
					if (content is Button || content is Marquee)
					{
						content.pageID = component.linkID;
						if (content is Button) ArrayUtil.push(layout.buttons, content);
					}
					else if (content is ResolveContent)
					{
						contentsMap[content.vid] = content;
						content.addEventListener(ControlEvent.INIT, content_initHandler);
						if (content is News)
						{
							(content as News).noImage = component.noImage;  
						}
						/*else if (content is EPaper)
						{
							setTimer(createEpaper, content);
						}*/
					}
				}
				
				component.mp::addContent(content);
			}//end of for
			
			if (creatingEpapers.length)
			{
				creatingTimer = new Timer(2000);
				creatingTimer.addEventListener(TimerEvent.TIMER, creatingEpaper_timerHandler);
				creatingTimer.start();
			}
		}
		
		private function creatingEpaper_timerHandler($e:TimerEvent):void
		{
			if (creatingEpapers.length)
			{
				var temp:Object = creatingEpapers.shift();
				//记录一个函数开始运行之前的计时
				var startTime:int = getTimer();
				var epaper:EPaper = ContentUtil.getContentVO(temp.content, useWait, cacheGroup, resolveWait) as EPaper;
				//这里totalTime就是创建EPAPER所消耗的时间，这样可以看出这个函数是否因为耗时太久而造成卡死的现象。
				//如果耗时太久，就需要对其进行优化。
				var totalTime:int = getTimer() - startTime;
				
				trace("========= " + totalTime + " =========");
				
				temp.component.mp::addContent(epaper);
				epapersMap[epaper.content] = epaper;
			}
			else
			{
				if (creatingTimer)
				{
					creatingTimer.stop();
					creatingTimer.removeEventListener(TimerEvent.TIMER, creatingEpaper_timerHandler);
					creatingTimer = null;
				}
			}
		}
		
		/**
		 * @private
		 */
		private function initButtons(layout:Layout):void
		{
			//设定按钮与页面的关联，当页面播放时，该按钮自动设为选中状态
			for each (var button:Button in layout.buttons)
				setPageButtonRelation(button, layout.pagesTol[button.pageID]);
			
			layout.buttons = null;
		}
		
		/**
		 * @private
		 * 设定页面与按钮关联。
		 */
		private function setPageButtonRelation($button:Button, $page:Page):void
		{
			if ($page && $button && $button.selectable)
			{
				if (!$page.button)
				{
					$page.button = $button;
					var group:String = $button.group;
					buttonGroup[group] = buttonGroup[group] || [];
					if (buttonGroup[group].indexOf($button) == -1)
						buttonGroup[group].push($button);
				}
			}
		}
		
		/**
		 * @private
		 * 清除所有页面按钮关联。
		 */
		private function clearPageButtonRelation():void
		{
			buttonGroup = {};
		}
		
		
		/**
		 * @private
		 */
		private function content_initHandler($e:ControlEvent):void
		{
			var content:Content = $e.target as Content;
			content.removeEventListener(ControlEvent.INIT, content_initHandler);
			delete contentsMap[content.vid];
			
			if (contentsMap.length == 0 && creatingEpapers.length == 0) 
			{
				dispatchInit();
				
				dispatchReady();
			}
		}
		
		
		/**
		 * 
		 * 排期字典。
		 * 
		 */
		
		public var schedulesMap:Map = new Map;
		
		
		/**
		 * 
		 * 电子报字典。
		 * 
		 */
		
		public var epapersMap:Map = new Map;
		
		
		/**
		 * @private
		 */
		private var contentsMap:Map = new Map;
		
		/**
		 * @private
		 */
		private var buttonGroup:Object = {};
		
		/**
		 * @private
		 */
		private var resolveWait:Boolean;
		
		/**
		 * @private
		 */
		private var creatingEpapers:Array = [];
		
		/**
		 * @private
		 */
		private var creatingTimer:Timer;
		
	}
}