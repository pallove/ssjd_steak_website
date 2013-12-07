package g1.common.debug
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.Stage;
	
	import g1.common.utils.Reflection;
	
	public class Log
	{
		/**
		 *  警告
		 */ 
		public static function warn(_info:String, _obj:* = null, type : String = "debug") : void
		{
			
			print(_info, _obj, type, Debug.LEVEL_WARN);
		}
		
		/**
		 *  打印信息
		 */ 
		public static function info(_info:String, _obj:* = null, type : String = "debug") : void
		{
			
			print(_info, _obj, type, Debug.LEVEL_INFO);
		}		
		
		/**
		 *  打印错误
		 */ 
		public static function error(_info:String, _obj:* = null) : void
		{
			print(_info, _obj, "Error", Debug.LEVEL_ERROR);
		}		
		
		/**
		 *  alcon
		 */ 
		public static function startFPS(_stage:Stage) : void
		{
			Debug.monitor(_stage);
		}
		
		private static function print(_info : String, _obj : *, type : String, level : int) : void
		{
			Debug.trace(_info, level);
		}
		
		private static function getObjInfo(info : String, obj : *, type : String) : String
		{
			return "[" + type + "]" + info + "[" + Reflection.getFullClassName(obj) + "]";
		}
	}
}
