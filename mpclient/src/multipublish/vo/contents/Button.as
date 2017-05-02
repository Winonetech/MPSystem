package multipublish.vo.contents
{
	
	/**
	 * 
	 * FLASH动画格式。
	 * 
	 */
	
	
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.TimerUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	
	
	[Bindable]
	public final class Button extends Content
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Button(
			$data:Object = null, 
			$name:String = "button", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override protected function customParse():void
		{
			if(!transparent)
			{
				var sourceUp:String = getProperty("sourceUp");
				wt::registCache(sourceUp);
				mp::sourceUp = CacheUtil.extractURI(sourceUp  , PathConsts.PATH_FILE);
				
				var sourceDown:String = getProperty("sourceDown");
				wt::registCache(sourceDown);
				mp::sourceDown = CacheUtil.extractURI(sourceDown  , PathConsts.PATH_FILE);
			}
		}
		
		
		/**
		 * 
		 * 按钮所在组。
		 * 
		 */
		
		public function get group():String
		{
			return getProperty("group");
		}
		
		
		/**
		 * 
		 * 按钮是否为透明。
		 * 
		 */
		
		public function get transparent():Boolean
		{
			return getProperty("transparent", Boolean);
		}
		
		
		/**
		 * 
		 * 弹起时图片地址。
		 * 
		 */
		
		public function get sourceUp():String
		{
			return mp::sourceUp;
		}
		
		
		/**
		 * 
		 * 按下时图片地址。
		 * 
		 */
		
		public function get sourceDown():String
		{
			return mp::sourceDown;
		}
		
		
		/**
		 * 
		 * 能否被选中。
		 * 
		 */
		
		public function get selectable():Boolean
		{
			return !StringUtil.empty(group);
		}
		
		
		/**
		 * 
		 * 是否选中。
		 * 
		 */
		
		public function get selected():Boolean
		{
			return mp::selected as Boolean;
		}
		
		/**
		 * @private
		 */
		public function set selected($value:Boolean):void
		{
			if (selectable && selected!= $value)
			{
				mp::selected = $value;
			}
		}
		
		
		/**
		 * @private
		 */
		mp var sourceUp:String;
		
		/**
		 * @private
		 */
		mp var sourceDown:String;
		
		/**
		 * @private
		 */
		mp var selected:Boolean;
		
	}
}