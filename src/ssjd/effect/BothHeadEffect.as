package ssjd.effect
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	// 两边跑特效
	
	public class BothHeadEffect 
	{
		public function BothHeadEffect(con : DisplayObjectContainer,
									   left : DisplayObject, 
									   right : DisplayObject, 
									   beginWidth : int, 
									   endWidth : int, 
									   height : int, 
									   onEffectEnd : Function = null)
		{
			var leftMaskRect : Sprite = new Sprite();
			leftMaskRect.graphics.beginFill(0xee0000);
			leftMaskRect.graphics.drawRect(0, 0, 1, height);
			leftMaskRect.graphics.endFill();
			leftMaskRect.width = beginWidth;
			left.mask = leftMaskRect;
			leftMaskRect.x = endWidth / 2 - beginWidth;
			con.addChild(leftMaskRect);
			
			var rightMaskRect : Sprite = new Sprite();
			rightMaskRect.graphics.beginFill(0xee0000);
			rightMaskRect.graphics.drawRect(0, 0, 1, height);
			rightMaskRect.graphics.endFill();
			rightMaskRect.width = beginWidth;
			right.mask = rightMaskRect;
			rightMaskRect.x = endWidth / 2 + beginWidth;
			con.addChild(rightMaskRect);
			
			left.alpha = right.alpha = 0.2;
			
			var onFinishTween : Function = function() : void
			{
				left.mask = null;
				right.mask = null;
				con.removeChild(leftMaskRect);
				con.removeChild(rightMaskRect);
				
				if (onEffectEnd != null) {
					onEffectEnd();
				}
			};
			
			var useTime : Number = 1;
			TweenLite.to(leftMaskRect, useTime, {x : 0, width : endWidth});
			TweenLite.to(rightMaskRect, useTime, {x : 0, width : endWidth});
			TweenLite.to(left, 1, {alpha : useTime, x : 0});
			TweenLite.to(right, 1, {alpha : useTime, x : 0, onComplete:onFinishTween});	
		}
	}
}