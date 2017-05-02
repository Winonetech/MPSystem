package multipublish.tools
{
	
	/**
	 * 
	 * 报纸图片处理工具。
	 * 
	 */
	
	
	import cn.vision.collections.Map;
	import cn.vision.core.Command;
	import cn.vision.system.VSFile;
	import cn.vision.utils.BitmapUtil;
	import cn.vision.utils.FileUtil;
	import cn.vision.utils.LogUtil;
	import cn.vision.utils.StringUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
	public final class ImageCompare extends Command
	{
		
		/**
		 * 
		 * 构造函数。
		 * 
		 */
		
		public function ImageCompare($imageObj:Object)
		{
			super();
			
			imageObj = $imageObj.images;
			sheetObj = $imageObj.sheet;
			path = sheetObj.path;
		}
		
		
		/**
		 * @inheritDoc
		 */
		
		override public function execute():void
		{
			commandStart();
			
			loaders = new Map;
			thumb = checkThumb();
			if(!thumb)
			{
				//缩略图路径不存在，需要获取最大的图片，并创建一张缩略图
				count = 0;
				LogUtil.log("处理报纸图片：", path);
				var dispatch:Boolean = true;
				for each (var item:* in imageObj)
				{
					count ++;
					dispatch = false;
					createLoader(item, function(loader:ImageLoader):void
					{
						loaders[loader.url] = loader;
						if (loaders.length >= count)
						{
							const max:ImageLoader = compare();
							const bitmap:Bitmap = max.content as Bitmap;
							if (bitmap)
							{
								var bmd:BitmapData = bitmap.bitmapData;
								sheetObj.width  = bmd.width;
								sheetObj.height = bmd.height;
								sheetObj.image  = max.url;
								
								if (true)
								{
									const s:Number = 420 / bmd.height;
									const h:Number = 420;
									const w:Number = bmd.width * s;
									const m:Matrix = new Matrix;
									m.scale(s, s);
									
									thumb = BitmapUtil.draw(bmd, w, h, false, true, 0xFFFFFF, m, null, null, null);
									
									sheetObj.thumb = thumb;
									
									const file:VSFile = new VSFile(FileUtil.resolvePathApplication(getThumb(max.url)));
									const bytes:ByteArray = BitmapUtil.encodeJPG(thumb);
									const stream:FileStream = new FileStream;
									stream.open(file, FileMode.WRITE);
									stream.writeBytes(bytes, 0, bytes.bytesAvailable);
									stream.close();
									
									commandEnd();
								}
								else
								{
									//create thumb for max
									const thread:ScaleBmdMultiThread = ScaleBmdMultiThread.instance;
									const threadHandler:Function = function(e:Event):void
									{
										thread.removeEventListener(Event.COMPLETE, threadHandler);
										thread.removeEventListener(IOErrorEvent.IO_ERROR, threadHandler);
										thumb = thread.bitmapData;
										sheetObj.thumb = thumb;
										
										trace(thread.bitmapData.transparent)
										
										const file:VSFile = new VSFile(FileUtil.resolvePathApplication(getThumb(max.url)));
										const bytes:ByteArray = BitmapUtil.encodeJPG(thumb);
										const stream:FileStream = new FileStream;
										stream.open(file, FileMode.WRITE);
										stream.writeBytes(bytes, 0, bytes.bytesAvailable);
										stream.close();
										
										commandEnd();
									};
									thread.addEventListener(Event.COMPLETE, threadHandler);
									thread.addEventListener(IOErrorEvent.IO_ERROR, threadHandler);
									thread.process(bmd, 420 / sheetObj.height);
								}
							}
							else
							{
								commandEnd();
							}
						}
					});
				}
				if (dispatch) commandEnd();
			}
			else
			{
				sheetObj.thumb = thumb;
				sheetObj.image = StringUtil.replace(thumb, "thumb_", "");
				createLoader(sheetObj.image, function(loader:ImageLoader):void
				{
					if (loader.content)
					{
						sheetObj.width  = loader.content.width;
						sheetObj.height = loader.content.height;
					}
					else
					{
						LogUtil.log(loader.content, "解析报纸版面图片出错，路径不存在！");
					}
					commandEnd();
				});
			}
			
		}
		
		
		/**
		 * 创建一个图片加载器。
		 * @private
		 */
		private function createLoader($url:String, $handler:Function):void
		{
			var loader:ImageLoader = new ImageLoader;
			var defaultHandler:Function = function(e:Event):void
			{
				var loader:ImageLoader = e.target.loader as ImageLoader;
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, defaultHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
				if (loader.handler!= null)
				{
					loader.handler(loader);
					loader.handler = null;
				}
			};
			loader.handler = $handler;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, defaultHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, defaultHandler);
			loader.load(new URLRequest($url));
		}
		
		
		/**
		 * 检查是否有缩略图的路径，如果有，返回。
		 * @private
		 */
		private function checkThumb():String
		{
			for each (var item:* in imageObj)
				if (item.indexOf("thumb_") != -1) return item;
			return null;
		}
		
		/**
		 * 获取缩略图路径
		 * @private
		 */
		private function getThumb(url:String):String
		{
			var temp:Array = url.split("/");
			temp[temp.length - 1] = "thumb_" + temp[temp.length - 1];
			return temp.join("/");
		}
		
		/**
		 * 比较所有图片的大小，取最大的一张为主版面。
		 * @private
		 */
		private function compare():ImageLoader
		{
			var max:ImageLoader;
			for each (var loader:ImageLoader in loaders)
			{
				if (max)
				{
					if (max.width  < loader.width || 
						max.height < loader.height) max = loader;
				}
				else
				{
					max = loader;
				}
			}
			return max;
		}
		
		
		/**
		 * 
		 * 图片文件夹路径。
		 * 
		 */
		
		public var path:String;
		
		/**
		 * @private
		 */
		private var thumb:*;
		
		/**
		 * @private
		 */
		private var loaders:Map;
		
		/**
		 * @private
		 */
		private var sheetObj:Object;
		
		/**
		 * @private
		 */
		private var imageObj:Object;
		
		/**
		 * @private
		 */
		private var count:int;
		
		/**
		 * @private
		 */
		private var extension:String;
		
	}
}


/**
 * 
 * 图片加载器。
 * 
 */

import flash.display.Loader;
import flash.net.URLRequest;
import flash.system.LoaderContext;


class ImageLoader extends Loader
{
	
	/**
	 * @inheritDoc
	 */
	
	override public function load($request:URLRequest, $context:LoaderContext = null):void
	{
		request = $request;
		
		super.load(request, $context);
	}
	
	
	/**
	 * 
	 * 加载路径。
	 * 
	 */
	
	public function get url():String
	{
		return request ? request.url : null;
	}
	
	
	/**
	 * 
	 * 处理函数。
	 * 
	 */
	
	public var handler:Function;
	
	
	/**
	 * @private
	 */
	private var request:URLRequest;
	
}