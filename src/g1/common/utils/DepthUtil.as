package g1.common.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-5-8 上午09:41:25
	 *		@说       明: UI深度管理类
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class DepthUtil
	{
		public function DepthUtil()
		{
		}
		
		/**
		 * 深度判断 
		 * @param obj1
		 * @param obj2
		 * @return 
		 * 
		 */
		public static function isBelow(obj1:DisplayObject, obj2:DisplayObject):Boolean
		{
			if(obj1.parent == obj2.parent)
			{
			   return obj1.parent.getChildIndex(obj1)<obj1.parent.getChildIndex(obj2);
			}else
			{
				  var p_arr1:Array = getParents(obj1);
				  var p_arr2:Array = getParents(obj2);
				  
				  var dis1:DisplayObjectContainer;
				  var dis2:DisplayObjectContainer;
				  var index1:int;
				  var index2:int;
				  var child1:DisplayObject;
				  var child2:DisplayObject;
				  
				  for(var i:int=0;i<p_arr1.length;i++)
				  {
					  dis1 = p_arr1[i].parent as DisplayObjectContainer;
				     for(var j:int=0;j<p_arr2.length;j++)
					  {
						dis2 = p_arr2[j].parent as DisplayObjectContainer;
						if(dis1==dis2)
						{
						    child1 = p_arr1[i].child as DisplayObject;
							index1 = dis1.getChildIndex(child1);
							child2 = p_arr2[j].child as DisplayObject;
							index2 = dis2.getChildIndex(child2);
							return index1<index2;
						}
					  }
				  }
			  }
	
			return false;
		}
		
		public static function getParents(obj:DisplayObject):Array
		{
			var arr:Array = [];
			var temp:DisplayObject = obj;
			while(temp.parent)
			{
				arr.push({parent:temp.parent,child:temp});
				temp = temp.parent;
			}
			return arr;
		}
	}
}