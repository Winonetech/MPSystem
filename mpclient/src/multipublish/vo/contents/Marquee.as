package multipublish.vo.contents
{
	
	/**
	 * 
	 * 跑马灯格式。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	
	import multipublish.core.mp;
	
	
	public final class Marquee extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Marquee($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			mp::content = StringUtil.replace(getProperty("contentSource"), "\n", " ");
		}
		
		
		/**
		 * 
		 * 滚动次数。
		 * 
		 */
		
		public function get rollingTimes():uint
		{
			return getProperty("rollingTimes", uint);
		}
		
		
		/**
		 * 
		 * 滚动速度。
		 * 
		 */
		
		public function get rollingSpeed():uint
		{
			return getProperty("rollingSpeed", uint);
		}
		
		
		/**
		 * 
		 * 字体颜色。
		 * 
		 */
		
		public function get fontColor():uint
		{
			return getProperty("fontColor", uint);
		}
		
		
		/**
		 * 
		 * 是否为静止。
		 * 
		 */
		
		public function get isStatic():Boolean
		{
			return getProperty("isStatic", Boolean)
		}
		
		
		/**
		 * 
		 * 播放时长，只在静止时可用。
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