package g1.common.loader
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * 		@author leon.liu
	 * 		创建时间：	2012-2-28
	 *
	 *		
	 */
	
	public class QueueTextLoader extends QueueLoader
	{
		private var loader 	: TextLoader;
		private var context : LoaderContext;
		public function QueueTextLoader(loader : TextLoader, paths : Array = null)
		{
			this.loader = loader;
			super(paths);
		}
		
		override protected function getCurrentLoadedData():*
		{
			return getLoader().getContent();
		}
		
		override protected function doLoadItem(request:URLRequest, index:int) : void
		{
			getLoader().load(request);
		}
		
		override protected function getLoaderObj() : EventDispatcher
		{
			return getLoader();
		}
		
		private function getLoader() : TextLoader
		{
			return loader;
		}		
	}
}