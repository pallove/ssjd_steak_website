package g1.common.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ComboBox extends Sprite
	{
		
		private var dropDownList:List;         //下拉列表
		public var textView:Label=new Label();			 //显示文本	
		private var _dropDownLayout:String="Bottom";		 //下拉列表显示位置
		private var _dataProvide:Object;					 //数据源
		private var _openList:Boolean=false;				 //是否显示列表
		private var _selectItem:Object;					 //选中项
		private var _labelField:String="default";			 //绑定数据索引
		private var isSet:Boolean=false;					 //是否被添加到显示列表
		private var _text:String="";						 //显示的文本
		private var _Background:DisplayObjectContainer;	 //下拉列表背景
		private var _backgroundColor:uint=0x1E0706;		 //背景颜色	
		
		private var _dataArr:Array;               

		public function get func():Function
		{
			return _func;
		}

		public function set func(value:Function):void
		{
			_func = value;
		}

		private var _func:Function;						 //外部调用的函数
		
		public function get backgroundColor():uint
		{
			return dropDownList.backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			dropDownList.backgroundColor = value;
		}

		public function get Background():DisplayObjectContainer
		{
			return dropDownList.Background;
		}

		public function set Background(value:DisplayObjectContainer):void
		{
			dropDownList.Background = value;
		}

		public function get text():String
		{
			return textView.text;
		}

		public function set text(value:String):void
		{
			_text = value;
			textView.text = _text;
			
		}

		public function get selectItem():Object
		{
			return _selectItem;
		}

		public function set selectItem(value:Object):void
		{
			_selectItem = value;
			textView.text= value.label;
			//			switch(labelField)
//			{
//				case "default":
//				{
//					textView.text=selectItem.toString();
//					break;
//				}
//					
//				default:
//				{
//					textView.text=selectItem[labelField].toString();
//					break;
//				}
//			}
		}

		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			_labelField = value;
			dropDownList.labelField=_labelField;
		}

		public function get openList():Boolean
		{
			return _openList;
		}

		public function set openList(value:Boolean):void
		{
			_openList = value;
			showAndhide();
		}

		public function get dataProvide():Object
		{
			return _dataProvide;
		}

		public function set dataProvide(value:Object):void
		{
			_dataProvide = value;
			this.dropDownList.dataProvide=_dataProvide;
			setListLayout();
		}

		public function get dropDownLayout():String
		{
			return _dropDownLayout;
		}

		public function set dropDownLayout(value:String):void
		{
			_dropDownLayout = value;
			setListLayout();
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
			dropDownList.width=value;
		}
		
		public function ComboBox()
		{
			textView.width=50;
			textView.height=30;
			textView.text="NULL";
			textView.mouseEnabled=false;
			
			dropDownList = new List();
			dropDownList.combox = this;
			dropDownList.width=50;
			dropDownList.visible=false;
			dropDownList.labelField=this.labelField;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK,showList);
			this.addChild(textView);	
		}
		
		/**
		 *设置下拉列表显示位置 
		 */
		private function setListLayout():void
		{
			switch(dropDownLayout)
			{
				case "Bottom":
				{
					dropDownList.x=this.x;
					dropDownList.y=this.y+textView.height;
					break;
				}
				case "Top":
				{
					dropDownList.x=this.x;
					dropDownList.y=this.y-dropDownList.height;
					break;
				}
			}
		}
	
		/**
		 *展开与关闭列表
		 */
		private function showAndhide():void
		{
			dropDownList.visible=openList;
			setListLayout();
			
		}
		
		/**
		 *点击事件展开列表 
		 */
		private function showList(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			e.stopPropagation();
			if(this.parent!=null || !isSet)
			{
				this.parent.addChild(dropDownList);
				isSet=true;
			}
			this.openList=!openList;
		}
		
		public function itemClickHandler(item:ListItem):void
		{
			if(item==null)return;
			this.selectItem=item.data;
			if(func)
				func(item.data)
			this.openList = false;
		}
	}
}