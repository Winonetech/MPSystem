package multipublish.vo.contents
{
	
	/**
	 * 
	 * 主排版数据。
	 * 
	 */
	
	
	import multipublish.core.mp;
	import multipublish.vo.elements.Arrange;
	
	
	public final class Typeset extends Content
	{
		
		/**
		 * 
		 * <code>Typeset</code>构造函数。
		 * 
		 */
		
		public function Typeset($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @private
		 */
		private function resolveID():String
		{
			var arr:Array = content.split("=");
			return content.split("=").pop();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function get id():String
		{
			return mp::id || (mp::id = resolveID());
		}
		
		
		/**
		 * 
		 * 排版元素。
		 * 
		 */
		
		public function get arrange():Arrange
		{
			return mp::arrange;
		}
		
		/**
		 * @private
		 */
		public function set arrange($value:Arrange):void
		{
			mp::arrange = $value;
		}
		
		
		/**
		 * @private
		 */
		mp var arrange:Arrange;
		
		/**
		 * @private
		 */
		mp var id:String;
		
	}
}