package g1.common.components
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2013-5-28 下午4:29:27
	 *		@说       明:  
	 *
	 *		@作       者: leon.liu
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/	
	
	[Event(name="change", type="flash.events.Event")]
	
	public class Slider extends EventDispatcher
	{
		public function Slider(meter : int = 0)
		{
			m_root = new Sprite();
			m_meter = meter;
			
			setValue(0);
		}
		
		public function setValue(value : int) : void
		{
			if (value < 1) value = 0;
			if (value > 100) value = 100;
			if (m_meter > 0) {
				var segment : int = Math.round(value / m_meter);
				value = segment * m_meter;
			}
			if (m_dragger)
				m_dragger.x = m_tracker.width * value / 100;	
			
			if (m_value == value) return;
			m_value = value;
			
			dispatchEvent(new Event(Event.CHANGE)); 
		}
		
		public function getValue() : int
		{
			return m_value;
		}
		
		public function setTracker(tracker : DisplayObject) : void
		{
			m_tracker = tracker;
		}
		
		public function setDragger(dragger : Sprite) : void
		{
			m_dragger = dragger;
			m_dragger.addEventListener(MouseEvent.MOUSE_DOWN, __onDownDragger);
		}
		
		private function __onUpDragger(event:MouseEvent):void
		{
			m_isDown = false;			
			m_dragger.stopDrag();
			//setValue(m_tracker.mouseX / m_tracker.width * 100);			
		}
		
		private function __onMoveDragger(event:MouseEvent):void
		{ 
			if (m_isDown) {
				setValue(m_tracker.mouseX / m_tracker.width * 100);
			}
		}
		
		private function __onDownDragger(event:MouseEvent):void
		{
			m_isDown = true;
			m_dragger.startDrag(false, m_dragRect);
			//setValue(m_tracker.mouseX / m_tracker.width * 100);
		}
		
		public function init(root : Sprite) : void
		{
			if (!(m_dragger && m_tracker)) {
				throw new Error("need call 'setTracker' and 'setDragger' first!");
			}
			
			m_root.addChild(m_tracker);
			m_root.addChild(m_dragger);
			
			m_dragRect = new Rectangle(0, 0, m_tracker.width, 0); 
			
			root.addChild(m_root);
			
			if (m_root.stage) {
				m_root.stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMoveDragger);
				m_root.stage.addEventListener(MouseEvent.MOUSE_UP, __onUpDragger);
			}
		}
		
		private function destroy() : void
		{
			if (m_dragger) {
				m_dragger.removeEventListener(MouseEvent.MOUSE_DOWN, __onDownDragger);				
			}
			
			if (m_root.stage) {
				m_root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveDragger);
				m_root.stage.removeEventListener(MouseEvent.MOUSE_UP, __onUpDragger);				
			}			
			
			if (m_root.parent) {
				m_root.parent.removeChild(m_root);
			}
		}
		
		public function getRoot() : DisplayObject
		{
			return m_root;
		}
		
		private var m_dragRect : Rectangle;
		private var m_value : int;
		private var m_meter : int;
		private var m_root : Sprite;
		private var m_isDown : Boolean;
		private var m_tracker : DisplayObject;
		private var m_dragger : Sprite;
	}
}