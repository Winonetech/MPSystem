package multipublish.events
{
	import flash.events.Event;
	
	public final class DLStateEvent extends Event
	{
		public function DLStateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static const FINISH:String = "finish";
	}
}