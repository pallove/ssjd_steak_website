package ssjd.controlLayer
{
	import flash.display.Sprite;

	public class ControlLayer
	{
		private var m_root : Sprite;
		private static var s_singleton : ControlLayer;
		
		public function ControlLayer()
		{
		}
		
		public function init(root : Sprite) : void
		{
			m_root = root;
			
			// 测试
		}
		
		public static function get singleton() : ControlLayer
		{
			return s_singleton ||= new ControlLayer();
		}
	}
}