package multipublish.vo.documents
{
	
	/**
	 * 
	 * 文档。
	 * 
	 */
	
	
	import cn.vision.consts.FileTypeConsts;
	import cn.vision.utils.FileUtil;
	
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.VO;
	import com.winonetech.core.WO;
	import com.winonetech.core.wt;
	import com.winonetech.tools.Cache;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.consts.DocumentTypeConsts;
	import multipublish.core.mp;
	import multipublish.errors.FileUnExistError;
	import multipublish.errors.VideoUnsupportError;
	
	
	public class Document extends VO
	{
		
		/**
		 * 
		 * <code>Document</code>构造函数。
		 * 
		 * @param $data:Object (default = null) 初始化的数据，可以是XML，JSON格式的数据，或Object。
		 * 
		 */
		
		public function Document($data:Object = null)
		{
			super($data);
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			var url:String = getProperty("filepath");
			if (url.toLowerCase() == "null")
			{
				throw new FileUnExistError(url);
			}
			else
			{
				mp::path = CacheUtil.extractURI(url, PathConsts.PATH_FILE);
				if (type == DocumentTypeConsts.VIDEO)
				{
					var ext:String = FileUtil.getFileTypeByURL(url);
					if (ext != FileTypeConsts.FLV && ext != FileTypeConsts.MP4)
						throw new VideoUnsupportError(ext);
				}
				wt::registCache(url);
				registPath();
			}
		}
		
		
		/**
		 * @private
		 */
		private function registPath():void
		{
			parent && parent.wt::registCache(Cache.gain(path));
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function get id():String
		{
			return vid.toString();
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function set parent($value:WO):void
		{
			super.parent = $value;
			
			registPath();
		}
		
		
		/**
		 * 
		 * 文件地址。
		 * 
		 */
		
		public function get path():String
		{
			return mp::path;
		}
		
		
		/**
		 * 
		 * 文件类型，可以是图片，SWF和视频。
		 * 
		 */
		
		public function get type():uint
		{
			return getProperty("filetype", uint);
		}
		
		
		/**
		 * @private
		 */
		mp var path:String;
		
	}
}