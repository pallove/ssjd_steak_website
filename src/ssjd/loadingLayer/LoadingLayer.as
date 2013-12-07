package ssjd.loadingLayer
{
	import flash.display.Sprite;

	public class LoadingLayer
	{
		private var m_root : Sprite;
		private static var s_singleton : LoadingLayer;
		
		public function LoadingLayer()
		{
		}
		
		public function init(root : Sprite) : void
		{
			m_root = root;
		}
		
		public static function get singleton() : LoadingLayer
		{
			return s_singleton ||= new LoadingLayer();
		}
	}
}