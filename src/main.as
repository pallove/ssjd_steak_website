package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import ssjd.bgLayer.BgLayer;
	import ssjd.contentLayer.ContentLayer;
	import ssjd.controlLayer.ControlLayer;
	import ssjd.indexLayer.IndexLayer;
	import ssjd.loadingLayer.LoadingLayer;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="30", width="980", height="760")]
	
	public class main extends Sprite
	{
		public function main()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// 分为四层, 背景层，内容层，导航层，加载层
			// 背景层负责显示加载的背景图
			//　内容层显示从外加载的swf内容，切换一个前一个卸载并缓存起来，后一个加载进来
			// 导航层处理加载卸载的工作
			// 加载层，swf内容加载时要显示相应的加载情况 
			bgLayer = new BgLayer();
			bgLayer.init(addChild(new Sprite()) as Sprite);
			
			contentLayer = new ContentLayer();
			contentLayer.setBaseDir("./res/");
			contentLayer.init(addChild(new Sprite()) as Sprite);
			
			controlLayer = new ControlLayer();
			controlLayer.init(addChild(new Sprite()) as Sprite);
			
			indexLayer = new IndexLayer();
			indexLayer.setBaseDir("./res/index/");
			indexLayer.init(addChild(new Sprite()) as Sprite);
			
			loadingLayer = new LoadingLayer();
			loadingLayer.init(addChild(new Sprite()) as Sprite);
			
			//测试留言本
			//查看留言内容地址
			//管理密码:1234567
			//http://www.dreamfairy.cn/test/zz/system.html
			
			/**
			var loader:URLLoader = new URLLoader();  
			var URLSt:URLRequest = new URLRequest("http://www.dreamfairy.cn/test/zz/savemsg.php");  
			URLSt.method = URLRequestMethod.POST;  
			var values:URLVariables = new URLVariables();  
			values.Name  = "超超";  
			values.Content = "你大爷";  
			URLSt.data = values;  
			loader.addEventListener(Event.COMPLETE, sendMsg);  
			loader.load(URLSt);  **/
		} 
		
		protected function sendMsg(event:Event):void
		{
			trace("发送聊天成功",event.toString());
		}
		
		private var bgLayer : BgLayer;
		private var indexLayer : IndexLayer;
		private var contentLayer : ContentLayer;
		private var controlLayer : ControlLayer;
		private var loadingLayer : LoadingLayer;
	}
}