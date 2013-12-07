package g1.common.utils {
	import com.hexagonstar.util.debug.Debug;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * @author Leon.liu
	 */
	public class SpriteUtils {
		private static function getChildDisplayObject(parent:DisplayObjectContainer, childName:String):DisplayObject {
			if (parent) {
				return parent.getChildByName(childName);
			}
			
			return null;
		}
		
		public static function getChildSprite(parent:DisplayObjectContainer, childName:String):Sprite {
			var display:DisplayObject;
			if ((display = getChildDisplayObject(parent, childName))
								&& display is Sprite 
							) {
				return display as Sprite;
			}
			Debug.trace("children is not a 'Sprite'!");
			
			return null;
		}
		
		public static function getChildButton(parent:DisplayObjectContainer, childName:String):SimpleButton {
			
			var display:DisplayObject;
			if ((display = getChildDisplayObject(parent, childName))
								&& display is SimpleButton 
							) {
				return display as SimpleButton;
			}
			Debug.trace("children is not a 'SimpleButton'!");
			
			return null;			
		}
		
		public static function getChildTextField(parent:DisplayObjectContainer, childName:String):TextField {
			var display:DisplayObject;
			if ((display = getChildDisplayObject(parent, childName))
								&& display is TextField 
							) {
				return display as TextField;
			}
			Debug.trace("children is not a 'TextField'!");
			
			return null;			
		}	
		
		public static function getChildMovieClip(parent:DisplayObjectContainer, childName:String):MovieClip {
			var display:DisplayObject;
			if ((display = getChildDisplayObject(parent, childName))
								&& display is MovieClip 
							) {
				return display as MovieClip;
			}
			Debug.trace("children is not a 'TextField'!");
			
			return null;			
		}		
		
		public static function clearContainer(container:DisplayObjectContainer):void {
			if (!container) return;
			
			while(container.numChildren) 
				container.removeChildAt(0);	
		}
 	}
}
