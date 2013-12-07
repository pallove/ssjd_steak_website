package g1.common.event
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/********************************************************
	/**
	 * 		@author leon.liu
	 * 		创建时间：	2012-2-28
	 * 		说明：		舞台尺寸改变管理器 
	 *		
	 *
	*******************************************************/		
	public class StageEventManager
	{
		public function StageEventManager()
		{
			if (instance) {
				throw new Error("[StageResizeManager] singleton error!");
			}
			m_eventList = new Vector.<IResizeEvent>();
			m_mouseEventList = new Vector.<IMouseEvent>();
		}
		
		public function init(stage : Stage) : void
		{
			if (!stage) {
				return;
			}
			m_stage = stage;
			//整个窗口最大最小的缩放值
			minSize = new Point(760, 580);
			maxSize = new Point(1160, 600);
			curSize = new Point(0, 0);
			updateCurSize();
			stage.addEventListener(Event.RESIZE, __onStageResize);
			stage.addEventListener(Event.MOUSE_LEAVE, __onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
		}
		
		private function updateCurSize():void
		{
			curSize.x = stage.stageWidth;
			curSize.y = stage.stageHeight;
			m_isSmallScree = false;
			if(m_stage.stageWidth<=minSize.x)
			{
				curSize.x = minSize.x;
				
			}
			if(m_stage.stageWidth<=maxSize.x)
			{
				m_isSmallScree = true;
			}
			if(m_stage.stageHeight<=minSize.y)
			{
				curSize.y = minSize.y;
				//m_isSmallScree = true;
			}
			if(m_stage.stageHeight<=maxSize.y)
			{
				m_isSmallScree = true;
			}
		}
		
		private function __onMouseDown(e : Event) : void
		{
			var size : int = m_mouseEventList.length;
			for(var i : int = 0; i < size; i++) {
				m_mouseEventList[i].mouseEvent(true);
			}				
			m_isMousePressed = true;			
		}
		
		private function __onMouseUp(e : Event) : void
		{
			var size : int = m_mouseEventList.length;
			for(var i : int = 0; i < size; i++) {
				m_mouseEventList[i].mouseEvent(false);
			}					
			m_isMousePressed = false;			
		}
		
		public function isMousePressed() : Boolean
		{
			return m_isMousePressed;
		}
		
		public function resize() : void
		{
			__onStageResize(null);
		}
		
		protected function __onStageResize(event:Event):void
		{
			updateCurSize();
			for(var i : int = 0; i < m_eventList.length; i++) {
				m_eventList[i].onResize(curSize.x, curSize.y);
			}
		}
		
		public function addMouseEventListener(event : IMouseEvent) : void
		{
			if (m_mouseEventList.indexOf(event) != -1) return;
			
			m_mouseEventList.push(event);
		}
		
		public function removeMouseEventListener(event : IMouseEvent) : void
		{
			var index : int;
			if ((index = m_mouseEventList.indexOf(event)) != -1)
				m_mouseEventList.splice(index, 1);
		}
		
		public function addEventListener(event : IResizeEvent) : void
		{
			if (m_eventList.indexOf(event) != -1) return;
			
			m_eventList.push(event);    ////第一次event=loginModule.as
		}
		
		public function removeEventListener(event : IResizeEvent) : void
		{
			var index : int;
			if ((index = m_eventList.indexOf(event)) != -1)
				m_eventList.splice(index, 1);
		}
		
		public function centerDisplayObject(displayObject : DisplayObject) : void
		{
			if (displayObject) {
				displayObject.x = (stageWidth - displayObject.width) >> 1;
				displayObject.y = (stageHeight - displayObject.height) >> 1;
			}
		}
		
		public static function get instance() : StageEventManager
		{
			return s_instance;
		}
		
		public function get stageWidth() : int
		{
			return curSize.x;
		}
		
		public function get stageHeight() : int
		{
			return curSize.y;
		}
		
		public function get stageMouseX() : int
		{
			return m_stage.mouseX;
		}
		
		public function get stageMouseY() : int
		{
			return m_stage.mouseY;
		}
		
		public function get stage() : Stage
		{
			return m_stage;
		}
		
		public function isSamllScreen():Boolean
		{
			return m_isSmallScree;
		}
		
		private var m_isSmallScree:Boolean;
		private var minSize:Point;
		private var maxSize:Point;
		
		private var curSize:Point;
		
		private var m_mouseEventList		: Vector.<IMouseEvent>	
		private var m_isMousePressed		: Boolean										;
		private var m_stage				: Stage											;
		private var m_eventList 			: Vector.<IResizeEvent>							; 
		private static var s_instance 	: StageEventManager = new StageEventManager();
	}
}