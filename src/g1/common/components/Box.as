package g1.common.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 yejun 2012.1 布局控件
	 **/
	public class Box extends Sprite
	{
		private var _gap:int = 0; //按钮间的间隔
		private var _Layout:String = "Horizontal";
		
		public function get Layout():String
		{
			return _Layout;
		}
		
		public function set Layout(value:String):void
		{
			_Layout = value;
			resetChild();
		}
		
		public function get gap():int
		{
			return _gap;
		}
		
		public function set gap(value:int):void
		{
			_gap = value;
		}
		
		public function Box()
		{
			super();
		}
		/**
		 *重写过的addChild方法实现布局
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			// TODO Auto Generated method stub
			var lastchild:DisplayObject;
			if(this.numChildren != 0)
			{
				lastchild = this.getChildAt(this.numChildren-1);
			}
			else 
			{
				
			}
			switch(Layout)
			{
				case "Horizontal":
				{
					if(lastchild != null)	
					{
						child.x = lastchild.x+lastchild.width+gap;
					}
					break;
				}
				case "Vertical":
				{
					if(lastchild != null)	
					{
						child.y = lastchild.y+lastchild.height+gap;
					}
					break;
				}
				default:
				{
					if(lastchild != null)	
					{
						child.x = lastchild.x+lastchild.width+gap;
					}
					break;
				}
			}
			return super.addChild(child);
			
		}
		/**
		 *刷新对象
		 */
		public function resetChild():void
		{
			if(this.numChildren != 0)
			{
				var firstChild:DisplayObject = this.getChildAt(0);
				firstChild.x=0;
				firstChild.y=0;
				
				for (var i:int = 1; i < this.numChildren; i++) 
				{
					
					var child:DisplayObject = this.getChildAt(i);
					
					switch(Layout)
					{
						case "Horizontal":
						{
							child.x = this.getChildAt(i-1).x+this.getChildAt(i-1).width+gap;
							break;
						}
						case "Vertical":
						{
							child.y = this.getChildAt(i-1).y+this.getChildAt(i-1).height+gap;
							trace((i-1)+"层的高度:"+this.getChildAt(i-1).height);
							break;
						}
						default:
						{
							child.x = this.getChildAt(i-1).x+this.getChildAt(i-1).width+gap;
							break;
						}
					}
				}
				
			}
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			// TODO Auto Generated method stub
			return super.addChildAt(child, index);
			resetChild();
		}
		
		
	}
}