package multipublish.utils
{
	import cn.vision.core.NoInstance;
	import cn.vision.utils.FileUtil;
	
	import multipublish.consts.DataConsts;
	import multipublish.core.MPCConfig;

	public class BUSUtil extends NoInstance
	{
		private static const config:MPCConfig = MPCConfig.instance;
		
		private static var using:Boolean = false;
		
		/**
		 *
		 * 更新并执行当前播放状态。<br>
		 * 若开启严格模式，状态未变化则不执行对应更新代码。
		 * @param $script(default:true):是否开启严格模式。<br>
		 * 
		 */
		
		public static function updatePlayable($script:Boolean = true):void
		{
			if (!using)
			{
				using = true;
				
				var result:String = FileUtil.readUTF(FileUtil.resolvePathApplication(DataConsts.PAUSE_CFG));
				
				try
				{
					if (result) 
					{
						var playing:Boolean = "true" == result;
						
						(!$script || playing != config.playable) && config.setPlayable(playing);
					} 
					else  //如果文件不存在了 则判定为恢复播放。
					{
						(!$script || config.playable) || config.setPlayable(true);
					}
				} 
				catch(error:Error) {}
				finally
				{
					using = false;
				}
			}
		}
	}
}