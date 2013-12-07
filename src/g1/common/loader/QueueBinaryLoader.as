package g1.common.loader
{
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2013-1-22 上午9:49:39
	 *		@说       明:  
	 *
	 *		@作       者: leon.liu
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/	
	
	public class QueueBinaryLoader extends QueueLoader
	{
		private var loader 	: BinaryLoader;
		private var context : LoaderContext;
		public function QueueBinaryLoader(loader : BinaryLoader, paths : Array = null)
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
		
		private function getLoader() : BinaryLoader
		{
			return loader;
		}
	}
}