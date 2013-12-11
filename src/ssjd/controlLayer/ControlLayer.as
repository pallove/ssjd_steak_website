package ssjd.controlLayer
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import g1.common.utils.Delegate;
	import g1.common.utils.Reflection;

	public class ControlLayer
	{

		private var m_root : Sprite;
		private static var s_singleton : ControlLayer;
		
		public function ControlLayer()
		{
			if (s_singleton) {
				throw new Error("[ControlLayer]!");
			}
			s_singleton = this;
		}
		
		public function init(root : Sprite) : void
		{
			m_stageW = root.stage.stageWidth;
			
			m_root = root;
			m_leftOver = m_rightOver = false;
			
			m_control = new Sprite();
			// 添加控制bar
			m_rightBar = Reflection.createDisplayObjectInstance("rightControl") as MovieClip;
			m_rightBar.addEventListener(MouseEvent.MOUSE_OVER, Delegate.create(__onMouseOver, m_rightBar));
			m_rightBar.addEventListener(MouseEvent.MOUSE_OUT, Delegate.create(__onMouseOut, m_rightBar));
			m_rightBar.addEventListener(MouseEvent.CLICK, Delegate.create(__onClick, m_rightBar));
			m_rightBar.x = m_stageW;

			// 添加控制bar
			m_leftBar = Reflection.createDisplayObjectInstance("rightControl") as MovieClip;
			m_leftBar.addEventListener(MouseEvent.MOUSE_OVER, Delegate.create(__onMouseOver, m_leftBar));
			m_leftBar.addEventListener(MouseEvent.MOUSE_OUT, Delegate.create(__onMouseOut, m_leftBar));
			m_leftBar.addEventListener(MouseEvent.CLICK, Delegate.create(__onClick, m_leftBar));			
			m_leftBar.scaleX = -1;
			m_leftBar.x = 0;//m_leftBar.width - 12;
			
			m_control.addChild(m_rightBar);
			m_control.addChild(m_leftBar);
			
			m_root.addChild(m_control);
			
			m_root.stage.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMoveStage);
		}
		
		protected function __onMouseMoveStage(event:MouseEvent):void
		{
			if (leftFunc || rightFunc) {
				var mousex : int = m_root.stage.mouseX;
				if (mousex < m_startX) {
					if (leftFunc) overLeft();
				}
				else if(mousex > m_endX) {
					if (rightFunc) overRight();
				}
				else {
					outLeft();
					outRight();
				}
			}
		}
		
		private var m_startX : int, m_endX : int;
		public function setControlRange(startX : int, endX : int) : void
		{
			m_startX = startX;
			m_endX = endX;
		}
		
		private function outLeft() : void
		{
			if (m_leftOver) {
				TweenLite.to(m_leftBar, 0.8, {x : 0});
				m_leftOver = false;
			}
		}
		
		private function outRight() : void
		{
			if (m_rightOver) {
				TweenLite.to(m_rightBar, 0.8, {x : m_stageW});
				m_rightOver = false;
			}
		}		
		
		private function overLeft() : void
		{
			if (!m_leftOver) {
				TweenLite.to(m_leftBar, 0.8, {x : m_leftBar.width - 12});
				m_leftOver = true;
			}
		}
		
		private function overRight() : void
		{
			if (!m_rightOver) {
				TweenLite.to(m_rightBar, 0.8, {x : m_stageW - m_rightBar.width + 12});
				m_rightOver = true;
			}
		}
		
		public function setLeftCall(func : Function) : void
		{
			if (!func) {
				outLeft();
			}
			leftFunc = func;
		}
		
		public function setRightCall(func : Function) : void
		{
			if (!func) {
				outRight();
			}
			rightFunc = func;
		}
		
		private function __onMouseOut(bar : MovieClip):void
		{
			TweenLite.to(bar.icon.bg, 0.5, {tint:outBgColor});
			TweenLite.to(bar.icon.arrow, 0.5, {tint:0xffffff});				
		}
		
		private function __onMouseOver(bar : MovieClip):void
		{
			TweenLite.to(bar.icon.bg, 0.5, {tint:overBgColor});
			TweenLite.to(bar.icon.arrow, 0.5, {tint:outBgColor});
		}
		
		private function __onClick(bar : MovieClip):void
		{ 
			if (bar == m_leftBar) {
				if (leftFunc) leftFunc();
			}
			else {
				if (rightFunc) rightFunc();
			}
		}		
		
		public static function get singleton() : ControlLayer
		{
			return s_singleton ||= new ControlLayer();
		}
		
		private var leftFunc : Function;
		private var rightFunc : Function;		
		
		private var m_stageW : int;
		private static const overBgColor : int = 0x534532;
		private static const outBgColor : int = 0xdab866;		
		
		private var m_checkEnabeld : Boolean;
		
		private var m_leftOver : Boolean;
		private var m_rightOver : Boolean;
		private var m_leftBar : MovieClip;
		private var m_rightBar : MovieClip;
		private var m_control : Sprite;
	}
}