package multipublish.vo.programs
{
	
	/**
	 * 
	 * 节目数据结构。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.utils.ArrayUtil;
	
	import com.winonetech.core.VO;
	
	import multipublish.core.MPCConfig;
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	import multipublish.vo.moduleContents.Module;
	
	
	public final class Program extends VO
	{
		
		/**
		 * 
		 * <code>Program</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Program(
			$data:Object = null, 
			$name:String = "program", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
			
			initialize();
		}
		
		
		/**
		 * 
		 * 添加一个Layout。
		 * 
		 */
		
		public function addLayout(layout:Layout):void
		{
			layout.program = this;
			
			mp::layouts[layout.id] = layout;
		}
		
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			mp::layouts = new Map;
		}
		
		
		/**
		 * 
		 * 摘要，描述。
		 * 
		 */
		
		public function get summary():String
		{
			return getProperty("title");
		}
		
		
		/**
		 * 
		 * 高度。
		 * 
		 */
		
		public function get height():Number
		{
			var h:Number = getProperty("height", Number);
			return h <= 0 ? config.height : h;
		}
		
		
		/**
		 * 
		 * 布局列表。
		 * 
		 */
		
		public function get layouts():Map
		{
			return mp::layouts;
		}
		
		
		/**
		 * 
		 * 宽度。
		 * 
		 */
		
		public function get width():Number
		{
			var w:Number = getProperty("width", Number);
			return w <= 0 ? config.width : w;
		}
		
		
		/**
		 * 
		 * 模板类型。
		 * 
		 */
		
		public function get moduleType():int
		{
			return getProperty("moduleType", int);
		}
		
		
		/**
		 * 
		 * 通知类型。<br>
		 * 1. 寻人启事。(单张图片)<br>
		 * 2. 欢迎标语。(背景图片)
		 * 
		 */
		
		public function get noticeType():int
		{
			return getProperty("noticeType", int);
		}
		
		/**
		 * 
		 * 添加内容。
		 * 
		 */
		
		mp function addContent($content:Content, $ref:Class):void
		{
			if ($content && module.moduleContent.indexOf($content) == -1)
			{
				ArrayUtil.push(module.moduleContent, $content);
				if (!module.moduleClass) module.moduleClass = $ref;
			}
		}
		
		
		public function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
		/**
		 * 
		 * 内容集合。
		 * 
		 */
		
		public function get module():Module
		{
			return mp::module;
		}
		
		/**
		 * @private
		 */
		mp var layouts:Map;
		
		/**
		 * @private
		 */
		mp var module:Module = new Module;
		
		/**
		 * 
		 * 布局引用。
		 * 
		 */
		
		public var layout:Layout;
		
	}
}