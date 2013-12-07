package g1.common.loader
{
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	
	final public class QueueSWFLoader extends QueueLoader
	{
		private var loader:SWFLoader;
		private var context:LoaderContext;
		
		public function QueueSWFLoader(loader:SWFLoader, paths:Array = null, context:LoaderContext = null)
		{
			this.loader = loader;
			this.context = context;
			super(paths);
		}
		
		public function setLoaderContext(context:LoaderContext) : void
		{
			this.context = context;
		}
		
		override protected function getCurrentLoadedData():*
		{
			return getLoader().getContent();
		}
		
		override protected function doLoadItem(request:URLRequest, index:int) : void
		{
			getLoader().load(request, context);
		}
		
		override protected function getLoaderObj() : EventDispatcher
		{
			return getLoader();
		}
		
		private function getLoader() : SWFLoader
		{
			return loader;
		}
		
	}
}
