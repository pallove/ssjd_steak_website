package g1.common.components {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * @author leon.liu
	 */
	public class ScrollBar {
		private var resource:DisplayObjectContainer;
		private static const UP:String = "scrollbar_up";
		private static const DOWN:String = "scrollbar_down";
		private static const DRAGGER:String = "scrollbar_dragger"; 
		private static const SLOT:String = "scrollbar_slot";
		
		private var isStartDrag:Boolean;
		private var dragger:InteractiveObject;
		private var slot:DisplayObject;
		private var up:InteractiveObject;
		private var down:InteractiveObject;
		private var dragBound:Object;
		private var content:DisplayObject;
		private var mask:Shape;
		private var showScrollAways:Boolean;
		
		
		
		public function ScrollBar(res:DisplayObjectContainer) {
			this.resource = res;
			
			registerEvent();
			//
			
		}
		
		/**
		 * 总是显示滚动条
		 */
		public function showScrollBarAways(value : Boolean) : void
		{
			showScrollAways = value;
		}
		
		public function getView():DisplayObjectContainer {
			return resource;
		}

		private function registerEvent() : void {
			up = resource.getChildByName(UP) as InteractiveObject;
			up.addEventListener(MouseEvent.CLICK, __onScrollUp);
			down = resource.getChildByName(DOWN) as InteractiveObject;
			down.addEventListener(MouseEvent.CLICK, __onScrollDown);
			
			dragger = resource.getChildByName(DRAGGER) as InteractiveObject;
			dragger.addEventListener(MouseEvent.MOUSE_DOWN, __onDraggerStart);
			
			slot = resource.getChildByName(SLOT);
		}
		
		// start drag
		private function __onDraggerStart(event : MouseEvent) : void {
			isStartDrag = true;
			if (resource.stage) {
				var clickPt:Point = dragger.globalToLocal(new Point(event.stageX, event.stageY));				
				var stage:Stage = resource.stage;
				var moveFunc:Function;
				
				stage.addEventListener(MouseEvent.MOUSE_MOVE, moveFunc = function(e:MouseEvent):void {
					
					var localPt:Point = resource.globalToLocal(new Point(e.stageX - clickPt.x, e.stageY - clickPt.y));
					
					var aimY:int;
					 if (localPt.y < dragBound.topY) {
						 
						aimY = dragBound.topY;
						
					 }
					 else if (localPt.y > dragBound.buttomY) {
						aimY = dragBound.buttomY;
					 }
					 else {
						aimY = localPt.y;
					 }
					 dragger.y = aimY;
					 moveContent();
				});
				
				stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void {
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveFunc);
					stage.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee);
				});
			}
		}
		
		/**
		 * 更新内容大小
		 */
		public function updateSize():void {
			if (mask.height > content.height) {
				resource.visible = showScrollAways ? true : false;
			}
			else {
				resource.visible = true;
			}
			
			dragger.visible = ((int(content.height) - mask.height) <= 0) ? false : true;

			var draggerSize:Number = (content.height - mask.height) / slot.height;
			if (draggerSize < 20) draggerSize = 20;
			dragger.height = draggerSize;
		}
		
		/**
		 * 计算移动内容
		 */
		private function moveContent() : void {
			var ratio:Number = (dragger.y-up.height) / (slot.height - dragger.height);
			var ammount:int = -Math.round(ratio * (content.height - mask.height)); 
			content.y = adjustContent(ammount);
		}
		/**
		 * 计算dragger位置 
		 */
		private function moveDragger():void {
			var ratio:Number = -content.y / (content.height - mask.height);
			var ammount:int = Math.ceil(ratio * (slot.height - dragger.height));
			dragger.y = adjustDragger(ammount)+up.height;
		}

		/**
		 * 向上滚动
		 */
		private function __onScrollUp(event : MouseEvent) : void {
			if((content.height - mask.height) <= 0) return;
			
			content.y = adjustContent(content.y + 5);
			moveDragger();
		}
		
		
		/**
		 * 向下滚动
		 */
		private function __onScrollDown(event : MouseEvent) : void {
			if((content.height - mask.height) <= 0) return;
			
			content.y = adjustContent(content.y - 5);
			moveDragger();
		}		
		
		/**
		 * 重调整后content的y值
		 */
		private function adjustContent(ammount:int) : int {
			if (ammount >0) {
				return 0;
			}
			else if (ammount < -(content.height - mask.height))
			{
				return -(content.height - mask.height);
			}
			else {
				return ammount;
			}
		}
		
		/**
		 * 重调整后dragger的y值 
		 */
		private function adjustDragger(ammount:int):int {
			if (ammount < 0) {
				return 0;
			}
			else if (ammount >slot.height - dragger.height)
			{
				return slot.height - dragger.height;
			}
			else {
				return ammount;
			}			
		}
		
		private function setDragBound(x : Number, y : Number, x1 : Number, y1 : Number) : void {
			dragBound = {topX:x, topY:y, buttomX:x1, buttomY:y1};
		}
		
		public function setViewport(w:Number, h:Number):void {
			mask.width = w;
			mask.height = h;
			
			adjustBar();
			updateSize();

			if (content) {
				content.addEventListener(Event.RESIZE, function(e:Event):void
				{
					adjustBar();
					updateSize();
				});
			}
		}
		
		/**
		 * 调整滚动条高及位置
		 */
		private function adjustBar() : void 
		{
			slot.y = up.height;
			slot.height = mask.height - up.height - down.height;
			
			down.y = slot.y + slot.height;
			setDragBound(slot.x, slot.y, slot.x, slot.y + slot.height - dragger.height);
		}
		
		public function setContent(content:DisplayObject):void {
			this.content = content;
			
			
			if (content.parent) {
				__onContentInStage(null);
			}
			else {
				content.addEventListener(Event.ADDED_TO_STAGE, __onContentInStage);
			}
		}

		private function __onContentInStage(event : Event) : void {
			createMask();
			content.parent.addChild(mask);
			mask.x = content.x;
			mask.y = content.y;
			content.mask = mask;
		}
		
		
		public function scrollTop():void {
			content.y = 0;
			moveDragger();
		}
		
		public function scrollButtom():void {
			content.y = -(content.height - mask.height);
			moveDragger();
		}
		
		public function createMask():void {
			mask = new Shape();
			mask.graphics.beginFill(0x05ee0000);
			mask.graphics.drawRect(0, 0, 1, 1);
			mask.graphics.endFill();
		}
		
		/**
		 * 设置滑块对应的位置 
		 * @param y
		 * 
		 */
		public function setScrollPos(y:Number):void
		{
			content.y = adjustContent(-y);
			moveDragger();	
		}
	}
}