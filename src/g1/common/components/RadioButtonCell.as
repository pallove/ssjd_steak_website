package g1.common.components 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class RadioButtonCell extends Sprite
	{
		private var _combo:Sprite = new Sprite;
		private var _text:TextField = new TextField;
		
		public var _index:int = 0;
		
		public function RadioButtonCell(s:String,bCombo:Boolean = false)
		{
			addChild(_combo);
			
			_text.text = s;
			_text.selectable = false;
			var tfor:TextFormat = new TextFormat;
			tfor.align = TextFormatAlign.CENTER;
			_text.setTextFormat(tfor);
			_combo.addChild(_text);
			_text.x = 20;
			SetCombo(bCombo);
		} 
		
		
		public function SetCombo(bCombo:Boolean):void
		{
			_combo.graphics.clear();
			_combo.graphics.beginFill(0,0);
			_combo.graphics.lineStyle(1);
			_combo.graphics.drawCircle(10,10,6);
			_combo.graphics.endFill();
			
			if (bCombo)
			{
				_combo.graphics.beginFill(0);
				_combo.graphics.lineStyle(1);
				_combo.graphics.drawCircle(10,10,2);
				_combo.graphics.endFill();
			}
		}
	}
}
