package g1.common.loader
{
	
	public interface QueueLoaderListener
	{
		
		function onItemLoadComplete(loader:QueueLoader, data:*, index:int) : void;
		
		function onAllLoadComplete(loader:QueueLoader, datas:Array) : void;
		
		function onLoadProgress(loader:QueueLoader, itemBytesLoaded:int, itemBytesTotal:int, currentItem:int, itemsTotal:int) : void;
		
		function onLoadSecurityError(loader:QueueLoader, errorInfo:String) : void;
		
		function onLoadStopped(loader:QueueLoader) : void;
		
		function onLoadIOError(loader:QueueLoader, errorInfo:String) : void;
		
	}
}
