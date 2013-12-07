package g1.common.utils
{
	/**
	 * 深度拷贝对象
	 * 
	 * @author HigenYao
	 * */
	    import flash.net.registerClassAlias;
	    import flash.utils.ByteArray;
	    import flash.utils.getDefinitionByName;
	    import flash.utils.getQualifiedClassName;
	    
        public class CopyUtil
		{
            public static function clone(object:Object):Object
			{

                var qClassName:String = getQualifiedClassName(object);

                var objectType:Class = getDefinitionByName(qClassName) as Class;

                registerClassAlias(qClassName, objectType);
                
                var copier:ByteArray = new ByteArray();
                copier.writeObject(object);

                copier.position = 0;
                
                return copier.readObject();
            }
            
            public static function registerClass(classPath:String, className:Class):void
			{
            	 registerClassAlias(classPath, className);
            }
        }

}