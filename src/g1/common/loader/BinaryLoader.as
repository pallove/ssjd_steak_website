package g1.common.loader
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import g1.common.debug.Log;
	
	
	/**
	 * 		@author leon.liu
	 * 		创建时间：	2012-2-28
	 *
	 *		
	 */
	
	public class BinaryLoader extends EventDispatcher
	{
		private var urlLoader : URLLoader;
		
		public function BinaryLoader()
		{
			super();
			
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, __error);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, __progress);
			urlLoader.addEventListener(Event.COMPLETE, __complete);
		}
		
		private function __error(event:IOErrorEvent) : void
		{
			dispatchEvent(event.clone());
			Log.error(event.text, this);
		}
		
		private function __progress(event:ProgressEvent) : void
		{
			dispatchEvent(event.clone());
		}	
		
		final public function load(url:URLRequest) : void
		{
			urlLoader.load(url);
		}		
		
		protected function __complete(event:Event) : void
		{
			dispatchEvent(event.clone());
		}		
		
		final public function getContent() : *
		{
			return urlLoader.data;
		}		
	}
}