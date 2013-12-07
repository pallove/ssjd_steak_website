package g1.common.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import g1.common.utils.Reflection;
	
	public class ListItem extends Sprite
	{
		public var itemLabel:Label=new Label();        				//列表单元文本域
		private var _labelField:String="default";						//显示内容
		private var _data:Object;										//数据
		private var _backGround:MovieClip = Reflection.createDisplayObjectInstance("comboxBG") as MovieClip; //背景
		public var combox:ComboBox;
		
		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			_labelField = value;
			setText();
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
			setText();
		}

		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return itemLabel.height;
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			itemLabel.height = value;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return itemLabel.width;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			itemLabel.width = value;
			_backGround.width = value;
		}
		
		public function ListItem()
		{
			this.addChild(_backGround);
			this.addChild(itemLabel);
			this.buttonMode=true;
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseClickHandler);
//			this.addEventListener(MouseEvent.ROLL_OVER,mouseOver);
		}
		
		/**
		 *设置文本  支持数据本地化待扩展
		 */
		public function setText(str:String=""):void 
		{
			itemLabel.text=str;
			if(labelField=="default")
			{
//				itemLabel.text+=_data.toString();
			}
			else
			{
				itemLabel.text=_data.label;
//				if(_data[_labelField]==null)
//				{
//					itemLabel.text+="null";
//				}
//				else
//				{
//					itemLabel.text+=_data[_labelField];
//				}
			}
		}
		private function setBackground(color:uint,alpha:Number=1):void
		{
//			this.graphics.clear();
//			this.graphics.beginFill(color,alpha);
//			this.graphics.drawRect(0,0,this.width,this.height);
//			this.graphics.endFill();
		}
		
		private function mouseClickHandler(e:MouseEvent):void
		{
			if(combox != null)
			{
				combox.itemClickHandler(this);
			}
		}
		
//		private function mouseOver(e:MouseEvent):void
//		{
//			setBackground(0xaacc00);
//			this.addEventListener(MouseEvent.ROLL_OUT,mouseOut);
//		}
//		
//		private function mouseOut(e:MouseEvent):void
//		{
//			setBackground(0xffffff,0);
//			this.removeEventListener(MouseEvent.ROLL_OUT,mouseOut);
//		}

	}
}