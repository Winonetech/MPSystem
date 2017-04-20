package multipublish.utils
{
	
	
	import cn.vision.core.NoInstance;
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.ObjectUtil;
	import cn.vision.utils.StringUtil;
	import cn.vision.utils.XMLUtil;
	
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import multipublish.consts.URLConsts;
	import multipublish.core.MPCConfig;
	
	
	public final class ConfigUtil extends NoInstance
	{
		
		/**
		 * 
		 * 从文件中读取配置信息。
		 * 
		 */
		
		public static function readNativeData():void
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG));
			if (file.exists)
			{
				var reader:FileStream = new FileStream;
				reader.open(file, FileMode.READ);
				var xml:XML = XML(reader.readUTFBytes(reader.bytesAvailable));
				if (xml) 
				{
					XMLUtil.map(xml, config);
					config.language.data = ObjectUtil.convert(xml["languageData"]);
				}
				reader.close();
				reader = null;  //释放内存
			}
			file = null;  //释放内存
		}
		
		
		/**
		 * 
		 * 保存配置信息到文件。
		 * 
		 */
		
		public static function saveNativeData():void
		{
			FileUtil.saveUTF(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG), buildConfigData());
		}
		
		
		/**
		 * 
		 * 根据当前配置生成数据。
		 * 
		 */
		
		public static function buildConfigData():String
		{
			var e:String = StringUtil.lineEnding;
			var config:MPCConfig = MPCConfig.instance;
			return '' + 
				'<?xml version="1.0" encoding="utf-8"?>' + e + 
				'<config>' + e + 
				e + 
				'<!--' + e + 
				'\t配置文件，包含以下部分：' + e + 
				'\t\t1. 终端配置，存储公司ID，设备编号，终端编号等；' + e + 
				'\t\t2. HTTP服务，存储HTTP服务的IP地址和端口号；' + e + 
				'\t\t3. 心跳，存储心跳间隔，等待推送时间，断开后连接时长；' + e + 
				'\t\t4. FTP服务，存储FTP文件服务的IP地址，端口号，用户名和密码；' + e + 
				'\t\t5. 其他，存储宽高，最大节目播放时长，加载超时时长。' + e + 
				'-->' + e + 
				e + 
				e + 
				'\t<!-- 终端配置 -->' + e + 
				e + 
				'\t<!-- 语言 -->' + e + 
				'\t<languageData>' + config.language.data + '</languageData>' + e + 
				'\t<!-- 公司ID -->' + e + 
				'\t<companyID>' + config.companyID + '</companyID>' + e + 
				'\t<!-- 设备编号 -->' + e + 
				'\t<deviceNO>' + config.deviceNO + '</deviceNO>' + e + 
				'\t<!-- 终端编号 -->' + e + 
				'\t<terminalNO>' + config.terminalNO + '</terminalNO>' + e + 
				'\t<!-- 自动关机指令 -->' + e + 
				'\t<shutdown>' + config.shutdown + '</shutdown>' + e + 
				'\t<!-- 截图策略指令 -->' + e + 
				'\t<shotcut>' + config.shotcut + '</shotcut>' + e + 
				getDebug() + e + 
				getDownloadState() + e + 
				getLastVersion() + e + 
				getRemote() + e + 
				getSled() + e + 
				e + 
				'\t<!-- 网络协议 -->' + e + 
				e + 
				'\t<!-- HTTP主机IP -->' + e + 
				'\t<httpHost>' + config.httpHost + '</httpHost>' + e + 
				'\t<!-- HTTP主机端口 -->' + e + 
				'\t<httpPort>' +(config.httpPort || 80)+ '</httpPort>' + e + 
				'\t<!-- 终端申请地址 -->' + e + 
				'\t<requestTem>' + config.requestTem + '</requestTem>' + e + 
				'\t<!-- 通讯地址 -->' + e + 
				'\t<serviceURL>' + config.serviceURL + '</serviceURL>' + e + 
				'\t<!-- 截图上传地址 -->' + e + 
				'\t<shotcutURL>' + config.shotcutURL + '</shotcutURL>' + e + 
				'\t<!-- 终端升级端口 -->' + e + 
				'\t<updtPort>' + config.updtPort + '</updtPort>' + e + 
				'\t<!-- 终端升级地址 -->' + e + 
				'\t<updateURL>'+ config.updateURL + '</updateURL>' + e + 
				e + 
				'\t<!-- 心跳 -->' + e + 
				e + 
				'\t<!-- 心跳间隔时长 -->' + e + 
				'\t<heatbeatTime>' +(config.heartbeatTime || 30)+ '</heatbeatTime>' + e + 
				'\t<!-- 等待推送时长 -->' + e + 
				'\t<pushWaitTime>' +(config.pushwaitTime || 5)+ '</pushWaitTime>' + e + 
				'\t<!-- 断开后重连时长 -->' + e + 
				'\t<reconnectTime>' +(config.reconnectTime || 60)+ '</reconnectTime>' + e + 
				e + 
				'\t<!-- FTP服务 -->' + e + 
				e + 
				'\t<!-- FTP主机IP -->' + e + 
				'\t<ftpHost>' + config.ftpHost + '</ftpHost>' + e + 
				'\t<!-- FTP主机端口 -->' + e + 
				'\t<ftpPort>' +(config.ftpPort || 21)+ '</ftpPort>' + e + 
				'\t<!-- FTP用户名 -->' + e + 
				'\t<ftpUserName>' + config.ftpUserName + '</ftpUserName>' + e + 
				'\t<!-- FTP密码 -->' + e + 
				'\t<ftpPassWord>' + config.ftpPassWord + '</ftpPassWord>' + e + 
				e + 
				'\t<!-- 其他 -->' + e + 
				e + 
				'\t<!-- 技术支持 -->' + e + 
				'\t<support>' + config.support + '</support>' + e + 
				'\t<!-- 欢迎语 -->' + e + 
				'\t<welcome>' + config.welcome + '</welcome>' + e + 
				'\t<!-- 网络无应答超时时长 -->' + e + 
				'\t<netTimeoutTime>' +(config.netTimeoutTime || 10)+ '</netTimeoutTime>' + e + 
				'\t<!-- 最大节目时长 -->' + e + 
				'\t<maxDurationTime>' +(config.maxDurationTime || 7200)+ '</maxDurationTime>' + e + 
				'\t<!-- 节目左右切换缓动时长 -->' + e + 
				'\t<slideTweenTime>' +(config.slideTweenTime || 1.5)+ '</slideTweenTime>' + e + 
				'\t<!-- 进入或返回缩放缓动时长 -->' + e + 
				'\t<zoomTweenTime>' +(config.zoomTweenTime || 1)+ '</zoomTweenTime>' + e + 
				e + 
				'</config>';
		}
		
		/**
		 * @private
		 */
		private static function getDownloadState():String
		{
			var e:String = StringUtil.lineEnding;
			var config:MPCConfig = MPCConfig.instance;
			var result:String = "";
			result += '\t<!-- 下载状态栏 -->' + e;
			result += '\t<downloadState>' + config.downloadState + '</downloadState>' + e;
			return result;
		}
		
		/**
		 * @private
		 */
		private static function getLastVersion():String
		{
			var e:String = StringUtil.lineEnding;
			var result:String = "";
			if (config.lastVersion)
			{
				result += '\t<!-- 上一版本 -->' + e;
				result += '\t<lastVersion>' + config.lastVersion + '</lastVersion>' + e;
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private static function getDebug():String
		{
			var e:String = StringUtil.lineEnding;
			var result:String = "";
			result += '\t<!-- 调试模式 -->' + e;
			result += '\t<debug>' + config.debug + '</debug>' + e;
			return result;
		}
		
		/**
		 * @private
		 */
		private static function getRemote():String
		{
			var e:String = StringUtil.lineEnding;
			var result:String = "";
			if (config.remoteVersion)
			{
				result += '\t<!-- 服务端版本 -->' + e;
				result += '\t<remoteVersion>' + config.remoteVersion + '</remoteVersion>' + e;
			}
			return result;
		}
		
		/**
		 * @private
		 */
		private static function getSled():String
		{
			var e:String = StringUtil.lineEnding;
			var config:MPCConfig = MPCConfig.instance;
			var result:String = "";
			if (config.sled)
			{
				result += '\t<!-- 跑马灯 -->' + e;
				result += '\t<sled>' + config.sled + '</sled>' + e;
			}
			return result;
		}
		
		
		/**
		 * 
		 * 检测是否有备份。
		 * 
		 */
		
		public static function hasBackup():Boolean
		{
			var file:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.BACKUP_CONFIG));
			return file.exists;
		}
		
		
		/**
		 * 
		 * config文件备份。
		 * 
		 */
		
		public static function backupConfig():void
		{
			var source:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG));
			var backup:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.BACKUP_CONFIG));
			if (source.exists)
			{
				try
				{
					source.copyTo(backup, true);
				}
				catch (e:Error)
				{
					LogUtil.log(e.message);
				}
			}
			else
				LogUtil.log("config.ini文件不存在...");
		}
		
		
		/**
		 * 
		 * config文件还原。
		 * 
		 */
		
		public static function restoreConfig():void
		{
			var source:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.NATIVE_CONFIG));
			var backup:VSFile = new VSFile(FileUtil.resolvePathApplication(URLConsts.BACKUP_CONFIG));
			if (backup.exists)
			{
				try
				{
					backup.copyTo(source, true);
				}
				catch (e:Error)
				{
					LogUtil.log(e.message);
				}
			}
			else
				LogUtil.log("备份文件不存在...");
		}
		
		
		/**
		 * @private
		 */
		private static var config:MPCConfig = MPCConfig.instance;
		
	}
}