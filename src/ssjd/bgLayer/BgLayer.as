package ssjd.bgLayer
{
	import flash.display.Sprite;

	public class BgLayer
	{
		private var m_root : Sprite;
		private static var s_singleton : BgLayer;
		
		public function BgLayer()
		{
		}
		
		public function init(root : Sprite) : void
		{
			m_root = root;
		}
		
		public static function get singleton() : BgLayer
		{
			return s_singleton ||= new BgLayer();
		}		
	}
}