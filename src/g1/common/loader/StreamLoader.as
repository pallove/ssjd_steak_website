package g1.common.loader
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
	import g1.common.debug.Log;
	
	public class StreamLoader extends EventDispatcher
	{
		protected var urlLoader:URLStream;
		protected var context:LoaderContext;
		protected var swfLoader:Loader;
		protected var loadUrl : String;
		
		public function StreamLoader()
		{
			urlLoader = new URLStream();
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
		
		private function __progress(event:ProgressEvent) : void
		{
			dispatchEvent(event.clone());
		}
		
		private function __dataLoaded(event:Event) : void
		{
			var bytes : ByteArray = new ByteArray();
			urlLoader.readBytes(bytes, 0, urlLoader.bytesAvailable);
			urlLoader.close();
			
			swfLoader = new Loader();
			swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __complete);
			swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __error);
			loadBytes(bytes, context);
		}
		
		private function __complete(event:Event) : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		
		private function __error(event:IOErrorEvent) : void
		{
			dispatchEvent(event.clone());
			Log.error(event.text, this);
		}		
	}
}
