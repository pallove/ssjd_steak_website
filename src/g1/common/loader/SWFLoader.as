package g1.common.loader
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import g1.common.debug.Log;
	
	public class SWFLoader extends EventDispatcher
	{
		protected var urlLoader:URLLoader;
		protected var context:LoaderContext;
		protected var swfLoader:Loader;
		protected var loadUrl : String;
		
		public function SWFLoader()
		{
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, __error);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, __progress);
			urlLoader.addEventListener(Event.COMPLETE, __dataLoaded);
		}
		
		final public function getContent() : DisplayObject
		{
			return swfLoader.content;
		}
		
		protected function loadBytes(data:ByteArray, context:LoaderContext) : void
		{
			this.context = context;
			swfLoader.loadBytes(data, context);
		}
		
		final public function load(url:URLRequest, context:LoaderContext) : void
		{
			this.context = context;
			urlLoader.load(url);
			loadUrl = url.url;
		}
		
		public function abort() : void
		{
			try{
				urlLoader.close();
			}catch(e:*){
				
			}
			
		}
		
		protected function __error(event:IOErrorEvent) : void
		{
			Log.error(event.text, this);
			dispatchEvent(event.clone());
		}
		
		private function __progress(event:ProgressEvent) : void
		{
			dispatchEvent(event.clone());
		}
		
		private function __dataLoaded(event:Event) : void
		{
			swfLoader = new Loader();
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __error);
			loadBytes(urlLoader.data, context);
		}
		
		protected function complete(event:Event) : void
		{
			dispatchEvent(event.clone());
		}
	}
}
