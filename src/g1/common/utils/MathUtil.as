package g1.common.utils
{
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2013-7-17 上午11:14:46
	 *		@说       明:  数学函数工具
	 *
	 *		@作       者: leon.liu
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/	
	
	public class MathUtil
	{
		public static function getDirection(angle : Number) : int
		{
			return int(angle / PI_DIV_4 + 17 / 2) % 8;
		}
		
		private static const PI_DIV_4	: Number 	= 0.785398163	;	// pi / 4		
	}
}