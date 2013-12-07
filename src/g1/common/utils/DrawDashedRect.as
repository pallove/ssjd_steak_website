package g1.common.utils
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-9-17
	 *		@说       明: 根据初始化时传入对象的大小绘制一个等大的虚线框
	 *		@作       者: cmg
	 *		@版       本: 1.0.0
	 *      @概       述: 画虚线框
	 *
	 *******************************************************/	
	public class DrawDashedRect
	{
		public function DrawDashedRect()
		{			
		}
		
		public static function drawRect(obj : DisplayObject) : DisplayObject
		{
			var shape:Sprite;
			var rect:Rectangle;
			rect = obj.getRect(obj);
			shape = new Sprite();
			var startPt:Point;
			var endPt:Point;
			startPt = new Point();
			endPt = new Point();
			
			shape.graphics.beginFill(0xff0000,0);
			shape.graphics.drawRect(0,0,obj.width,obj.height);
			shape.graphics.endFill();
			
			startPt.x = rect.topLeft.x;
			startPt.y = rect.topLeft.y;
			endPt.x = rect.bottomRight.x;
			endPt.y = rect.topLeft.y;
			drawDashed(shape.graphics,startPt,endPt);
			
			startPt.x = rect.bottomRight.x;
			startPt.y = rect.topLeft.y;
			endPt.x = rect.bottomRight.x;
			endPt.y = rect.bottomRight.y;
			drawDashed(shape.graphics,startPt,endPt);
			
			startPt.x = rect.bottomRight.x;
			startPt.y = rect.bottomRight.y;
			endPt.x = rect.topLeft.x;
			endPt.y = rect.bottomRight.y;
			drawDashed(shape.graphics,startPt,endPt);
			
			startPt.x = rect.topLeft.x;
			startPt.y = rect.bottomRight.y;
			endPt.x = rect.topLeft.x;
			endPt.y = rect.topLeft.y;
			drawDashed(shape.graphics,startPt,endPt);
			
			return shape;
		}
		
		/** 画虚线
		 * 
		 * @param    graphics    <b>    Graphics</b> 
		 * @param    beginPoint    <b>    Point    </b> 起始点坐标
		 * @param    endPoint    <b>    Point    </b> 终点坐标
		 * @param    width        <b>    Number    </b> 虚线的长度
		 * @param    grap        <b>    Number    </b> 虚线短线之间的间隔
		 */
		static public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number  = 5, grap:Number = 3):void
		{
			if (!graphics || !beginPoint || !endPoint || width <= 0 || grap <= 0) return;
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var x:Number, y:Number;
			graphics.lineStyle(1,0xff0000);
			
			while (currLen <= totalLen)
			{
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.moveTo(x, y);
				
				currLen += width;
				if (currLen > totalLen) currLen = totalLen;
				
				x = Ox + Math.cos(radian) * currLen;
				y = Oy +Math.sin(radian) * currLen;
				graphics.lineTo(x, y);
				
				currLen += grap;
			}
		}
	}
}