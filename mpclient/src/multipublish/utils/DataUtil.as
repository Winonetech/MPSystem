package multipublish.utils
{
	
	
	import cn.vision.core.NoInstance;
	import cn.vision.utils.StringUtil;
	
	import multipublish.core.MPCConfig;
	
	
	public final class DataUtil extends NoInstance
	{
		
		/**
		 * 
		 * 获取配置文件XML字符串。
		 * 
		 */
		
		public static function getConfig():String
		{
			var e:String = StringUtil.lineEnding;
			return '' + 
				'<?xml version="1.0" encoding="utf-8"?>' + e + 
				'<config version="' + config.version + '">' + e + 
				e + 
				'<!--' + e + 
				'\t配置文件，包含以下部分：' + e + 
				'\t\t1. 终端配置，存储公司ID，设备编号，终端编号；' + e + 
				'\t\t2. HTTP服务，存储HTTP服务的IP地址和端口号；' + e + 
				'\t\t3. SOCKET通讯，存储IP地址，端口号，心跳间隔，等待推送时间；' + e + 
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
				'\t<companyID>'    + config.companyID     + '</companyID>'    + e + 
				'\t<!-- 设备编号 -->' + e + 
				'\t<deviceNO>'     + config.deviceNO      + '</deviceNO>'     + e + 
				'\t<!-- 终端编号 -->' + e + 
				'\t<terminalNO>'   + config.terminalNO    + '</terminalNO>'   + e + 
				'\t<!-- 自动关机指令 -->' + e + 
				'\t<shutdown>'     + config.shutdown      + '</shutdown>'     + e + 
				e + 
				'\t<!-- 网络协议 -->' + e + 
				e + 
				'\t<!-- HTTP主机IP -->' + e + 
				'\t<httpHost>' + config.httpHost       + '</httpHost>' + e + 
				'\t<!-- HTTP主机端口 -->' + e + 
				'\t<httpPort>' +(config.httpPort || 80)+ '</httpPort>' + e + 
				e + 
				'\t<!-- SOCKET -->' + e + 
				e + 
				'\t<!-- SOCKET主机IP -->' + e + 
				'\t<socketHost>'    + config.socketHost            + '</socketHost>'    + e + 
				'\t<!-- SOCKET主机端口 -->' + e + 
				'\t<messagePort>'   +(config.messagePort   || 6666)+ '</messagePort>'   + e + 
				'\t<!-- SOCKET截图端口 -->' + e + 
				'\t<capturePort>'   +(config.capturePort   || 6668)+ '</capturePort>'   + e + 
				'\t<!-- SOCKET心跳间隔时长 -->' + e + 
				'\t<heatbeatTime>'  +(config.heartbeatTime || 30  )+ '</heatbeatTime>'  + e + 
				'\t<!-- SOCKET等待推送时长 -->' + e + 
				'\t<pushWaitTime>'  +(config.pushwaitTime  ||  5  )+ '</pushWaitTime>'  + e + 
				'\t<!-- SOCKET断开后重连时长 -->' + e + 
				'\t<reconnectTime>' +(config.reconnectTime || 60  )+ '</reconnectTime>' + e + 
				e + 
				'\t<!-- FTP服务 -->' + e + 
				e + 
				'\t<!-- FTP主机IP -->' + e + 
				'\t<ftpHost>'     + config.ftpHost       + '</ftpHost>'     + e + 
				'\t<!-- FTP主机端口 -->' + e + 
				'\t<ftpPort>'     +(config.ftpPort || 21)+ '</ftpPort>'     + e + 
				'\t<!-- FTP用户名 -->' + e + 
				'\t<ftpUserName>' + config.ftpUserName   + '</ftpUserName>' + e + 
				'\t<!-- FTP密码 -->' + e + 
				'\t<ftpPassWord>' + config.ftpPassWord   + '</ftpPassWord>' + e + 
				e + 
				'\t<!-- 其他 -->' + e + 
				e + 
				'\t<!-- 技术支持 -->' + e + 
				'\t<support>'         + config.support                 + '</support>'         + e + 
				'\t<!-- 欢迎语 -->' + e + 
				'\t<welcome>'         + config.welcome                 + '</welcome>'         + e + 
				'\t<!-- 网络无应答超时时长 -->' + e + 
				'\t<netTimeoutTime>'  +(config.netTimeoutTime  || 10  )+ '</netTimeoutTime>'  + e + 
				'\t<!-- 最大节目时长 -->' + e + 
				'\t<maxDurationTime>' +(config.maxDurationTime || 7200)+ '</maxDurationTime>' + e + 
				'\t<!-- 节目左右切换缓动时长 -->' + e + 
				'\t<slideTweenTime>'  +(config.slideTweenTime  || 1.5 )+ '</slideTweenTime>'  + e + 
				'\t<!-- 进入或返回缩放缓动时长 -->' + e + 
				'\t<zoomTweenTime>'   +(config.zoomTweenTime   || 1   )+ '</zoomTweenTime>'   + e + 
				e + 
				'</config>';
		}
		
		
		/**
		 * @private
		 */
		private static function get config():MPCConfig
		{
			return MPCConfig.instance;
		}
		
	}
}