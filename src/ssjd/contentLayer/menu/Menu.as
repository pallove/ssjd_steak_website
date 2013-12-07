package ssjd.contentLayer.menu
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import g1.common.loader.SWFLoader;
	import g1.common.loader.TextLoader;
	
	import ssjd.contentLayer.ContentLayer;
	import ssjd.contentLayer.IContent;
	import ssjd.effect.BothHeadEffect;

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
			m_items = new Vector.<MenuItem>();
			
			m_root = new Sprite();
			m_content = display;
			m_root.addChild(m_content);
			
			m_effect = new Sprite();
			m_root.addChild(m_effect);
			
			//　加载配置
			var loader : TextLoader = new TextLoader();
			loader.addEventListener(Event.COMPLETE, __onConfigLoaded);
			loader.load(new URLRequest(m_baseDir + "menu.xml"));
		}
		
		private function __onConfigLoaded(event:Event):void
		{
			var data : XML = XML((event.target as TextLoader).getContent());
			m_pageSize = int(data.@pageSize);
			for each(var node : XML in data.children()) {
				var item : MenuItem = new MenuItem();
				item.title = node.title;
				item.des = node.des;
				item.thumbsnail = m_baseDir + node.thumbsnail;
				item.showImage = m_baseDir + node.showImage;
				
				m_items.push(item);
			}
			
			// 图片加载
			var imgLoader : SWFLoader = new SWFLoader();
			var context : LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			imgLoader.addEventListener(Event.COMPLETE, __onImgLoaded);
			imgLoader.load(new URLRequest(m_baseDir + "menu_bg.jpg"), context);
			
		}
		
		private function __onImgLoaded(event:Event):void
		{
			m_bg = (event.target as SWFLoader).getContent() as Bitmap;
			
			ContentLayer.singleton.onItemInit(this);
		}
		
		// 开始显示, 开始转换动作效果
		public function show():void
		{ 
			// 缓动效果
			var bgLeft : Bitmap = new Bitmap(m_bg.bitmapData);
			bgLeft.x = -50;
			var bgRight : Bitmap = new Bitmap(m_bg.bitmapData);
			bgRight.x = 50;
			
			var effect : BothHeadEffect = new BothHeadEffect(bgLeft, bgRight, 100, m_bg.width, m_bg.height);
			m_effect.addChild(bgLeft);
			m_effect.addChild(bgRight);
		}		
		
		private function showPage(pageNo : int) : void
		{
			
		}
		
		public function set baseDir(dir:String):void
		{
			m_baseDir = dir;
		}		
		
		private var m_pageSize : int;
		private var m_items : Vector.<MenuItem>;
		private var m_baseDir : String;
		private var m_root : DisplayObjectContainer;
		private var m_content : DisplayObjectContainer;
		private var m_effect : Sprite;
		private var m_bg : Bitmap;
		
	}
}

class MenuItem {
	public var title 		: String;
	public var des			: String;	
	public var thumbsnail 	: String;
	public var showImage	: String;
}