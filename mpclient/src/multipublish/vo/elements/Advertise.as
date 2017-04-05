package multipublish.vo.elements
{
	
	/**
	 * 
	 * 广告元素数据结构。
	 * 
	 */
	
	
	import multipublish.core.mp;
	
	
	public final class Advertise extends Comman
	{
		
		/**
		 * 
		 * <code>Advertise</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据。
		 * 
		 */
		
		public function Advertise($data:Object=null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			//第一次传入数据
			if (data["adenable"] != undefined)
			{
				mp::wait = getProperty("waittime", uint);
				mp::fullscreeen = (getProperty("fullscrmode", uint) == 2);
				mp::x = getProperty("adx", Number);
				mp::y = getProperty("ady", Number);
				mp::w = getProperty("adw", Number);
				mp::h = getProperty("adh", Number);
			}
		}
		
		
		/**
		 * 
		 * 是否全屏。
		 * 
		 */
		
		public function get fullscreen():Boolean
		{
			return mp::fullscreeen as Boolean;
		}
		
		
		/**
		 * 
		 * x。
		 * 
		 */
		
		public function get x():Number
		{
			return mp::x;
		}
		
		
		/**
		 * 
		 * x。
		 * 
		 */
		
		public function get y():Number
		{
			return mp::y;
		}
		
		
		/**
		 * 
		 * x。
		 * 
		 */
		
		public function get w():Number
		{
			return mp::w;
		}
		
		
		/**
		 * 
		 * x。
		 * 
		 */
		
		public function get h():Number
		{
			return mp::h;
		}
		
		
		/**
		 * 
		 * 等待时长。
		 * 
		 */
		
		public function get wait():uint
		{
			return mp::wait;
		}
		
		
		/**
		 * @private
		 */
		mp var x:Number;
		
		/**
		 * @private
		 */
		mp var y:Number;
		
		/**
		 * @private
		 */
		mp var w:Number;
		
		/**
		 * @private
		 */
		mp var h:Number;
		
		/**
		 * @private
		 */
		mp var wait:uint;
		
		/**
		 * @private
		 */
		mp var fullscreeen:Boolean;
		
	}
}