package g1.common.components
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.TextAlign;
	
	public class Label extends Sprite
	{
		public var textView:TextField=new TextField();					//显示文本
		private var _text:String;
		private var myTextFormat:TextFormat=new TextFormat();
		public function Label()
		{
			super();
			this.addChild(textView);
			this.buttonMode=true;
			this.mouseEnabled=false;
			textView.wordWrap=true;
			setAline("center");
			textView.height=20;
			textView.width=100;
			textView.mouseEnabled=false;
			textView.textColor = 0xccffff;
			textView.defaultTextFormat = new TextFormat(TextFiledConst.FONT,TextFiledConst.NORMAL_SIZE);
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}	
		
		public function get text():String
		{
			return textView.text;
		}

		public function set text(value:String):void
		{
			textView.text = value;
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return textView.height;
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			textView.height = value;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return textView.width;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			textView.width = value;
		}
		
		/**
		 * 设置文本对齐方式 
		 */
		public function setAline(font:String="center"):void
		{
			switch(	font)
			{
				case "left":
				{
					myTextFormat.align=TextFormatAlign.LEFT;
					textView.defaultTextFormat=myTextFormat;
					break;
				}
				case "center":
				{
					myTextFormat.align=TextFormatAlign.CENTER;
					textView.defaultTextFormat=myTextFormat;
					break;
				}
				case "right":
				{
					myTextFormat.align=TextFormatAlign.RIGHT;
					textView.defaultTextFormat=myTextFormat;
					break;
				}
					
				case "justify":
				{
					myTextFormat.align=TextFormatAlign.JUSTIFY;
					textView.defaultTextFormat=myTextFormat;
					break;
				}
			}
		}
		
		public function set htmltext(str:String):void
		{
			textView.htmlText=str;
		}
	}
}