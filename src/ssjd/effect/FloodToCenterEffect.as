package ssjd.effect
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class FloodToCenterEffect
	{
		public function FloodToCenterEffect(con : DisplayObjectContainer, display : DisplayObject, onEffectEnd : Function = null)
		{
			var allMask : Sprite = new Sprite();
			allMask.graphics.beginFill(0xff000000);
			allMask.graphics.drawRect(0, 0, 1, display.height);
			allMask.graphics.endFill();
			allMask.width = display.width;
			
			con.addChild(allMask);
			display.mask = allMask;
			
			
			var onFinishTween : Function = function() : void
			{
				display.mask = null;
				display.alpha = 1;
				
				con.removeChild(allMask);
				
				if (onEffectEnd != null) {
					onEffectEnd();
				}
			};		
			
			TweenLite.to(allMask, 0.8, {x : allMask.width / 2, width : 0});
			TweenLite.to(display, 0.8, {alpha : 0.2, onComplete:onFinishTween});
		}
	}
}