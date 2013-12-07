package ssjd.effect
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	// 两边跑特效
	
	public class BothHeadEffect
	{
		public function BothHeadEffect(left : DisplayObject, 
									   right : DisplayObject, 
									   beginWidth : int, 
									   endWidth : int, 
									   height : int)
		{
			var leftMaskRect : Sprite = new Sprite();
			leftMaskRect.graphics.beginFill(0xee0000);
			leftMaskRect.graphics.drawRect(0, 0, 1, height);
			leftMaskRect.graphics.endFill();
			leftMaskRect.width = beginWidth;
			left.mask = leftMaskRect;
			leftMaskRect.x = endWidth / 2 - beginWidth;
			
			var rightMaskRect : Sprite = new Sprite();
			rightMaskRect.graphics.beginFill(0xee0000);
			rightMaskRect.graphics.drawRect(0, 0, 1, height);
			rightMaskRect.graphics.endFill();
			rightMaskRect.height = beginWidth;
			right.mask = rightMaskRect;
			rightMaskRect.y = endWidth / 2 + beginWidth;
		}
	}
}