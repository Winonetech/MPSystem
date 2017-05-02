package multipublish.vo
{
	import cn.vision.events.CommandEvent;
	
	import com.winonetech.core.VO;
	import com.winonetech.core.wt;
	import com.winonetech.events.ControlEvent;
	import com.winonetech.tools.Cache;
	
	use namespace wt;
	
	public class MPVO extends VO
	{
		public function MPVO($data:Object = null, $name:String = "vo", $useWait:Boolean = true, $cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
		}
		
		override wt function registCache(...$args):void
		{
			for each (var item:* in $args)
			{
				var cache:Cache = (item is String) ? Cache.cache(item, !useWait, cacheGroup) : item;
				if (!useWait && cache && ! cach[cache.saveURL] && !cache.exist)
				{
					var handler:Function = function($e:CommandEvent):void
					{
						var cache:Cache = Cache($e.command);
						cache.removeEventListener(CommandEvent.COMMAND_END, handler);
						
						delete cach[cache.saveURL];
						
						dispatchReady();
					};
					cache.addEventListener(CommandEvent.COMMAND_END, handler);
					cach[cache.saveURL] = cache;
				}
			}
			
			if (cach.length) dispatchEvent(new ControlEvent(ControlEvent.DOWNLOAD));  //当有需要下载的文件时，发送下载命令。
		}
		
	}
}