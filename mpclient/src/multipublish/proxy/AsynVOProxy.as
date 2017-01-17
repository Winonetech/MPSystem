package multipublish.proxy
{
	import cn.vision.core.VSEventDispatcher;
	
	import com.winonetech.core.VO;
	
	import flash.events.Event;
	
	import multipublish.core.mp;
	import multipublish.events.DLStateEvent;
	
	
	/**
	 * 
	 * VO异步代理。
	 * 
	 */
	
	public final class AsynVOProxy extends VSEventDispatcher
	{
		
		
		public function AsynVOProxy()
		{
			super();
		}
		
		
		
		/**
		 * 
		 * 注册VO，并监听注册cache完成事件。
		 * 
		 */
		
		public function registVO($vo:VO):void
		{
			var dispatchReady:Function = function($e:DLStateEvent):void
			{
				$e.target.removeEventListener(DLStateEvent.FINISH, dispatchReady);
				
				if (--count <= 0) dispatchEvent(new Event(Event.COMPLETE));
			};
			
			count++;
			
			$vo.addEventListener(DLStateEvent.FINISH, dispatchReady);
		}
		
		
		
		/**
		 * 
		 * 是否允许发送准备命令。
		 * 
		 */
		
		public function get allowed():Boolean
		{
			return count <= 0;
		}
		
		
		
		/**
		 * VO注册个数统计。
		 */
		
		private var count:int;
		
	}
}