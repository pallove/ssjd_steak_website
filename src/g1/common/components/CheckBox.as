package g1.common.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import g1.common.resource.ResourceManager;
	import g1.common.utils.Reflection;

	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-5-14 上午11:35:30
	 *		@说       明: 自定义复选框
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	public class CheckBox extends Sprite
	{
		private var _checkBoxMc:MovieClip
		private var _checked:Boolean;
		private var itemName_txt:TextField;
		
		//设置点击
		public function set Checked(check:Boolean):void
		{
			if(_checked==check)return;
			if(_checkBoxMc != null){
				if(!check)
					_checkBoxMc.gotoAndStop(1);
				else
					_checkBoxMc.gotoAndStop(2);
			}
			this._checked = check;
			
			dispatchEvent(new Event(Event.CHANGE)); 
		}
		
		//获得点击
		public function get Checked():Boolean
		{
			return this._checked;
		}
		
		//够造
		public function CheckBox(display:MovieClip,str:String="")
		{
			super();
			
			_checkBoxMc = display;
			if(!_checked)
				_checkBoxMc.gotoAndStop(1);
			else
				_checkBoxMc.gotoAndStop(2);
			_checkBoxMc.buttonMode = true;
			this.addChild(_checkBoxMc)
			
			if(_checkBoxMc.txt)
			{
				itemName_txt = _checkBoxMc.txt;
				itemName_txt.defaultTextFormat = TextFiledConst.normal_left_fmt;
				// Font Replacement
				itemName_txt.selectable = false;
				itemName_txt.mouseEnabled = false;
				itemName_txt.htmlText = str;
			}

			_checkBoxMc.addEventListener(MouseEvent.CLICK,oncheck);	
		}
		
		private function oncheck(e:MouseEvent):void
		{
			if(Checked) Checked = false;
			else Checked = true;
		}
	}
}