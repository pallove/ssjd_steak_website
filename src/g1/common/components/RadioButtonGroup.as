package  g1.common.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class RadioButtonGroup extends Sprite
	{
		public var cellList:Array = new Array;
		public var selectIndex:int = 0;
		
		public function RadioButtonGroup(...parameters)
		{
			if (parameters.length == 0)
			{
				cellList.push(new RadioButtonCell("与",true),new RadioButtonCell("或"));
			}
			else
			{
				for each(var s:String in parameters)
				{
					cellList.push(new RadioButtonCell(s));
				}
			}
			
			var i:int = 0;
			for each(var gb:RadioButtonCell in cellList)
			{
				addChild(gb);
				gb.y = i*22;
				gb._index = i;
				i++;
				gb.addEventListener(MouseEvent.CLICK,
					function onClickGroupCell(e:MouseEvent):void
					{
						SetCombo(e.currentTarget._index);
					});
			}
		} 
		
		public function SetCombo(idx:int):void
		{
			selectIndex = idx;
			for each(var gb:RadioButtonCell in cellList)
			{
				gb.SetCombo(gb._index == idx);
			}
		}
	}
}

