package g1.common.utils
{
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * 针对可视对象DisplayObject的常用操作
	 * 
	 * 1.function  removeAllChild()   移除所有子对象
	 * 2.function  moveTopZ()         将显示对象移至容器顶端
	 * 3.function  setMouseEnabled()  设置对象是否接受鼠标事件
	 * 4.function  setMouseHand()     是否支持鼠标按键并显示手型
	 * 5.function isVisibleOnScreen   检测对象是否在屏幕中
	 * 6.function cloneDisplayObject  复制显示对象
	 * 7.function getStageScale       获取舞台缩放比
	 * 8.function scaleAt             自定义注册点缩放
	 * 9.function rotateAt            自定义注册点旋转
	 * 10.
	 * 11.
	 * 12.
	 */
	public class DisplayObjectKit
	{
		public function DisplayObjectKit()
		{
		}
		
		/**
		 * 移除所有子对象
		 * @param value	目标
		 * 
		 */
		public static function removeAllChild(value:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < value.numChildren; i++) value.removeChildAt(0); 
		}
		
		/**
		 * 将显示对象移至容器顶端
		 * @param displayObj	目标
		 * 
		 */        
		public static function moveTopZ(value:DisplayObject):void
		{
			if (value.parent)
			{
				var parent:DisplayObjectContainer = value.parent;
				if (parent.getChildIndex(value) < parent.numChildren - 1)
					parent.setChildIndex(value, parent.numChildren - 1);
			}
		}
		/**
		 * 设置对象是否接受鼠标事件
		 * 
		 */        
		public static function setMouseEnabled(value:InteractiveObject,bool:Boolean):void
		{
			value.mouseEnabled = bool;
			if(value is Sprite)Sprite(value).mouseChildren=bool;
		}
		
		/**
		 * 是否支持鼠标按键并显示手型
		 * @param	value
		 * @param	bool
		 */
		public static function setMouseHand(value:Sprite, bool:Boolean):void {
			value.mouseChildren = value.mouseEnabled =	value.useHandCursor=bool
		}
		
		/**
		 * 检测对象是否在屏幕中
		 * @param displayObj	显示对象
		 * 
		 */
		public static function isVisibleOnScreen(displayObj:DisplayObject):Boolean
		{
			if (displayObj.stage == null)
				return false;
			var screen:Rectangle = new Rectangle(0,0,displayObj.stage.stageWidth,displayObj.stage.stageHeight)				
			return screen.containsRect(displayObj.getBounds(displayObj.stage));
		}
		
		
		/**
		 * 复制显示对象
		 * 
		 * @param v
		 * 
		 */
		public static function cloneDisplayObject(v:DisplayObject):DisplayObject
		{
			if(v==null) return null;
			var result:DisplayObject = v["constructor"]();
			result.filters = result.filters;
			result.transform.colorTransform = v.transform.colorTransform;
			result.transform.matrix = v.transform.matrix;
			if (result is Bitmap)
				(result as Bitmap).bitmapData = (v as Bitmap).bitmapData;
			return result;
		}
		
		
		/**
		 * 获取舞台缩放比
		 *  
		 * @param displayObj
		 * @return 
		 * 
		 */
		public static function getStageScale(displayObj:DisplayObject):Point
		{
			var currentTarget:DisplayObject = displayObj;
			var scale:Point = new Point(1.0,1.0);
			
			while (currentTarget && currentTarget.parent != currentTarget)
			{
				scale.x *= currentTarget.scaleX;
				scale.y *= currentTarget.scaleY;
				currentTarget = currentTarget.parent;
			}
			return scale;
		}
		
		
		/**
		 * 自定义注册点缩放
		 * 
		 * @param displayObj	显示对象
		 * @param scaleX	缩放比X
		 * @param scaleY	缩放比Y
		 * @param point	新的注册点（相对于原注册点的坐标）
		 * 
		 */        
		public static function scaleAt(displayObj:DisplayObject,scaleX:Number,scaleY:Number,point:Point=null):void   
		{   
			if(displayObj==null) return;
			if (!point)	point = new Point();
			
			var m:Matrix = displayObj.transform.matrix;
			m.translate(-point.x,-point.y);  
			m.a = scaleX;
			m.d = scaleY;
			m.translate(point.x,point.y);   
			displayObj.transform.matrix = m;
		}
		
		/**
		 * 自定义注册点旋转
		 * 
		 * @param displayObj	显示对象
		 * @param angle	旋转角度（0 - 360）
		 * @param point	新的注册点（相对于原注册点的坐标）
		 * 
		 */								
		public static function rotateAt(displayObj:DisplayObject,angle:Number,point:Point=null):void   
		{   
			if(displayObj==null) return;
			if (!point) point = new Point();
			
			var m:Matrix = new Matrix();
			m.translate(-point.x, -point.y); 
			m.rotate(angle / 180 * Math.PI);
			m.translate(point.x, point.y);  
			displayObj.transform.matrix = m;
		}
		
		/**
		 * 水平翻转
		 */
		public static function flipH(displayObj:DisplayObject):void
		{
			if(displayObj==null) return;
			var m:Matrix = displayObj.transform.matrix.clone();
			m.a = -m.a;
			displayObj.transform.matrix = m;
		}
		
		/**
		 * 垂直翻转
		 */		
		public static function flipV(displayObj:DisplayObject):void
		{
			if(displayObj==null) return;
			var m:Matrix = displayObj.transform.matrix.clone();
			m.d = -m.d;
			displayObj.transform.matrix = m;
		}
		
		/**
		 * 斜切
		 * 
		 * @param displayObj
		 * 
		 */
		public static function skew(displayObj:DisplayObject,dx:Number = 0,dy:Number = 0):void
		{
			if(displayObj==null) return;
			var rect:Rectangle = displayObj.getRect(displayObj);
			
			var m:Matrix = displayObj.transform.matrix.clone();
			m.c = Math.tan(Math.atan2(dx,rect.height));
			m.b = Math.tan(Math.atan2(dy,rect.width));
			displayObj.transform.matrix = m;
		}
		
		
		/**
		 *   对容器内的所有child进行Y坐标排序 
		 * 
		 */	
		public static function orderChildrenIndexByY(dispCt:DisplayObjectContainer):void
		{
			if(dispCt==null || dispCt.numChildren<2) return;
			
			var ary:Array=[];
			for(var i:int=0;i<dispCt.numChildren;i++){
				ary.push(dispCt.getChildAt(i));
			}
			ary = ary.sortOn("y",Array.NUMERIC);
			
			removeAllChild(dispCt);
			
			for each(var child:* in ary)
			{
				dispCt.addChild(child);
			}
			
			ary = null;
			dispCt = null;
		}		
	}
}