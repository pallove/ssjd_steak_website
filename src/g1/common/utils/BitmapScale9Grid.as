package g1.common.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 改写的可允许位图直接支持9宫格类
	 */	
	public class BitmapScale9Grid extends Sprite
	{
		private var source : Bitmap;
		private var scaleGridTop : Number;
		private var scaleGridBottom : Number;
		private var scaleGridLeft : Number;
		private var scaleGridRight : Number;
		
		private var leftUp : Bitmap;
		private var leftCenter : Bitmap;
		private var leftBottom : Bitmap;
		private var centerUp : Bitmap;
		private var center : Bitmap;
		private var centerBottom : Bitmap;
		private var rightUp : Bitmap;
		private var rightCenter : Bitmap;
		private var rightBottom : Bitmap;
		
		private var _width : Number;
		private var _height : Number;
		
		private var minWidth : Number;
		private var minHeight : Number;
		
		private var _rect:Rectangle
		
		public function BitmapScale9Grid(source:Bitmap, rect:Rectangle) 
		{
			if(rect!=null && source!=null)
			{
				this.mouseChildren = false;
				
				this.source = source;
				if(rect.top<0) rect.top=0; 
				this.scaleGridTop = rect.top;
				
				if(rect.bottom<0) rect.bottom=source.height;
				this.scaleGridBottom = rect.bottom;
				
				if(rect.left<0) rect.left=0;
				this.scaleGridLeft = rect.left;
				
				if(rect.right<0) rect.right=source.width;
				this.scaleGridRight = rect.right;
				init();
			}
			
			
		}
		
		private function init() : void {
			_width = source.width;
			_height = source.height;
			
			leftUp = getBitmap(0, 0, scaleGridLeft, scaleGridTop);
			this.addChild(leftUp);
			
			leftCenter = getBitmap(0, scaleGridTop, scaleGridLeft, scaleGridBottom - scaleGridTop);
			this.addChild(leftCenter);
			
			leftBottom = getBitmap(0, scaleGridBottom, scaleGridLeft, source.height - scaleGridBottom);
			this.addChild(leftBottom);
			
			centerUp = getBitmap(scaleGridLeft, 0, scaleGridRight - scaleGridLeft, scaleGridTop);
			this.addChild(centerUp);
			
			center = getBitmap(scaleGridLeft, scaleGridTop, scaleGridRight - scaleGridLeft, scaleGridBottom - scaleGridTop);
			this.addChild(center);
			
			centerBottom = getBitmap(scaleGridLeft, scaleGridBottom, scaleGridRight - scaleGridLeft, source.height - scaleGridBottom);
			this.addChild(centerBottom);
			
			rightUp = getBitmap(scaleGridRight, 0, source.width - scaleGridRight, scaleGridTop);
			this.addChild(rightUp);
			
			rightCenter = getBitmap(scaleGridRight, scaleGridTop, source.width - scaleGridRight, scaleGridBottom - scaleGridTop);
			this.addChild(rightCenter);
			
			rightBottom = getBitmap(scaleGridRight, scaleGridBottom, source.width - scaleGridRight, source.height - scaleGridBottom);
			this.addChild(rightBottom);
			
			minWidth = leftUp.width + rightBottom.width;
			minHeight = leftBottom.height + rightBottom.height;
		}
		
		private function getBitmap(x:Number, y:Number, w:Number, h:Number) : Bitmap {
			var bit:BitmapData = new BitmapData(w, h);
			bit.copyPixels(source.bitmapData, new Rectangle(x, y, w, h), new Point(0, 0));
			var bitMap:Bitmap = new Bitmap(bit);
			bitMap.x = x;
			bitMap.y = y;
			return bitMap;
		}
		
		override public function set width(w : Number) : void 
		{			
			updateSize(w,_height);
		}
		
		override public function set height(h : Number) : void 
		{
			updateSize(_width,h);
		}
		
		
		/**
		 * 重绘 
		 * 
		 */		
		public function updateSize(w:Number,h:Number) : void 
		{
			if(w < minWidth) {
				w = minWidth;
			}
			_width = w;
			
			if(h < minHeight) {
				h = minHeight;
			}
			_height = h;
			
			leftCenter.height = _height - leftUp.height - leftBottom.height;
			leftBottom.y = _height - leftBottom.height;
			centerUp.width = _width - leftUp.width - rightUp.width;
			center.width = centerUp.width;
			center.height = leftCenter.height;
			centerBottom.width = center.width;
			centerBottom.y = leftBottom.y;
			rightUp.x = _width - rightUp.width;
			rightCenter.x = rightUp.x;
			rightCenter.height = center.height;
			rightBottom.x = rightUp.x;
			rightBottom.y = leftBottom.y;
		}
		
		public function destory():void
		{
			var ary:Array = [leftUp,leftCenter,leftBottom,centerUp,center,centerBottom,rightUp,rightCenter,rightBottom];
			for(var i:uint=0;i<ary.length;i++)
			{
				var bmp:Bitmap = ary[i] as Bitmap;
				bmp.bitmapData.dispose();
				bmp.bitmapData = null;
				bmp = null;
			}
		}
	}

}