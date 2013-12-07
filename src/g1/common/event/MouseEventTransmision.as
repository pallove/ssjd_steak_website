package g1.common.event
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import g1.common.display.DisplayObjectHitChecker;
	
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-4-24 下午9:42:33
	 *		@说       明:  鼠标事件穿透
	 *
	 *		@作       者: leon.liu
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/	
	
	public class MouseEventTransmision
	{
		public function MouseEventTransmision()
		{
			if (s_singleton) {
				throw new Error("[MouseEventTransmision] Singleton Error!");
			}
			
			s_singleton = this;
			
			init();
			
		}
		
		private function init() : void
		{
			m_crossTFList = new Vector.<TextField>();			
		}
		
		/**
		 *  设定传递容器
		 */ 
		public function setPass(pass : InteractiveObject) : void
		{
			m_pass = pass;
			if (null == pass) return;			
		}
		
		
		private function __onMoveTextField(e : MouseEvent) : void
		{
			if (!m_pass) return;
			checkTarget(e);
			if (!m_isHyperLinkClick) {
				m_pass.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
				m_isHyperLinkClick = false;
			}			
		}
		
		private function __onDownTextField(e : MouseEvent) : void
		{
			if (!m_pass) return;
			checkTarget(e);	
			if (!m_isHyperLinkClick) {
				m_pass.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
				m_isHyperLinkClick = false;
			}
		}
		
		private function __onUpTextField(e : MouseEvent) : void
		{
			if (!m_pass) return;
			checkTarget(e);	
			if (!m_isHyperLinkClick) {
				m_pass.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
				m_isHyperLinkClick = false;
			}
		}
		
		private function __onClickTextField(e : MouseEvent) : void
		{
			if (!m_pass) return;
			checkTarget(e);
			if (!m_isHyperLinkClick) {
				m_pass.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				m_isHyperLinkClick = false;
			}			
		}
		
		private function checkTarget(e : MouseEvent) : void
		{
			var tf : TextField = e.target as TextField;
			m_isHyperLinkClick = false;
			var index : int = tf.getCharIndexAtPoint(e.localX, e.localY);
			if (tf.length > index) {
				var tfURL : String = tf.getTextFormat(index).url;
				if (tfURL && tfURL.length) {
					m_isHyperLinkClick = true;
				}
			}			
		}
		
		/**
		 *  添加textfield事件传递
		 */ 
		public function addCrossTextField(tf : TextField) : void 
		{
			if (m_crossTFList.indexOf(tf) != -1) return;
			m_crossTFList.push(tf);
			
			addTextFieldEvent(tf);
		}
		
		public function removeCrossTextField(tf : TextField) : void
		{
			var index : int;
			if ((index = m_crossTFList.indexOf(tf)) != -1) {
				m_crossTFList.splice(index, 1);
				tf.removeEventListener(MouseEvent.MOUSE_MOVE, __onMoveTextField);			
				tf.removeEventListener(MouseEvent.MOUSE_DOWN, __onDownTextField);
				tf.removeEventListener(MouseEvent.MOUSE_UP, __onUpTextField);
				tf.removeEventListener(MouseEvent.CLICK, __onClickTextField);
			}
		}
		
		private function addTextFieldEvent(tf:TextField):void
		{
			tf.addEventListener(MouseEvent.MOUSE_MOVE, __onMoveTextField);			
			tf.addEventListener(MouseEvent.MOUSE_DOWN, __onDownTextField);
			tf.addEventListener(MouseEvent.MOUSE_UP, __onUpTextField);
			tf.addEventListener(MouseEvent.CLICK, __onClickTextField);
		}
		
		
		public static function get singleton() : MouseEventTransmision
		{
			if (!s_singleton && new MouseEventTransmision()) {}
			
			return s_singleton;
		}
		
		private var m_passFlag		: Boolean						; // 传递标志
		public var m_crossTFList	: Vector.<TextField>			; // 文本框列表
		private var m_pass			: InteractiveObject				; // 传递者
		private var m_check			: DisplayObjectContainer		; // 检测者
		private var m_isHyperLinkClick 	: Boolean;
		private static var s_singleton 	: MouseEventTransmision;
	}
}