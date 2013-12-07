package g1.common.utils
{
	import flash.geom.Point;

	/**
	 *  取得地图块以螺旋方式加载先后的列表
	 */ 
	public class Spiral
	{
		public function Spiral(sizeX:int, sizeY:int)
		{
			this.sizeX = sizeX;
			this.sizeY = sizeY;
		}
		
		public function boundary(x:int, y:int):Boolean
		{
			return 0 <= x && x < sizeX && 0 <= y && y < sizeY;
		}
		
		public function reset() : void
		{
			size = 0;
			i = 1;
			j = 0;
			count = 0;
		}
		
		// dir: 0 = Right, 1 = Down, 2 = Left, 3 = Up
		public function roll(centerX:int, centerY:int, dir:int):void
		{
			isFirstPoint = true;
			
			curDir = dir;
			startX = nowX = centerX;
			startY = nowY = centerY;
			dir = dir;
			countDir();
		}
		
		public function isEnd() : Boolean
		{
			return count >= (sizeX * sizeY) - 1;
		}
		
		public function next() : Point
		{
			if(isFirstPoint){
				isFirstPoint = false;
				resultPos.x = startX;
				resultPos.y = startY;
				return resultPos;
			}
			
			return doI();
		}
		
		private function doI() : Point
		{
			nowDir = (curDir + i) % 4;
			
			if(j >= size){
				j = 0;
				if(i >= 4){
					i = 1;
					countDir();
				}else{
					i++;
				}
				return doI();
			}else{
				j++;
				return doJ();
			}
			
			return null;
		}
		
		private function doJ() : Point
		{
			nowX += dx[nowDir];
			nowY += dy[nowDir];
			
			if (count >= (sizeX * sizeY) - 1){
				return null;
			}
			
			if (boundary(nowX, nowY)) {
				count++;
				return new Point(nowX,nowY);
			}else{
				return doI();
			}
			
			return null
		}
		
		private function countDir() : void{
			nowX += dx[dir];
			nowY += dy[dir];
			nowX -= dx[(dir + 1) % 4];
			nowY -= dy[(dir + 1) % 4];
			size += 2;
		}
		
//		public function rolls(centerX:int, centerY:int, dir:int):Vector.<Point>
//		{
//			var curDir:int = dir;
//			var nowDir:int;
//			var nowX:int = centerX;
//			var nowY:int = centerY;
//			var size:int = 0;
//			var i:int = 0, j:int = 0;
//			
//			result = new Vector.<Point>();
//			result.push(new Point(nowX, nowY));
//			
//			while (true)
//			{
//				nowX += dx[dir];
//				nowY += dy[dir];
//				nowX -= dx[(dir + 1) % 4];
//				nowY -= dy[(dir + 1) % 4];
//				size += 2;
//				for (i = 1; i <= 4; i++)
//				{
//					nowDir = (curDir + i) % 4;
//					for (j = 0; j < size; j++)
//					{
//						nowX += dx[nowDir];
//						nowY += dy[nowDir];
//						
//						if (count >= (sizeX * sizeY) - 1){
//							return result;
//						}
//						
//						if (boundary(nowX, nowY)) {
//							result.push(new Point(nowX, nowY));
//							count++;
//							continue;
//						}
//					}
//				}
//			}
//			return result;
//		}
		
//		private var result	: Vector.<Point>;
		private var curDir	: int;
		private var nowDir	: int;
		private var nowX	: int;
		private var nowY	: int;
		private var size	: int;
		private var i		: int;
		private var j		: int;
		private var dir	: int;
		private var count	: int = 0;
		private var sizeX	: int, sizeY:int; 
		private static const dx:Array = [1, 0, -1, 0];
		private static const dy:Array = [0, 1, 0, -1];
		private static var resultPos : Point = new Point();
		
		private var isFirstPoint : Boolean;
		private var startX : int;
		private var startY : int;
	}
}