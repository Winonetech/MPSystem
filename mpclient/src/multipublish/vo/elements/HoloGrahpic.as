package multipublish.vo.elements
{
	import com.winonetech.consts.PathConsts;
	import com.winonetech.core.wt;
	import com.winonetech.utils.CacheUtil;
	
	import multipublish.core.mp;
	import multipublish.utils.URLUtil;

	public final class HoloGrahpic extends Element
	{
		public function HoloGrahpic($data:Object = null)
		{
			super($data);
		}
		
		override public function parse($data:Object):void
		{
			super.parse($data);
			
			if (data["folder"])
			{
				resources.length = 0;
				
				var list:* = data["folder"]["item"];
				if (list && list.length)
				{
					for each (var item:* in list)
					{
						var resource:Object = createHoloResource(item);
						resources[resources.length] = resource;
					}
				}
			}
			
		}
		
		private function createHoloResource($data:Object):Object
		{
			if ($data)
			{
				var r:Object = {};
				var remote:String = URLUtil.buildFTP($data.thumbnailpath);
				var local:String = CacheUtil.extractURI(remote, PathConsts.PATH_FILE);
				wt::registCache(remote);
				r.thumb = local;
				remote = URLUtil.buildFTP($data.largePic);
				local = CacheUtil.extractURI(remote, PathConsts.PATH_FILE);
				wt::registCache(remote);
				r.large = local;
				remote = URLUtil.buildFTP($data.video);
				local = CacheUtil.extractURI(remote, PathConsts.PATH_FILE);
				wt::registCache(remote);
				r.video = local;
				r.title = $data.filename;
				r.about = $data.summary;
			}
			return r;
		}
		
		
		public function get resources():Vector.<Object>
		{
			return mp::resources;
		}
		
		
		mp var resources:Vector.<Object> = new Vector.<Object>;
		
		
	}
}