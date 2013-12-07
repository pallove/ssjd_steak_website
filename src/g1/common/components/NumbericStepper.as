package g1.common.components
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import g1.common.utils.Reflection;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-4-12 下午03:03:12
	 *		@说       明: 自定义数字增减器 
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class NumbericStepper extends Sprite
	{
		public static const CHANGE:String = "change";
		protected var backGround:MovieClip;
		public var numTxt:TextField;     //数值文本
		public var addBtn:SimpleButton;  //加按钮
		public var cutBtn:SimpleButton;  //减按钮
		public var minNum:int;           //最小值
		public var maxNum:int;           //最大值
		public var duration:int;         //增加幅度
		private var _value:int;           
		
		public function NumbericStepper(minNum:int,maxNum:int,interval:int)
		{
			this.minNum = minNum;
			this.maxNum = maxNum;
			this.duration = interval;
			initUI();
			addEvent();
	        value = 1;
		}
		
		public function initUI():void
		{
			backGround = Reflection.createDisplayObjectInstance("NumbericStepper") as MovieClip;
			numTxt = backGround.numTxt;
			numTxt.restrict = "0-9";
			numTxt.defaultTextFormat = TextFiledConst.normal_center_fmt;
			numTxt.text = minNum.toString();
			this.addChild(backGround);
			
			cutBtn = backGround.cutBtn as SimpleButton;
			addBtn = backGround.addBtn as SimpleButton;
		}
		
		protected function addEvent():void
		{
			numTxt.addEventListener(MouseEvent.MOUSE_DOWN,txtHandler);
			numTxt.addEventListener(Event.CHANGE,txtChangeHandler);
		    cutBtn.addEventListener(MouseEvent.MOUSE_DOWN,cutHandler);
		    addBtn.addEventListener(MouseEvent.MOUSE_DOWN,addHandler);
		}
		
		/**
		 * 防止点击拖动 
		 * @param event
		 * 
		 */
		private function txtHandler(event:MouseEvent):void
		{
		   event.stopPropagation();
		}
		
		private function txtChangeHandler(event:Event):void
		{
		   value = int(numTxt.text);
		}
		
		private function cutHandler(event:MouseEvent):void
		{
			event.stopPropagation()
			if(value-duration<=minNum)
				value = minNum;
			else
				value -= duration;
		}
		
		private function addHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			if((value+duration)>=this.maxNum)
				value = maxNum;
			else
				value += duration;
		}

		public function get value():int
		{
			return this._value;
		}

		public function set value(value:int):void
		{
			this._value = value;
			if(numTxt)numTxt.text = value.toString();
			this.dispatchEvent(new Event(CHANGE));
		}
	}
}