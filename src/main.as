package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import ssjd.bgLayer.BgLayer;
	import ssjd.contentLayer.ContentLayer;
	import ssjd.controlLayer.ControlLayer;
	import ssjd.loadingLayer.LoadingLayer;
	
	[SWF(backgroundColor="#eeeeee", frameRate="31", width="1280", height="800")]
	
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
			
			loadingLayer = new LoadingLayer();
			loadingLayer.init(addChild(new Sprite()) as Sprite);
		} 
		
		private var bgLayer : BgLayer;
		private var contentLayer : ContentLayer;
		private var controlLayer : ControlLayer;
		private var loadingLayer : LoadingLayer;
	}
}