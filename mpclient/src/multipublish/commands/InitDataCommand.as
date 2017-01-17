package multipublish.commands
{
	
	/**
	 * 
	 * 初始化数据。
	 * 
	 */
	
	import cn.vision.utils.ArrayUtil;
	import cn.vision.utils.ObjectUtil;
	
	import com.winonetech.core.VO;
	
	import flash.events.Event;
	
	import multipublish.core.MDProvider;
	import multipublish.core.mp;
	import multipublish.managers.ButtonManager;
	import multipublish.proxy.AsynVOProxy;
	import multipublish.utils.ContentUtil;
	import multipublish.utils.ViewUtil;
	import multipublish.vo.contents.Button;
	import multipublish.vo.contents.Content;
	import multipublish.vo.contents.EPaper;
	import multipublish.vo.contents.Gallary;
	import multipublish.vo.contents.Marquee;
	import multipublish.vo.contents.News;
	import multipublish.vo.programs.*;
	import multipublish.vo.schedules.Schedule;
	
	
	public final class InitDataCommand extends _InternalCommand
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function InitDataCommand()
		{
			super();
			
			initProxy();
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			initData();
			
			controlEnd()
		}
		
		
		/**
		 * 
		 * 结束命令控制。
		 *  
		 */
		
		private function controlEnd(e:Event = null):void
		{
			if (proxy.allowed)
			{
				proxy.removeEventListener(Event.COMPLETE, controlEnd);
				proxy = null;
				commandEnd();
			}
		}
		
		
		/**
		 * @private
		 */
		private function initProxy():void
		{
			proxy = new AsynVOProxy;
			
			proxy.addEventListener(Event.COMPLETE, controlEnd);
		}
		
		
		/**
		 * @private
		 */
		private function initData():void
		{
			if (config.replacable)
			{
				if (!config.view.main.data)    //如果有排期内容则不显示 guild。
					ViewUtil.guild(true);
				
				modelog("初始化排期，下载文件。");
				
				ButtonManager.clear();
				
				provider.ePaperMap.clear();
				
				initSchedule(config.raw["channel"]);
				
				//随机延时30秒内的时间，避免同时访问服务端FTP造成的服务端压力过大
                //TimerUtil.callLater(Math.random() * 180000, Cache.start);
				//Cache.start();
			}
		}
		
		
		/**
		 * @private
		 */
		private function initSchedule(datChannel:*):void
		{
			provider.schedulesMap.clear();
			
			for each (var datSchedule:Object in datChannel)
			{
				var rawSchedule:Object = ObjectUtil.clone(datSchedule);
				delete rawSchedule.program;
				var schedule:Schedule = new Schedule(rawSchedule);
				provider.schedulesMap[schedule.id] = schedule;
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
				var program:Program = new Program(rawProgram);
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
				var layout:Layout = new Layout(rawLayout);
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
				var ad:AD = new AD(rawAD);
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
					var page:Page = new Page(datPage);
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
				var component:Component = new Component(rawComponent);
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
			var voRef  :Class = ContentUtil.getModuleVO(program.moduleType);
			var viewRef:Class = ContentUtil.getModuleView(program.moduleType, program.noticeType); 
			for each (var tempContent:Object in dataContent)
			{
				var tempData:Object = ObjectUtil.clone(tempContent);
				var content:Content = new voRef(tempData);
				program.mp::addContent(content, viewRef);
			}
		}
		
		
		/**
		 * @private
		 */
		private function initContents(datContents:*, component:Component, layout:Layout):void
		{
			for each (var datContent:Object in datContents)
			{
				var rawContent:Object = ObjectUtil.clone(datContent);
				var content:Content = ContentUtil.getContentVO(rawContent);
				
				
				if (content is Button || content is Marquee)
				{
					content.pageID = component.linkID;
					if (content is Button) ArrayUtil.push(layout.buttons, content);
				}
				else if (content is News)
				{
					(content as News).noImage = component.noImage;   
					proxy.registVO(content as VO);
				}
				else if (content is Gallary)
				{
					proxy.registVO(content as VO);
				}
				else if (content is EPaper)
				{
					var temp:EPaper = content as EPaper;
					provider.ePaperMap[temp.content] = temp;
				}
				
				component.mp::addContent(content);
			}
		}
		
		/**
		 * @private
		 */
		private function initButtons(layout:Layout):void
		{
			//设定按钮与页面的关联，当页面播放时，该按钮自动设为选中状态
			for each (var button:Button in layout.buttons)
				ButtonManager.setPageButtonRelation(button, layout.pagesTol[button.pageID]);
			
			layout.buttons = null;
		}
		
		/**
		 * @private
		 */
		private var proxy:AsynVOProxy;
		
		/**
		 * @private
		 */
		private var provider:MDProvider = MDProvider.instance;
		
	}
}