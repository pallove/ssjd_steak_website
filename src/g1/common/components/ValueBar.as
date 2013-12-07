package g1.common.components
{
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * 简单的进度条
	 * 
	 */ 
	public class ValueBar extends Sprite
	{
		public var color:uint = 0xFF0000; 
		public var backgroundColor:uint = 0x460000; 
		public var lineColor:uint = 0xff6c00; 
		
		protected var backshape:Shape = new Shape();
		protected var fontshape:Shape = new Shape();
		
		protected var backDisplay:DisplayObject;
		protected var fontDisplay:DisplayObject;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ValueBar(background:DisplayObject=null,fontBg:DisplayObject=null)
		{
			super();
			backDisplay = background;
			fontDisplay = fontBg;
			backDisplay.mask = fontDisplay;
			
			addChild(backDisplay);
			addChild(fontDisplay);
			width = fontBg.width;
			height = fontBg.height;
			mouseEnabled = mouseChildren = false;
			
//			addChild(backshape);
//			addChild(fontshape);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  width
		//----------------------------------

		protected var _width:Number;

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
			draw1();
		}

		//----------------------------------
		//  height
		//----------------------------------
		
		protected var _height:Number;

		override public function get height():Number
		{
			return _height;
		}

		override public function set height(value:Number):void
		{
			_height = value;
			draw1();
		}

		//----------------------------------
		//  maxValue
		//----------------------------------
		
		protected var _maxValue:Number = 1;

		public function get maxValue():Number
		{
			return _maxValue;
		}

		public function set maxValue(v:Number):void
		{
			_maxValue = Math.max(1, v);
			draw1();
		}

		//----------------------------------
		//  value
		//----------------------------------

		protected var _value:Number = 0;

		public function get value():Number
		{
			return _value;
		}

		public function set value(v:Number):void
		{
			_value = Math.max(0, v);
			draw1();
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		public function setStyle(color:uint, backgroundColor:uint, lineColor:uint):void
		{
			this.color = color;
			this.backgroundColor = backgroundColor;
			this.lineColor = color;
		}
		
		protected function draw():void
		{
			if (isNaN(width) || isNaN(height) || isNaN(value) || isNaN(maxValue))
				return;
			
			backshape.graphics.clear();
			backshape.graphics.lineStyle(1, 0xffaa00, 1, true, "normal", CapsStyle.SQUARE);
			backshape.graphics.beginFill(backgroundColor, 1);
			backshape.graphics.drawRect(0, 0, width, height);
			
			fontshape.graphics.clear();
			fontshape.graphics.lineStyle(1, lineColor, 1, true, "normal", CapsStyle.SQUARE);
			fontshape.graphics.beginFill(color, 1);
			
			var w:Number = Math.max((width-3) * value / maxValue,0);
			if (w > 0)
				fontshape.graphics.drawRect(1, 1, w, height - 2);
		}
		
		protected function draw1():void
		{
			if (isNaN(width) || isNaN(height) || isNaN(value) || isNaN(maxValue))
				return;
			var w:Number = Math.max((width-3) * value / maxValue,0);
			if (w > 0)
				fontDisplay.width = w;
		}
	}
}