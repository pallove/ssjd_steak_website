package g1.common.components
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import g1.common.utils.Reflection;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-5-18 下午02:48:59
	 *		@说       明: 分页栏
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class Pager extends Sprite
	{
		public static const PAGE_CHANGE:String = 'pagechange';
		public var txtPage:TextField;  //页码显示
		public var preBtn:MovieClip; //上一页按钮
		public var nextBtn:MovieClip;  //下一页按钮
		
		private var _current:int=1;
		private var _total:int = 1;
		
		public function Pager()
		{
			super();
			init();
			registerEvent();
			updatePager();
		}
		
		protected function init():void
		{
			preBtn =new (Reflection.getClass("ItemBtn") as Class);
			preBtn.name = "preBtn";
			preBtn.buttonMode = true;
			preBtn.textF.text = "上一页";
			preBtn.width = 70;
			preBtn.textF.autoSize = TextFieldAutoSize.CENTER;
			preBtn.mouseChildren = false;
			addChild(preBtn);

			txtPage = new TextField();
			txtPage.selectable = false;
			txtPage.defaultTextFormat = TextFiledConst.normal_center_fmt;
			txtPage.setTextFormat(TextFiledConst.normal_center_fmt);
			txtPage.autoSize = TextFieldAutoSize.LEFT;
			txtPage.width = 60;
			this.addChild(txtPage);
			txtPage.x = 80;
			
			nextBtn =new (Reflection.getClass("ItemBtn") as Class);
			nextBtn.name = "nextBtn";
			nextBtn.buttonMode = true;
			nextBtn.textF.text = "下一页";
			nextBtn.width = 70;
			nextBtn.textF.autoSize = TextFieldAutoSize.CENTER;
			nextBtn.mouseChildren = false;
			addChild(nextBtn);
			nextBtn.x = 120;
		}
		
		protected function registerEvent():void
		{
			this.preBtn.addEventListener(MouseEvent.CLICK,btnPrev_clickHandler);
			this.nextBtn.addEventListener(MouseEvent.CLICK,btnNext_clickHandler);
		}
		
		protected function updatePager():void
		{
			if(_current>1)
			{
				preBtn.filters = null;
				preBtn.mouseEnabled = true;
				preBtn.mouseChildren = true;
				if(preBtn.hasOwnProperty("label"))
					preBtn.label.mouseEnabled = false;
			}else{
				setGray(preBtn);
				preBtn.mouseEnabled = false;
				preBtn.mouseChildren = false;
			}
			
			if(_current < _total)
			{
				nextBtn.filters = null;
				nextBtn.mouseEnabled = true;
				nextBtn.mouseChildren = true;
				if(nextBtn.hasOwnProperty("label"))
					nextBtn.label.mouseEnabled = false;
			}else{
				setGray(nextBtn);
				nextBtn.mouseEnabled = false;
				nextBtn.mouseChildren = false;
			}

			txtPage.text = _current + "/" + _total;
		}
		
		public function setPageTxtColor(color:uint):void
		{
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.color = color;
			txtFormat.size = 14;
			txtFormat.bold = true;
			txtFormat.align = TextFormatAlign.CENTER;
			this.txtPage.defaultTextFormat = txtFormat;
			this.txtPage.setTextFormat(txtFormat);
		}
		
		protected function setGray(display:DisplayObject):void
		{
			var mat:Array =[0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0,0,0,1,0];
			display.filters = [new ColorMatrixFilter(mat)];
		}
		
		protected function btnPrev_clickHandler(event:MouseEvent):void
		{
			current--;
			dispatchEvent(new Event(PAGE_CHANGE));
		}
		
		protected function btnNext_clickHandler(event:MouseEvent):void
		{
			current++;
			dispatchEvent(new Event(PAGE_CHANGE));
		}

		public function get current():int
		{
			return _current;
		}

		public function set current(value:int):void
		{
			_current = value;
			updatePager();
		}

		public function get total():int
		{
			return _total;
		}

		public function set total(value:int):void
		{
			_total = value<1?1:value;
			updatePager();
		}

	}
}