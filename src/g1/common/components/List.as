package g1.common.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Video;
	
	import g1.common.resource.ResourceManager;
	import g1.common.utils.Reflection;

	public class List extends Box
	{
		private var listBox:Box=new Box();
		private var _dataProvide:Object;         							 //数据源
		private var _labelField:String="default";							 //绑定数据索引
		private var $width:Number=50;										 //列表宽
		private var $height:Number=21;										 //列表高
		private var _Background:DisplayObjectContainer;				     //下拉列表背景
		private var useColor:Boolean=false;								 //是否使用颜色作为背景
		private var _backgroundColor:uint=0x1E0706;						 //背景颜色			
		public var combox:ComboBox;
		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			useColor=true;
			_backgroundColor = value;
			updateBackground();
		}

		public function get Background():DisplayObjectContainer
		{
			return _Background;
		}

		public function set Background(value:DisplayObjectContainer):void
		{
			useColor=false;
			_Background = value;
			updateBackground();
		}

		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			$height = value;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return $width;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			$width = value;
			updateList();
		}
		
		//显示内容
		
		public function get labelField():String
		{
			return _labelField;
		}

		public function set labelField(value:String):void
		{
			_labelField = value;
		}

		public function get dataProvide():Object
		{
			return _dataProvide;
		}
		
		public function set dataProvide(value:Object):void
		{
			_dataProvide = value;
			switch(typeof(_dataProvide))
			{
				case "object":
				{
					setDataAsArray();
					break;
				}
				case "xml":
				{
					setDataAsXml();
					break;
				}
				case "xmllist":
				{
					setDataAsXmlList();
					break;
				}
			}
		}
		
		public function List()
		{
			super();
			listBox.Layout="Vertical";
			listBox.gap=0;
			listBox.mouseEnabled=false;
			this.addChild(listBox);
			this.mouseEnabled=false;
		}
		
		/**
		 *数组方法 
		 */
		private function setDataAsArray():void
		{
			var _arr:Array=dataProvide as Array;
			var obj:Object;
			for (var i:int = 0; i < _arr.length; i++) 
			{
			    obj = _arr[i];
				if(obj==null)continue;
				addItem(_arr[i]);
			}
			
		}
		
		/**
		 *XML方法 
		 */
		private function setDataAsXml():void
		{
			var _xml:XML=dataProvide as XML;
		}
		
		/**
		 *XMLlist方法 
		 */
		private function setDataAsXmlList():void
		{
			var _xmllist:XMLList=dataProvide as XMLList;
			for each(var xml:XML in _xmllist)
			{
			    var item:ListItem = new ListItem();
				item.width=$width; 
				item.data = xml;
				item.labelField = xml.@label;
				listBox.addChild(item);
				updateBackground();
			}
		}
		
		/**
		 *添加项 
		 */
		public function addItem(obj:Object):void
		{
			var item:ListItem=new ListItem();
			item.itemLabel.textView.textColor = combox.textView.textView.textColor;
			item.itemLabel.textView.filters = combox.textView.textView.filters;
			item.combox = combox;
			item.width=$width;
			item.data=obj;
			item.labelField=obj.label;
			listBox.addChild(item);
			updateBackground();
		}
		
		/**
		 *更新列表 
		 */
		public function updateList():void
		{
			for (var i:int = 0; i < listBox.numChildren; i++) 
			{
				listBox.getChildAt(i).width=$width;
			}
			
		}
		
		/**
		 *更新背景内容 
		 */
		public function updateBackground():void
		{
			this.graphics.clear();
			if(useColor)
			{
				this.graphics.beginFill(backgroundColor);
				this.graphics.drawRect(0,0,this.width,this.height);
				this.graphics.endFill();
			}
			else
			{
				if(Background)
				{
					Background.width=this.width;
					Background.height=this.height;
				}
			}
		}

		
	}
}