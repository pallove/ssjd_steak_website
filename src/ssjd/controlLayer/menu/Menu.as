package ssjd.controlLayer.menu
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import g1.common.loader.TextLoader;
	
	import ssjd.contentLayer.ContentLayer;
	import ssjd.controlLayer.IContent;

	public class Menu implements IContent
	{
		public function Menu()
		{
			
		}
		
		public function getContent():DisplayObjectContainer
		{
			return m_root;
		}
		
		
		public function destroy():void
		{
		}
		
		public function get type():int
		{
			return ContentLayer.MENU;
		}
		
		
		public function init(display:DisplayObjectContainer):void
		{
			m_root = display;
			
			//　加载配置
			var loader : TextLoader = new TextLoader();
			loader.addEventListener(Event.COMPLETE, __onConfigLoaded);
			loader.load(new URLRequest(m_baseDir + "menu.xml"));
		}
		
		private function __onConfigLoaded(event:Event):void
		{
			var data : XML = (event.target as TextLoader).getContent() as XML;
			
			ContentLayer.singleton.onItemInit(this);
		}
		
		public function set baseDir(dir:String):void
		{
			m_baseDir = dir;
		}		
		
		private var m_baseDir : String;
		private var m_root : DisplayObjectContainer;
	}
}