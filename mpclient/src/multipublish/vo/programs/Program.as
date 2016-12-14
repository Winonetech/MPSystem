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
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	
	public final class Program extends VO
	{
		
		/**
		 * 
		 * <code>Program</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Program($data:Object = null)
		{
			super($data);
			
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
			return getProperty("height", Number);
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
			return getProperty("width", Number);
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
		
		mp function addContent($content:Content):void
		{
			if ($content && moduleContents.indexOf($content) == -1)
			{
				ArrayUtil.push(moduleContents, $content);
			}
		}
		
		
		/**
		 * 
		 * 内容集合。
		 * 
		 */
		
		public function get moduleContents():Vector.<Content>
		{
			return mp::moduleContents;
		}
		
		/**
		 * @private
		 */
		mp var layouts:Map;
		
		/**
		 * @private
		 */
		mp var moduleContents:Vector.<Content> = new Vector.<Content>;
		
		/**
		 * 
		 * 布局引用。
		 * 
		 */
		
		public var layout:Layout;
		
	}
}