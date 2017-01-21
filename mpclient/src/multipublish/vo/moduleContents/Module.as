package multipublish.vo.moduleContents
{
	import com.winonetech.core.VO;
	
	import multipublish.core.mp;
	import multipublish.vo.contents.Content;
	
	public final class Module extends VO
	{
		public function Module(
			$data:Object = null, 
			$name:String = "content", 
			$useWait:Boolean = true,
			$cacheGroup:String = null)
		{
			super($data, $name, $useWait, $cacheGroup);
			
			mp::moduleContent = new Vector.<Content>;
		}
		
		public function get moduleContent():Vector.<Content>
		{
			return mp::moduleContent;
		}
		
		public var moduleClass:Class;
		
		mp var moduleContent:Vector.<Content>;
	}
}