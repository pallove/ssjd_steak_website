package g1.common.components
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-5-10 下午04:36:21
	 *		@说       明: list项显示器
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class ItemRender extends Sprite
	{
		protected var _data:Object;
		private var _selected:Boolean;
		public var l_root:MyList;
		
		public function ItemRender()
		{
			super();
			init();
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
		}

		public function init():void
		{
		
		}
		
		public function mouseDownHandler(event:MouseEvent):void
		{
		   if(l_root!=null)
			   l_root.itemClickHandler(this);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
//			this.filters = [new GlowFilter(0xffcc00,1,4,4,8,1,true)];
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			this.filters = null;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(value)
			{
			  selectEffect();
			}else
			{
			  cancelSelectEffect();
			}
		}
		
		protected function selectEffect():void
		{
//			this.filters = [new GlowFilter(0xffcc00,1,4,4,8,1,true)];
		}
		
		protected function cancelSelectEffect():void
		{
			this.filters = null;
		}
	}
}