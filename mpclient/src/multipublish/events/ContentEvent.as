package multipublish.events
{
	import flash.events.Event;
	
	public final class ContentEvent extends Event
	{
		
		public static const UPDATE:String = "update";
		
		
		public function ContentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}