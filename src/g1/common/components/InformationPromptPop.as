package g1.common.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import g1.common.display.LayerManager;
	import g1.common.event.StageEventManager;
	import g1.common.utils.Reflection;
	
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-08-16 下午02:48:59
	 *		@说       明: 信息提示框
	 *
	 *		@作       者: zongpaohuang
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class InformationPromptPop
	{
		public function InformationPromptPop()
		{
			if(s_instance) throw(new Error("InformationPromptPop is a Simple Class!"));
		}
		
		public static function get singleton() : InformationPromptPop
		{
			if(s_instance == null) s_instance = new InformationPromptPop();
			return s_instance;
		}
		
		private function init() : void
		{
			promptMc = new Sprite();
			LayerManager.instance.popLayer.addChild(promptMc);
		    
			roundRect= new (Reflection.getClass("InformationPromptPopUI") as Class);
			promptMc.addChild(roundRect);
			
			contentText = new TextField();
			contentText.x = 10;
			contentText.y = 8;
			contentText.textColor = 0xffffff;
			contentText.selectable = false;
			contentText.wordWrap = true;
			contentText.autoSize = TextFieldAutoSize.LEFT;
			promptMc.addChild(contentText);
			
			setPromtpWidth();
			setVisible(false);
		}
		
		private function setTextLength() : void
		{
			if(roundRect != null && contentText != null && contentStr != "" && contentText.text != null)
			{
				contentText.text = contentStr;
				roundRect.width = Math.floor(contentText.textWidth+ 23);
				roundRect.height = Math.floor(contentText.textHeight + 20);
				promptMc.mouseEnabled = false;
				promptMc.mouseChildren =false;
			}
		}
		
		public function setVisible(booblean:Boolean) : void
		{
			if(promptMc != null)
			{
				promptMc.visible = booblean;
				if(booblean == false)
				{
					promptMc.x = promptMc.y = - StageEventManager.instance.stageWidth;
				}
			}
		}
		
		public function setPromtpWidth(width : Number = 260) : void
		{
			if(contentText != null)contentText.width = width;
		}
		
		public function setPosition(x:Number, y:Number) : void
		{
			if(promptMc != null)
			{
				if(x < StageEventManager.instance.stageWidth - roundRect.width)
				{
					promptMc.x = x + spaceValue;
				}
				else
				{
					promptMc.x = x - roundRect.width - spaceValue - 3;
				}
				
				if(y < StageEventManager.instance.stageHeight - roundRect.height)
				{
					promptMc.y = y + spaceValue;
				}
				else
				{
					promptMc.y = y - roundRect.height - spaceValue;
				}
			}
		}
		
		public function showPromptPopUI(content:String) : void
		{
			if(!firstBoo)
			{
				init();
				firstBoo = true;
			}
			setVisible(true);
			contentStr = content;
			setTextLength();
		}
		
		private static var s_instance : InformationPromptPop;
		private var firstBoo		: Boolean;
		private var promptMc		: Sprite;
		private var roundRect		: MovieClip;
		private var contentText	: TextField;
		private var contentStr		: String;
		private var roundWidth		: uint;
		
		private const spaceValue	: int = 8;
		private const roundHeight	: uint = 30;
	}
}