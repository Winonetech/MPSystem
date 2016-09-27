package multipublish.vo.contents
{
	
	/**
	 * 
	 * 跑马灯格式。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import com.winonetech.utils.ConvertUtil;
	
	import multipublish.core.mp;
	
	
	[Bindable]
	public final class HText extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function HText($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			mp::content = StringUtil.replace(getProperty("contents"), "</p>", "</p><p></p>");
		}
		
		
		/**
		 * 
		 * 字体颜色。
		 * 
		 */
		
		public function get textColor():uint
		{
			return getProperty("textColor", uint);
		}
		
		
		/**
		 * 
		 * 内容时长，秒。
		 * 
		 */
		
		public function get duration():uint
		{
			return getProperty("timeLength", uint);
		}
		
		
		/**
		 * 
		 * 文本。
		 * 
		 */
		
		public function get content():String
		{
			return mp::content;
		}
		
		
		/**
		 * @private
		 */
		mp var content:String;
		
	}
}