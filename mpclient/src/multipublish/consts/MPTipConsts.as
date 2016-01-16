package multipublish.consts
{
	
	/**
	 * 
	 * 定义所有的系统提示常量。
	 * 
	 */
	
	
	import cn.vision.core.NoInstance;
	import cn.vision.data.Tip;
	import cn.vision.utils.StringUtil;
	
	
	public final class MPTipConsts extends NoInstance
	{
		
		/**
		 * 
		 * 无法连接服务端。
		 * 
		 */
		
		public static const ERROR_CN_SERVER_CONNECT:Tip = new Tip("连接远程服务器出错，请检查网络连接，远程服务器IP，端口号是否有误，服务端是否开启！", 0);
		
		
		/**
		 * 
		 * 获取终端编号数据出错。
		 * 
		 */
		
		public static const ERROR_CN_TERMINAL_GET_NO:Tip = new Tip("获取终端编号出错，请检查网络连接，IP设置是否有误，服务端是否开启！", 0);
		
		
		/**
		 * 
		 * 无法连接服务端。
		 * 
		 */
		
		public static const ERROR_EN_SERVER_CONNECT:Tip = new Tip("Error occured when connecting to remote server, please check your network setting!", 0);
		
		
		/**
		 * 
		 * 获取终端编号数据出错。
		 * 
		 */
		
		public static const ERROR_EN_TERMINAL_GET_NO:Tip = new Tip("Error occured when request terminal NO. Perhaps the server error, please contact the staff!", 0);
		
		
		/**
		 * 
		 * 加载服务端文件夹数据出错。
		 * 
		 */
		
		public static const NOTICE_COVER_UNEXIST:Tip = new Tip("封面图片不存在：{source}", 1);
		
		
		/**
		 * 
		 * Socket重连提示。
		 * 
		 */
		
		public static const NOTICE_SOCKET_CONNECT:Tip = new Tip("Socket正在重新连接！", 1);
		
		
		/**
		 * 
		 * 相关文件缓存完毕记录。
		 * 
		 */
		
		public static const RECORD_CACHE_COMP:Tip = new Tip("{className}+<{id}> 文件缓存完毕。", 2);
		
		
		/**
		 * 
		 * 缓存文件记录。
		 * 
		 */
		
		public static const RECORD_CACHE_FILE:Tip = new Tip("缓存文件：{saveURL}, {loadURL}。", 2);
		
		
		/**
		 * 
		 * 需要缓存的相关文件记录。
		 * 
		 */
		
		public static const RECORD_CACHE_NEED:Tip = new Tip("{className}<{id}>有{numFiles}个相关文件需要加载。", 2);
		
		
		/**
		 * 
		 *保存文件记录。
		 * 
		 */
		
		public static const RECORD_CACHE_SAVE:Tip = new Tip("保存文件：{$self}", 2);
		
		
		/**
		 * 
		 * 超过等待时长，使用缓存。
		 * 
		 */
		
		public static const RECORD_CACHE_USE:Tip = new Tip("{repeatCount} 秒内未接受到推送，使用缓存数据。", 2);
		
		
		/**
		 * 
		 * 启用缓存等待推送。
		 * 
		 */
		
		public static const RECORD_CACHE_WAIT:Tip = new Tip("注册等待使用缓存时间：{$self}秒。", 2);
		
		
		/**
		 * 
		 * 上报文件加载进度
		 * 
		 */
		
		public static const RECORD_CACHE_REPORT:Tip = new Tip("上报进度：{$self}", 2);
		
		
		/**
		 * 
		 * 加载数据记录。
		 * 
		 */
		
		public static const RECORD_DATA_LOAD:Tip = new Tip("加载数据：{url}", 2);
		
		
		/**
		 * 
		 * 打开设置面板记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_SHOTCUT:Tip = new Tip("截图。", 2);
		
		
		/**
		 * 
		 * 打开设置面板记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_DEPLOY:Tip = new Tip("打开设置面板。", 2);
		
		
		/**
		 * 
		 * 重启终端记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_REBOOT:Tip = new Tip("重启终端。", 2);
		
		
		/**
		 * 
		 * 重启播放器记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_RESTART:Tip = new Tip("重启播放器。", 2);
		
		
		/**
		 * 
		 * 关闭终端记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_SHUTDOWN:Tip = new Tip("关闭终端。", 2);
		
		
		/**
		 * 
		 * 执行时间同步记录。
		 * 
		 */
		
		public static const RECORD_COMMAND_LOCKTIME:Tip = new Tip("执行时间同步", 2);
		
		
		/**
		 * 
		 * 开始更新数据。
		 * 
		 */
		
		public static const RECORD_DATA_UPDATE:Tip = new Tip("更新数据");
		
		
		/**
		 * 
		 * 加载服务端排期数据出错。
		 * 
		 */
		
		public static const RECORD_LOAD_FAILURE_SCHEDULE:Tip = new Tip("加载服务端排期数据出错，排期不存在！", 1);
		
		
		/**
		 * 
		 * 加载服务端节目数据出错。
		 * 
		 */
		
		public static const RECORD_LOAD_FAILURE_PROGRAM:Tip = new Tip("加载服务端节目数据出错，请检查网络连接或与相关工作人员联系！", 1);
		
		
		/**
		 * 
		 * 加载服务端节目数据出错。
		 * 
		 */
		
		public static const RECORD_LOAD_FAILURE_TYPESET:Tip = new Tip("加载服务端布局数据出错，请检查网络连接或与相关工作人员联系！", 1);
		
		
		/**
		 * 
		 * 加载服务端文件夹数据出错。
		 * 
		 */
		
		public static const RECORD_LOAD_FAILURE_DOCUMENT:Tip = new Tip("加载文件夹数据出错：ID={id}", 1);
		
		
		/**
		 * 
		 * 注册快捷键记录。
		 * 
		 */
		
		public static const RECORD_KEYBOARD_REG:Tip = new Tip("注册快捷键。", 2);
		
		
		/**
		 * 
		 * 设定布局记录。
		 * 
		 */
		
		public static const RECORD_CONTENT_PLAY:Tip = new Tip("播放内容：{content}", 2);
		
		
		/**
		 * 
		 * 设定布局记录。
		 * 
		 */
		
		public static const RECORD_DOCUMENT_PLAY:Tip = new Tip("播放文档：{path}", 2);
		
		
		/**
		 * 
		 * 设定布局记录。
		 * 
		 */
		
		public static const RECORD_LAYOUT_DATA:Tip = new Tip("设定布局：{x}, {y}, {width}, {height}", 2);
		
		
		/**
		 * 
		 * 播放产品相关节目。
		 * 
		 */
		
		public static const RECORD_PROGRAM_TYPE_PUSH:Tip = new Tip("推送节目类型：{$self}", 2);
		
		
		/**
		 * 
		 * 播放产品相关节目。
		 * 
		 */
		
		public static const RECORD_PROGRAM_TYPE_PLAY:Tip = new Tip("播放节目类型：{$self}", 2);
		
		
		/**
		 * 
		 * 设定节目记录。
		 * 
		 */
		
		public static const RECORD_PROGRAM_DATA:Tip = new Tip("设定节目：{summary}", 2);
		
		
		/**
		 * 
		 * 播放节目记录。
		 * 
		 */
		
		public static const RECORD_PROGRAM_PLAY:Tip = new Tip("播放节目：{summary}", 2);
		
		
		/**
		 * 
		 * 设定排期记录。
		 * 
		 */
		
		public static const RECORD_SCHEDULE_DATA:Tip = new Tip("设定排期：{summary}", 2);
		
		
		/**
		 * 
		 * 播放排期记录。
		 * 
		 */
		
		public static const RECORD_SCHEDULE_PLAY:Tip = new Tip("播放排期：{summary}", 2);
		
		
		/**
		 * 
		 * 收到推送记录。
		 * 
		 */
		
		public static const RECORD_SOCKET_DATA:Tip = new Tip("收到消息：{$self}", 2);
		
		
		/**
		 * 
		 * 发送终端上线记录。
		 * 
		 */
		
		public static const RECORD_SOCKET_ONLINE:Tip = new Tip("发送终端上线", 2);
		
		
		/**
		 * 
		 * 发送终端下线记录。
		 * 
		 */
		
		public static const RECORD_SOCKET_OFFLINE:Tip = new Tip("发送终端下线", 2);
		
		
		/**
		 * 
		 * 收到推送记录。
		 * 
		 */
		
		public static const RECORD_SOCKET_HEARTBEAT:Tip = new Tip("发送心跳：{$self}", 2);
		
		
		/**
		 * 
		 * 排版返回上一页记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_BACK:Tip = new Tip("返回上页：{id}", 2);
		
		
		/**
		 * 
		 * 排版返回首页记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_HOME:Tip = new Tip("返回首页：{id}", 2);
		
		
		/**
		 * 
		 * 排版打开子页记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_VIEW:Tip = new Tip("打开子页：{id}", 2);
		
		
		/**
		 * 
		 * 设定排版记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_DATA:Tip = new Tip("设定排版：{id}", 2);
		
		
		/**
		 * 
		 * 开始播放广告记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_PLAY_AD:Tip = new Tip("开始播放广告：{id}", 2);
		
		
		/**
		 * 
		 * 停止播放广告记录。
		 * 
		 */
		
		public static const RECORD_TYPESET_STOP_AD:Tip = new Tip("停止播放广告。", 2);
		
		
		/**
		 * 
		 * 加载网页完毕记录。
		 * 
		 */
		
		public static const RECORD_WEBSITE_COMP:Tip = new Tip("加载页面完毕：{location}。", 2);
		
		
		/**
		 * 
		 * 开始加载网页记录。
		 * 
		 */
		
		public static const RECORD_WEBSITE_OPEN:Tip = new Tip("开始加载页面：{location}。", 2);
		
		
		/**
		 * 
		 * 日志文件上传成功记录。
		 * 
		 */
		
		public static const RECORD_LOG_UPLOAD:Tip = new Tip("开始日志文件上传。", 2);
		
		
		/**
		 * 
		 * 日志文件上传成功记录。
		 * 
		 */
		
		public static const RECORD_LOG_UPLOAD_SUCCESS:Tip = new Tip("日志文件上传成功。", 2);
		
		
		/**
		 * 
		 * 日志文件上传失败记录。
		 * 
		 */
		
		public static const RECORD_LOG_UPLOAD_FAILURE:Tip = new Tip("日志文件上传失败，{$self}", 2);
		
		
		/**
		 * 
		 * 调整音量记录。
		 * 
		 */
		
		public static const RECORD_ADJUST_VOL:Tip = new Tip("调整音量。", 2);
		
	}
}