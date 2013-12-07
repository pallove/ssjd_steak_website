package g1.common.utils {
	import flash.events.Event;
	
	/**
	 * @author leon.liu
	 */
	public class Delegate {
		
		//with event
		public static function createWithEvent(f : Function, ... args) : Function {
			var func : Function = function (e : Event) : void {
				var arg0 : Array = args.concat(e);
				f.apply(null, arg0);
			};
			
			return func;
		}
		
		//without event
		public static function create(f : Function, ...args) : Function {
			var func : Function = function():void {
				f.apply(null, args);
			};
			return func;
			
		}
	}
}
