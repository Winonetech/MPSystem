package multipublish.errors
{
	import cn.vision.core.VSError;
	
	public final class VideoUnsupportError extends VSError
	{
		public function VideoUnsupportError($ext:String = null)
		{
			super("不支持的视频格式" + ($ext ? "：" + $ext : "") + "！");
		}
	}
}