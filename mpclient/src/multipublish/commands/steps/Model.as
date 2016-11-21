package multipublish.commands.steps
{
	
	/**
	 * 
	 * 读取并保存排期。
	 * 数据加载命令，加载完毕后储存在store缓存。
	 * 
	 */
	
	import cn.vision.events.TimeoutEvent;
	import cn.vision.net.URILoader;
	import cn.vision.utils.LogUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import multipublish.commands.Step;
	import multipublish.consts.MPTipConsts;
	import multipublish.core.mp;
	
	
	public final class Model extends Step
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 * @param $url:String 加载的路径。
		 * @param $type:Class 存储类型。
		 * 
		 */
		
		public function Model($url:String = null, $type:Class = null)
		{
			super();
			
			initialize($url, $type);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			load();
		}
		
		
		/**
		 * @private
		 */
		private function initialize($url:String, $type:Class):void
		{
			url  = $url;
			type = $type;
		}
		
		/**
		 * @private
		 */
		private function load():void
		{
			LogUtil.logTip(MPTipConsts.RECORD_DATA_LOAD, this);
			
			mp::data = null;
			
			if(!loader)
			{
				loader = new URILoader;
				loader.timeout = config.netTimeoutTime;
				loader.addEventListener(Event.COMPLETE, defaultHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, defaultHandler);
				loader.addEventListener(TimeoutEvent.TIMEOUT, defaultHandler);
			}
			loader.load(new URLRequest(url));
		}
		
		
		/**
		 * @private
		 */
		private function defaultHandler($e:Event):void
		{
			if (loader)
			{
				loader.removeEventListener(Event.COMPLETE, defaultHandler);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, defaultHandler);
				loader.removeEventListener(TimeoutEvent.TIMEOUT, defaultHandler);
				loader.close();
				loader = null;
			}
			if($e.type == Event.COMPLETE)
			{
				mp::data = $e.target.data;   //url传输的资源。
				
				if (type) store.registRaw(data, type);  
			}
			else
			{
				LogUtil.log("加载数据出错：" + url);
			}
			commandEnd();
		}
		
		
		/**
		 * 
		 * 已加载的数据。
		 * 
		 */
		
		public function get data():Object
		{
			return mp::data;
		}
		
		
		/**
		 * 
		 * ID索引。
		 * 
		 */
		
		public function get extra():Object
		{
			return (mp::extra) || (mp::extra = {});
		}
		
		
		/**
		 * 
		 * 存储的类型。
		 * 
		 */
		
		public var type:Class;
		
		
		/**
		 * 
		 * 加载的路径。
		 * 
		 */
		
		public var url:String;
		
		
		/*
		 * @private
		 */
		private var loader:URILoader;
		
		
		/**
		 * @private
		 */
		mp var data:Object;
		
		/**
		 * @private
		 */
		mp var extra:Object;
		
	}
}