package g1.common.components
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.object_proxy;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-5-10 下午04:33:32
	 *		@说       明: 自定义list组件
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class MyList extends Sprite
	{
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String = "horizontal";
		
		protected var backGround:DisplayObject;   //背景
		protected var _bgVisible:Boolean;   //背景是否显示
		public var _align:String;              //对齐方式
		public var _itemRenderClass:String;    //数据项
	    public var _gap:int = 3;                  //间隔
		public var _row:int = 1;                  //行数
		public var _column:int = 1;               //列数
		protected var _selectIndex:int=-1;    //当前选中的索引
		protected var _selectItem:ItemRender;  //当前选中项
		
		protected var _dataProvide:Array;         //数据列表
		public var itemList:Array;         //项列表
		
		public var itemClickFunc:Function; //点击事件回调
		
		public function MyList(itemRender:ItemRender,align:String="vertical",row:int=1,col:int=1,backGround:DisplayObject=null)
		{
			super();
			_itemRenderClass = getQualifiedClassName(itemRender);
			this._align = align;
			this._row = row;
			this._column = col;
			this.backGround = backGround;
			init();
			bgVisible = false;
		}
		
		protected function init():void
		{
		   if(backGround==null) //默认状态的背景
		   {
		      var mc:MovieClip = new MovieClip();
			  mc.graphics.lineStyle(0.5,0x996633);
			  mc.graphics.beginFill(0x2E0C0A,1);
			  mc.graphics.drawRoundRect(0,0,100,100,5,5);
			  mc.graphics.endFill();
			  backGround = mc;
		   }
		}
		
		public function itemClickHandler(item:ItemRender):void
		{
			selectItem = item;
			if(itemClickFunc)
				itemClickFunc(item);
		}
		
		public function get dataProvide():Array
		{
			return _dataProvide;
		}

		public function set dataProvide(value:Array):void
		{  
			if(value==null)return;
			
			removeAllChild();
			_dataProvide = value;

			var  clsName:Class = Class(getDefinitionByName(_itemRenderClass));
			var itemRender:ItemRender;
			var index:int;
			if(itemList==null)itemList=[];
			
			if(_align && _align!="")  //有布局的
			{
				for each(var data:Object in value)
				{
					itemRender = new clsName();
					itemRender.data = data;
					itemRender.l_root = this;
					if(_align==VERTICAL)
					{
						itemRender.y = this.height + _gap;
					}else{
						itemRender.x = this.width + _gap;
					}  
					this.addChild(itemRender);
					itemList.push(itemRender);
					index++;
				}
			}else
			{
				for(var i:int=0;i<_row;i++)
				{
					for(var j:int=0;j<_column;j++)
					{
						if(index>=value.length)break;
						itemRender = new clsName();
						itemRender.l_root = this;
						itemRender.data = value[index];
						this.addChild(itemRender);
						itemList.push(itemRender);
						itemRender.x = j*itemRender.width+j*_gap;
						itemRender.y = i*itemRender.height +i*_gap;	
						index++;
					}
				}
			}
			updateDisplay();
		}
		
		protected function updateDisplay():void
		{
			if(!this.contains(backGround)){
				backGround.width = this.width+10;
				backGround.height = this.height+10;
				this.addChild(backGround);
				this.setChildIndex(backGround,0);
			}else{
				backGround.width = this.width+10;
				backGround.height = this.height+10;
			}
		}
		
		protected function removeAllChild():void
		{
			var len:int = this.numChildren;
			while(len--)
			{
				this.removeChildAt(0);
			}
			itemList = null;
			updateDisplay();
		}
		
		/**
		 * 列表清空 
		 * 
		 */
		public function clear():void
		{
			var len:int = this.numChildren;
			while(len--)
			{
				this.removeChildAt(0);
			}
			itemList = null;
			dataProvide = null;
			selectIndex = -1;
			selectItem = null;
			
			updateDisplay();
		}

		public function destroy():void
		{
		   clear();
		}
		
		public function get selectItem():ItemRender
		{
			return _selectItem;
		}

		public function set selectItem(value:ItemRender):void
		{
			_selectItem = value;
			var index:int;
			for each(var item:ItemRender in itemList)
			{
				if(item==value)
				{
					item.selected = true;
					_selectIndex = index;
					if(itemClickFunc)
						itemClickFunc(item);
				}else{ 
					item.selected = false;
				}
				index++;
			}
		}

		public function get selectIndex():int
		{
			return _selectIndex;
		}

		public function set selectIndex(value:int):void
		{
			_selectIndex = value;
			var index:int;
			for each(var item:ItemRender in itemList)
			{
				if(index==value)
				{
					item.selected = true;
					selectItem = item;
					break;
				}else{ 
					item.selected = false;
				}
				index++;
			}
		}

		public function get bgVisible():Boolean
		{
			return _bgVisible;
		}

		public function set bgVisible(value:Boolean):void
		{
			_bgVisible = value;
			backGround.visible = value;
		}
	}
}