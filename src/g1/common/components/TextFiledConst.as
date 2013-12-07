package g1.common.components
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-12-25 下午05:10:28
	 *		@说       明: 文本设置
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class TextFiledConst
	{
		public static const FONT : String = "SimSun";
		public static const NORMAL_SIZE : int = 12;
		public static const HEAVY_SIZE : int = 14;

		//常规字体左对齐
		public static var normal_left_fmt : TextFormat; 
		
		//常规字体居中
		public static var normal_center_fmt : TextFormat;
		
		//常规字体右对齐
		public static var normal_right_fmt : TextFormat;
		
		//大字体左对齐
		public static var heavy_left_fmt : TextFormat;
		
		//大字体居中
		public static var heavy_center_fmt : TextFormat;
		
		//大字体右对齐
		public static var heavy_right_fmt : TextFormat;
		
		private static var init : * = function() : void
		{
			normal_left_fmt = new TextFormat();
			normal_left_fmt.font = FONT;
			normal_left_fmt.size = NORMAL_SIZE;
			normal_left_fmt.align = TextFormatAlign.LEFT;
			normal_left_fmt.color = 0xffffff;
			
			normal_center_fmt = new TextFormat();
			normal_center_fmt.font = FONT;
			normal_center_fmt.size = NORMAL_SIZE;
			normal_center_fmt.align = TextFormatAlign.CENTER;
			normal_center_fmt.color = 0xffffff;
			
			normal_right_fmt = new TextFormat();
			normal_right_fmt.font = FONT;
			normal_right_fmt.size = NORMAL_SIZE;
			normal_right_fmt.align = TextFormatAlign.RIGHT;
			normal_right_fmt.color = 0xffffff;
			
			
			heavy_left_fmt = new TextFormat();
			heavy_left_fmt.font = FONT;
			heavy_left_fmt.size = HEAVY_SIZE;
			heavy_left_fmt.align = TextFormatAlign.LEFT;
			heavy_left_fmt.color = 0xffffff;
			
			heavy_center_fmt = new TextFormat();
			heavy_center_fmt.font = FONT;
			heavy_center_fmt.size = HEAVY_SIZE;
			heavy_center_fmt.align = TextFormatAlign.CENTER;
			heavy_center_fmt.color = 0xffffff;
			
			heavy_right_fmt = new TextFormat();
			heavy_right_fmt.font = FONT;
			heavy_right_fmt.size = HEAVY_SIZE;
			heavy_right_fmt.align = TextFormatAlign.RIGHT;
			heavy_right_fmt.color = 0xffffff;
		}();
		
		public static function setTextFormat(tf : TextField, fmt : TextFormat) : void
		{
			tf.setTextFormat(fmt);
		}
	}
}