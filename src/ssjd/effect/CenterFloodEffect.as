package ssjd.effect
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class CenterFloodEffect
	{
		public function CenterFloodEffect(con : DisplayObjectContainer, display : DisplayObject, onEffectEnd : Function = null)
		{
			var leftPart : Sprite = new Sprite();
			leftPart.graphics.beginFill(0xff000000);
			leftPart.graphics.drawRect(0, 0, 1, display.height);
			leftPart.graphics.endFill();
			leftPart.width = display.width >> 1;
			
			var rightPart : Sprite = new Sprite();
			rightPart.graphics.beginFill(0xff000000);
			rightPart.graphics.drawRect(0, 0, 1, display.height);
			rightPart.graphics.endFill();
			rightPart.width = display.width >> 1;	
			
			leftPart.x = 0;
			rightPart.x = display.width >> 1;
			
			var maskObj : Sprite = new Sprite();
			maskObj.addChild(leftPart);
			maskObj.addChild(rightPart);
			
			con.addChild(maskObj);
			display.mask = maskObj;
			
			var onFinishTween : Function = function() : void
			{
				display.mask = null;
				con.removeChild(maskObj);
				
				if (onEffectEnd != null) {
					onEffectEnd();
				}
			};			
			
			TweenLite.to(leftPart, 0.8, {x : -leftPart.width});
			TweenLite.to(rightPart, 0.8, {x : rightPart.x + rightPart.width, onComplete:onFinishTween});
			
		}
	}
}