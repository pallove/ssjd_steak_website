package g1.common.loader
{
	import flash.events.*;
	import flash.net.*;
	
	import g1.common.debug.Log;
	
	public class QueueLoader
	{
		private var datas : Array;
		private var paths : Array;
		private var requests:Array;
		private var index:int;
		private var stopAllIfOneError:Boolean;
		private var listeners:Array;
		
		public function QueueLoader(paths:Array = null)
		{
			setPaths(paths == null ? ([]) : (paths));
			listeners = new Array();
			datas = new Array();
			var listener:IEventDispatcher = getLoaderObj();
			listener.addEventListener(Event.COMPLETE, __loadComplete);
			listener.addEventListener(IOErrorEvent.IO_ERROR, __loadIOError);
			listener.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __loadSecurityError);
			listener.addEventListener(ProgressEvent.PROGRESS, __loadProgress);
			stopAllIfOneError = true;
		}
		
		private function __loadSecurityError(event:SecurityErrorEvent) : void
		{
			datas.push(null);
			dispatchSecurityError(event.text);
			if (!stopAllIfOneError)
			{
				loadNext();
			}
			else
			{
				dispatchStopped();
			}
		}
		
		private function __loadIOError(event:IOErrorEvent) : void
		{
			datas.push(null);
			if (event.text.indexOf("#2124") == -1)
			{
				dispatchIOError(event.text);				
				reload();
			}
			else
			{
				dispatchIOError(event.text);
				if (!stopAllIfOneError)
				{
					loadNext();
				}
				else
				{
					dispatchStopped();
				}
			}
			Log.error(event.text, this);
		}
		
		protected function doLoadItem(request:URLRequest, index:int) : void
		{
			throw new Error("Imp Miss");
		}
		
		private function dispatchItemComplete(data:*) : void
		{
			var queueLoader:QueueLoaderListener = null;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onItemLoadComplete(this, data, index);
				loaded = loaded + 1;
			}
		}
		
		private function dispatchProgress(byteLoaded:int, byteTotal:int) : void
		{
			var queueLoader:QueueLoaderListener = null;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onLoadProgress(this, byteLoaded, byteTotal, index, requests.length);
				loaded = loaded + 1;
			}
		}
		
		public function clear() : void
		{
			requests = new Array();
			index = -1;
			datas = new Array();
		}
		
		private function dispatchSecurityError(text:String) : void
		{
			var queueLoader:QueueLoaderListener = null;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onLoadSecurityError(this, text);
				loaded = loaded + 1;
			}
		}
		
		private function dispatchIOError(text:String) : void
		{
			var queueLoader:QueueLoaderListener = null;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onLoadIOError(this, text);
				loaded = loaded + 1;
			}
		}
		
		public function setURLRequests(requests:Array) : void
		{
			this.requests = requests.concat();
		}
		
		public function getDatas() : Array
		{
			return datas.concat();
		}
		
		public function getPaths() : Array
		{
			return paths;
		}
		
		public function removeListener(lis:QueueLoaderListener) : void
		{
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				if (lis == listeners[loaded])
				{
					listeners.splice(loaded, 1);
				}
				loaded = loaded + 1;
			}
		}
		
		private function __loadProgress(event:ProgressEvent) : void
		{
			dispatchProgress(event.bytesLoaded, event.bytesTotal);
		}
		
		public function setStopAllIfOneError(b:Boolean) : void
		{
			stopAllIfOneError = b;
		}
		
		private function __loadComplete(event:Event) : void
		{
			datas.push(getCurrentLoadedData());
			dispatchItemComplete(getCurrentLoadedData());
			loadNext();
		}
		
		private function reload() : void
		{
			var request:URLRequest = requests[index];
			var vars:URLVariables = new URLVariables();
			vars.timer = new Date().getTime();
			request.data = vars;
		}
		
		private function dispatchAllComplete() : void
		{
			var queueLoader:QueueLoaderListener = null;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onAllLoadComplete(this, datas);
				loaded = loaded + 1;
			}
		}
		
		public function startLoad() : void
		{
			index = -1;
			datas = new Array();
			loadNext();
		}
		
		public function getLoadingIndex() : int
		{
			return index;
		}
		
		protected function getLoaderObj() : EventDispatcher
		{
			throw new Error("Imp Miss");
		}
		
		protected function getCurrentLoadedData():*
		{
			throw new Error("Imp Miss");
		}
		
		public function addListener(lis:QueueLoaderListener) : void
		{
			listeners.push(lis);
		}
		
		public function getRequestCount() : int
		{
			return requests.length;
		}
		
		private function loadNext() : void
		{
			var request:URLRequest;
			index++;
			if (index >= requests.length)
			{
				dispatchAllComplete();
			}
			else
			{
				request = requests[index];
				if (request == null)
				{
					datas.push(null);
					dispatchItemComplete(null);
					loadNext();
				}
				else
				{
					doLoadItem(request, index);
				}
			}
		}
		
		private function dispatchStopped() : void
		{
			var queueLoader:QueueLoaderListener;
			var loaded:int = 0;
			while (loaded < listeners.length)
			{
				
				queueLoader = QueueLoaderListener(listeners[loaded]);
				queueLoader.onLoadStopped(this);
				loaded++;
			}
		}
		
		public function setPaths(paths:Array) : void
		{
			this.paths = paths;
			requests = new Array();
			var index:int = 0;
			while (index < paths.length)
			{
				
				if (paths[index] == null)
				{
					requests.push(null);
				}
				else
				{
					requests.push(new URLRequest(paths[index]));
				}
				index = index + 1;
			}
		}
	}
}
