package ssjd.indexLayer
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import g1.common.loader.SWFLoader;
	import g1.common.loader.TextLoader;

	public class IndexLayer
	{
		public function IndexLayer()
		{
		}
		
		public function init(root : DisplayObjectContainer) : void
		{
			m_root = root;
			m_sceneW = 780;
			m_sceneH = 760;
			m_halfSceneW = m_sceneW/2 + m_iconOffsetX;
			m_halfSceneH = m_sceneH/2;
			m_speed = .05;
			m_root.addEventListener(Event.ENTER_FRAME, onEnrer);
			
			m_configLoader = new TextLoader();
			m_configLoader.addEventListener(Event.COMPLETE, onXmlLoaded);
			m_configLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			m_configLoader.load(new URLRequest(m_loadFolder + "index.xml"));
		}
		
		protected function onXmlLoaded(event:Event):void
		{
			m_config = XML(m_configLoader.getContent());
			m_numIcon = m_config.child("icon").length();
			
			for(var i : int = 0; i < m_numIcon; i ++){
				m_loadList.push(String(m_config.child("icon")[i].@image));
			}
			
			m_loader = new SWFLoader();
			m_loader.addEventListener(Event.COMPLETE, onLoaded);
			m_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			m_isLoadIcon = true;
			loadNext();
		}
		
		private function loadNext() : void
		{
			var request : URLRequest;
			if(m_loadList.length){
				request = new URLRequest(m_loadFolder + m_loadList.shift());
				m_loader.load(request, new LoaderContext(false, ApplicationDomain.currentDomain));
			}else{
				m_isLoadIcon = false;
				request = new URLRequest(m_loadFolder + "mainSceneSource.swf");
				m_loader.load(request, new LoaderContext(false, ApplicationDomain.currentDomain));
			}
		}
		
		protected function onEnrer(event:Event):void
		{
			if(!m_needRotation) return;
			
			//计算鼠标和屏幕中心点的位置和距离，来计算speed;
			var dx : int = m_root.mouseX - m_halfSceneW;
			var dy : int = m_root.mouseY - m_halfSceneH;
			var dis : int = Math.sqrt(dx * dx + dy * dy);
			dis = m_root.mouseX > m_halfSceneW ? dis : -dis;
			m_speed = (dis * .0001);
			
			var len : int = m_iconList.length;
			for(var i : int = 0; i < len; i++)
			{
				var iconCache : IconCache = m_iconList[i];
				var icon : DisplayObject = iconCache.displayObject;
				iconCache.index += m_speed;
				icon.x = m_halfSceneW + Math.sin(iconCache.index) * m_iconToCenterDis * 2 - m_iconToCenterDis;
				icon.y = m_halfSceneH+ Math.cos(iconCache.index) * m_iconToCenterDis * 2 - m_iconToCenterDis;
			}
		}
		
		public function setBaseDir(baseFolder:String):void
		{
			m_loadFolder = baseFolder;
		}
		
		private function onLoaded(e:Event) : void
		{
			trace("加载成功",this);
			if(m_isLoadIcon){
				m_iconSkinArr.push(m_loader.getContent());
				loadNext();
			}else{
				createIcon();
			}
		}
		
		private function createIcon():void
		{
			m_iconClass = getDefinitionByName("indexBtn") as Class;
			
			var perDegree : int = 360 / m_numIcon;
			
			for(var i : int = 0; i < m_numIcon; i++){
				var iconCache : IconCache = new IconCache();
				iconCache.index = perDegree * (m_numIcon -  i);
				
				iconCache.target = new m_iconClass();
				iconCache.target.x -= m_iconOffsetX;
				iconCache.target.y -= 10.35;
				iconCache.target.stop();
				
				var argb : Array = String(m_config.child("icon")[i].@color).split(",");
				var r : Number = int(argb[1]);
				var g : Number = int(argb[2]);
				var b : Number = int(argb[3]);
				var a : Number = int(argb[0]);
				
				var matrix : Array = [];
				matrix = matrix.concat([1,0,0,0,r]); //r
				matrix = matrix.concat([0,1,0,0,g]); //g
				matrix = matrix.concat([0,0,1,0,b]); //b
				matrix = matrix.concat([0,0,0,1,a]); //a
				
				//颜色变换
				iconCache.target.filters = [new ColorMatrixFilter(matrix)];
				
				//加载背景
				iconCache.displayObject.addChild(iconCache.target); 
				
				//加载skin
				var skin : DisplayObject = m_iconSkinArr[i];
				iconCache.bg = skin;
				iconCache.displayObject.addChild(skin); 
				skin.alpha = 0;
				
				//创建文本
				var format : TextFormat = new TextFormat();
				format.color = 0xFFFFFF;
				
				var tf : TextField = new TextField();
				tf.selectable = tf.mouseEnabled = false;
				tf.defaultTextFormat = format;
				tf.text = m_config.child("icon")[i].@cation;
				tf.width = tf.textWidth + 5;
				tf.height = tf.textHeight + 5;
				tf.x = 88 - tf.width >> 1;
				tf.y = skin.height - tf.height;
				tf.alpha = 0;
				iconCache.tf = tf;
				iconCache.displayObject.addChild(tf);
				
				iconCache.displayObject.name = i.toString();
				
				//初始化按钮位置
				iconCache.displayObject.x = m_halfSceneW + Math.sin(iconCache.index) * m_iconToCenterDis * 2 - m_iconToCenterDis;
				iconCache.displayObject.y = m_halfSceneH+ Math.cos(iconCache.index) * m_iconToCenterDis * 2 - m_iconToCenterDis;
				
				m_root.addChild(iconCache.displayObject);
				m_iconList[i] = iconCache;
				
				TweenLite.from(iconCache.displayObject,  i/10 + 0.3 , {y : m_sceneH + 100,  delay : i * .05,  ease :  Back.easeOut ,onStart : onTweenStart, onStartParams : [iconCache], onComplete : onTweenOver, onCompleteParams: [iconCache,i]});
				iconCache.target.addFrameScript(19, tweenSkinAndTf);
			}
		}
		
		private var tweenSkinIndex : int = 0;
		private function tweenSkinAndTf() : void
		{
			var cache : IconCache = m_iconList[tweenSkinIndex++];
			cache.bg.alpha = 1;
			TweenLite.from(cache.bg,.5,{alpha:0});
			
			cache.tf.alpha = 1;
			TweenLite.from(cache.tf,.5,{alpha:0});
		}
		
		private function onTweenStart(target : IconCache) : void
		{
			target.target.play();
		}
		
		private function onTweenOver(target : IconCache, index : int) : void
		{
			target.displayObject.buttonMode = true;
			target.displayObject.addEventListener(MouseEvent.CLICK, onMouseEvent);
			target.displayObject.addEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			target.displayObject.addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
			
			if(index == m_numIcon - 1)
				m_needRotation = true;
		}
		
		protected function onMouseEvent(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		private function onError(e:IOErrorEvent) : void
		{
			trace("加载失败",e.toString(),this);
		}
		
		public static function get instance() : IndexLayer
		{
			return m_instance ||= new IndexLayer();
		}
		
		private static var m_instance : IndexLayer;
		
		private var m_sceneW : int;
		private var m_sceneH : int;
		private var m_halfSceneW : int;
		private var m_halfSceneH : int;
		private var m_iconToCenterDis : int = 100;
		private var m_iconOffsetX : Number = 222.8;
		private var m_speed : Number;
		private var m_config : XML;
		
		private var m_needRotation : Boolean = false;
		private var m_isLoadIcon : Boolean = false;
		private var m_iconClass : Class;
		private var m_loadList : Array= [];
		private var m_iconList : Array = [];
		private var m_iconSkinArr : Array = []; //按钮上的皮肤图片
		private var m_numIcon : int = 1;
		private var m_root : DisplayObjectContainer;
		private var m_loader : SWFLoader;
		private var m_configLoader : TextLoader;
		private var m_loadFolder : String;
	}
}
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

class IconCache
{
	public var index : Number;
	public var displayObject : Sprite = new Sprite();
	public var target : MovieClip;
	public var tf : TextField;
	public var bg : DisplayObject;
}