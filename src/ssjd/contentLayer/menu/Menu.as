package ssjd.contentLayer.menu
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	
	import g1.common.loader.SWFLoader;
	import g1.common.loader.TextLoader;
	import g1.common.utils.Delegate;
	import g1.common.utils.SpriteUtils;
	
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
			TweenPlugin.activate([TintPlugin]);
			
			m_items = new Vector.<MenuItem>();
			m_loadImageQueue = new Vector.<MenuItem>();
			
			m_root = new Sprite();
			m_content = display;
			m_root.addChild(m_content);			
			
			m_bigContent = new Sprite();
			m_root.addChild(m_bigContent);
			
			m_effect = new Sprite();
			m_root.addChild(m_effect);
			
			m_smallLoader = new SWFLoader();
			m_smallLoader.addEventListener(Event.COMPLETE, __onSmallLoaded);
			m_smallLoader.addEventListener(IOErrorEvent.IO_ERROR, __onSmallLoadError);
			
			m_bigLoader = new SWFLoader();
			m_bigLoader.addEventListener(Event.COMPLETE, __onBigLoaded);			
			
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
			bgLeft.x = -20;
			var bgRight : Bitmap = new Bitmap(m_bg.bitmapData);
			bgRight.x = 20;
			
			var effect : BothHeadEffect = new BothHeadEffect(m_effect, bgLeft, bgRight, 100, m_bg.width, m_bg.height, onEffectEnd);
			m_effect.addChild(bgLeft);
			m_effect.addChild(bgRight);
		}		
		
		private function onEffectEnd():void
		{
			SpriteUtils.clearContainer(m_effect);
			m_root.addChildAt(m_bg, 0);
			
			showPage(1);
			
			startLoadMiniImage();
		}
		
		private function startLoadMiniImage():void
		{
			if (m_loadImageQueue.length > 0) {
				m_smllLoadItem = m_loadImageQueue.pop();
				if (m_smllLoadItem.thumbsnailData) {
					fillMiniImage(m_smllLoadItem);
				}
				else {
					m_smallLoader.load(new URLRequest(m_smllLoadItem.thumbsnail), null);
				}
			}
		}
		
		
		private function __onSmallLoaded(event:Event):void
		{
			m_smllLoadItem.thumbsnailData = m_smallLoader.getContent();
			fillMiniImage(m_smllLoadItem);
			startLoadMiniImage();
		}		
		
		private function __onSmallLoadError(event : Event) : void
		{
			startLoadMiniImage();
		}
		
		private function fillMiniImage(item : MenuItem):void
		{
			if (item.index != -1) {
				var itemMC : MovieClip = m_content.getChildByName("item" + item.index) as MovieClip;
				SpriteUtils.clearContainer(itemMC.container);
				itemMC.container.addChild(item.thumbsnailData);
			}
			item.index = -1;
		}
		
		private function showPage(pageNo : int) : void
		{
			m_currentPage = pageNo;
			
			var size : int = m_items.length % PAGE_SIZE;
			if (size == 0) size = PAGE_SIZE;
			
			//　清除加载队列
			m_loadImageQueue.splice(0, m_loadImageQueue.length);
			for(var i : int = 0; i < PAGE_SIZE; i++) {
				var item : MovieClip = m_content.getChildByName("item" + i) as MovieClip;
				if (i < size) {
					var index : int = (m_currentPage - 1) * PAGE_SIZE + i;
					item.mouseChildren = false;
					item.overblock.visible = false;
					item.addEventListener(MouseEvent.MOUSE_OVER, Delegate.create(__onItemOver, item));
					item.addEventListener(MouseEvent.MOUSE_OUT, Delegate.create(__onItemOut, item));
					item.addEventListener(MouseEvent.CLICK, Delegate.create(__onItemClick, index));
					item.visible = true;
					
					var menuItem : MenuItem = m_items[index];
					menuItem.index = i;
					m_loadImageQueue.push(menuItem);
				}
				else {
					item.visible = false;
				}
			}
		}
		
		
		private function __onBigLoaded(event:Event):void
		{
			m_bigLoadItem.showImageData = m_bigLoader.getContent();
			showBigContent(m_bigLoadItem);
		}			
		
		// 显示大图
		private function showBigContent(item : MenuItem):void
		{
			
		}		
		
		private function __onItemClick(index : int):void
		{
			startLoadBigItem(index);

		}
		
		// 开始加载新的大图项
		private function startLoadBigItem(index:int):void
		{
			m_bigLoadItem = m_items[index];
			// 已加载好，开始显示
			if (m_bigLoadItem.showImageData) {
				showBigContent(m_bigLoadItem);
			}
				// 否则，开始加载
			else {
				m_bigLoader.load(new URLRequest(m_bigLoadItem.showImage), null);
			}			
		}		
		
		private function __onItemOver(item : MovieClip) : void
		{
			item.overblock.visible = true;
			(item.namebar.title as TextField).textColor = outBgColor;
			TweenLite.to(item.namebar.bg, 0.5, {tint:overBgColor});
		}
		
		private function __onItemOut(item : MovieClip) : void
		{
			item.overblock.visible = false;
			(item.namebar.title as TextField).textColor = overBgColor;
			TweenLite.to(item.namebar.bg, 0.5, {tint:outBgColor});								
		}		
		
		public function set baseDir(dir:String):void
		{
			m_baseDir = dir;
		}		
		
		private static const overBgColor : int = 0x332B29;
		private static const outBgColor : int = 0xd6b488;
		private static const PAGE_SIZE : int = 10;
		
		private var m_smllLoadItem : MenuItem;
		private var m_smallLoader : SWFLoader;
		private var m_bigLoadItem : MenuItem;
		private var m_bigLoader : SWFLoader;
		
		private var m_currentPage : int;
		private var m_totalPage : int;
		private var m_pageSize : int;
		private var m_baseDir : String;
		
		private var m_bigContent : DisplayObjectContainer;
		private var m_root : DisplayObjectContainer;
		private var m_content : DisplayObjectContainer;
		private var m_effect : Sprite;
		private var m_bg : Bitmap;
		
		private var m_loadImageQueue : Vector.<MenuItem>;
		private var m_items : Vector.<MenuItem>;
	}
}

import flash.display.DisplayObject;

class MenuItem {
	public var index		: int = -1;
	public var title 		: String;
	public var des			: String;	
	public var thumbsnail 	: String;
	public var showImage	: String;
	public var thumbsnailData : DisplayObject;
	public var showImageData : DisplayObject;
}