package g1.common.utils
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-12-10 下午2:00:54
	 *		@说       明:  
	 *
	 *		@作       者: leon.liu
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/	
	
	public class RectangleUtil
	{
		
		/**
		 *  矩形是否相交
		 */ 
		public static function isCross(rect1 : Rectangle, rect2 : Rectangle) : Boolean
		{
			var minX : Number = Math.max(rect1.left, rect2.left);
			var minY : Number = Math.max(rect1.top, rect2.top);
			var maxX : Number = Math.min(rect1.right, rect2.right);
			var maxY : Number = Math.min(rect1.bottom, rect2.bottom);
			
			return !(minX > maxX || minY > maxY);
		}
		
		/**
		 *  矩形是否包含一个点  
		 */ 
		public static function isContain(rect : Rectangle, pt : Point) : Boolean
		{
			return pt.x > rect.left 
						&& pt.y > rect.top 
						&& pt.x < rect.right 
						&& pt.y < rect.bottom;
		}
	}
}