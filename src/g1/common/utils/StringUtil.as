package g1.common.utils {
	import flash.utils.ByteArray;
	
	import g1.common.resource.ResourceManager;

	/**
	 * @author Leon.liu
	 */
	public class StringUtil {
		public static function getTextLen(text:String, charSet : String = "utf-8"):int {
			if(text==null || text=="")return 0;
			var ba:ByteArray = new ByteArray();
			ba.writeMultiByte(text, charSet);			
			return ba.length; 
		}
		
		/**
		 * 字符串转Object
		 * foramt : "type:5,color:0xFF0000"
		 */
		public static function str2Obj(str : String) : Object
		{
			var data : Array = formatString2Array(str,",",String);
			var param : Array;
			var obj : Object = new Object();
			
			while(data.length){
				param = data.shift().split(":");
				obj[param[0]] = param[1];
			}
			
			return obj;
		}
		
		/**
		 * 清除html标签
		 */
		public static function clearHtml(str : String) : String
		{
			return str.replace(/\<.+?\>/g, "");
		}
		
		/**
		 *  将数组转化成指定的类型
		 */ 
		public static function formatArrayValue(array : Array, type : Class) : Array
		{
			array.forEach(
				function(item : *, index : int, arr : Array) : void
				{
					arr[index] = type(item);
				}
			);
			
			return array;
		}
		
		public static function formatString2Array(str : String, split : String, type : Class) : Array
		{
			if (str.length == 0) return [];
			return formatArrayValue(str.split(split), type);
		}
		
		/**
		 * 将秒数转换为时分秒
		 */
		public static function getTime(sec : Number,len : int = 2) : String
		{
			sec /= 1000;
			return getFixedZeroStr(Math.floor(sec/3600),len) + ":" + getFixedZeroStr(Math.floor(sec/60) % 60,len) + ":" + getFixedZeroStr(Math.floor(sec%60),len);
		}
		
		public static function genFixedString(len:int):String {
			var ba:ByteArray = new ByteArray();
			len -= 2;
			ba.writeByte(49);
			while(len) {
				ba.writeByte(48);
				len--;
			}
			ba.writeByte(49);
			
			ba.position = 0;
			return ba.readMultiByte(ba.bytesAvailable, "ascii");
		}
		
		/**
		 * 文字替换
		 */
		public static function replaceStr(str : String, target : String, replace : String) : String
		{
			var temp : Array = str.split(target);
			return temp.join(replace);
		}
		
		/**
		 * 去空格 
		 * @param str
		 * @return 
		 * 
		 */
		public static function trim(str:String):String
		{
		   return str.replace(/\s+/g, "");
		}
		
		/**
		 *  文字屏蔽 
		 * @param text
		 * @return 
		 * 
		 */
		public static function filter(text:String):String
		{
			var reg:Array = getFilterReg();
			for(var i:int=0; i <= reg.length-1; i++)
			{
				var firstIndex:int = text.indexOf(String(reg[i]).charAt(0));
				var lastIndex:int = text.indexOf(String(reg[i]).charAt(String(reg[i]).length - 1));
				
				if (firstIndex >= 0 && lastIndex >= 0) //查找到包含屏蔽字的首尾字符的字符串部分
				{
					var partStr:String = text.substring(firstIndex, lastIndex + 1);
					var totalStr:String = "";
					
					for (var j:int=0; j <= partStr.length; j++) //删除空格
					{
						if (partStr.charAt(j) != " ")
						{
							totalStr += partStr.charAt(j);
						}
					}
					
					if (totalStr == reg[i])//比较去掉空格后的内容和屏蔽内容是否相同
					{
						text=text.replace(partStr,'**'); 
						i--;
					}
				}
			}
			return text;
		}
		
		/**
		 *  是否存在非法文字 
		 * @param text
		 * @return 
		 * 
		 */
		public static function hasFilter(text:String):Boolean
		{
			var reg:Array = getFilterReg();
			for(var i:int=0; i <= reg.length-1; i++)
			{
				var firstIndex:int = text.indexOf(String(reg[i]).charAt(0));
				var lastIndex:int = text.indexOf(String(reg[i]).charAt(String(reg[i]).length - 1));
				
				if (firstIndex >= 0 && lastIndex >= 0) //查找到包含屏蔽字的首尾字符的字符串部分
				{
					var partStr:String = text.substring(firstIndex, lastIndex + 1);
					var totalStr:String = "";
					
					for (var j:int=0; j <= partStr.length; j++) //删除空格
					{
						if (partStr.charAt(j) != " ")
						{
							totalStr += partStr.charAt(j);
						}
					}
					
					if (totalStr == reg[i])//比较去掉空格后的内容和屏蔽内容是否相同
					{
						return true;
					}
				}
			}
			return false;
		}
		
		/**
		 * 获取屏蔽内容 
		 * @return 
		 * 
		 */
		public static function getFilterReg():Array
		{
		   var arr:Array = [];
		   var filter:XML = ResourceManager.singleton.getScript().getBean("textFilter").getContent();
		   for each(var xml:XML  in filter.elements())
		   {
		      arr.push(xml.@value);
		   }
		   return arr;
		}
		
		/**
		 * 格式化信息为hex
		 */ 
		public static function fmt2Hex(ba : ByteArray, offset : int = 0) : String
		{
			var str : String = "";
			var copyPos : int = ba.position;
			ba.position = offset;
			
			var addr : int = 0;
			var addrHex : String;
			
			str += getFixedZeroStr(addr, 7, 16) + "\t";
			for(var i : int = offset; i < ba.length; i++) {
				var ch : String = ba.readUnsignedByte().toString(16);
				str += (ch.length == 1) ? "0" + ch : ch;
				
				if ((i + 1) % 2 == 0) {
					str += " ";
					
					if ((i + 1) % 16 == 0) {
						str += "\n";
						addr = i;
						str += getFixedZeroStr(addr, 7, 16) + "\t";
					}					
				}

			}
			ba.position = copyPos;
			
			return str;
		}
		
		
		/**
		 * 取得补0的字符窜
		 * @param	 value 	为相应的值
		 * @param	 size  	为需要的长度
		 * @param	 radix	进制
		 * @param	 before	前还是后补零
		 */ 
		public static function getFixedZeroStr(value : int, size : int, radix : int = 10, before : Boolean = true) : String
		{
			var zeroStr : String = "00000000000000000000";
			var radixStr : String = value.toString(radix); 
			zeroStr = zeroStr.substring(0, size - radixStr.length);
			
			return (before) ? zeroStr + radixStr : radixStr + zeroStr;
		}
		
		/**
		 * 格式化打印
		 * @param	fmt	格式文本, 如: "hello, {0}!", "test"
		 */ 
		public static function printf(fmt : String, ...args) : String {
			return printfArgs(fmt, args);
		}
		
		public static function printfArgs(fmt : String, args : Array) : String {
			return fmt.replace(/{(\d+)}/g, function() : String {
				return (args.length > arguments[1]) ? args[arguments[1]] : "";
			});
		}
		
		/**
		 * 首字母大字 
		 */ 		
		public static function upperFirstChar(str : String) : String {
			return str.replace(/^[a-z]/, function() : String {
				return String(arguments[0]).charAt(0).toUpperCase();
			});
		}
		/**
		*玩家发言过滤, 大小写统一
		*/
		private static function filter_replace(len:int):String{
			//根据长度返回*号的个数的字符串
			return "*******************".substr(0, len);
			/*var temp:String = "";
			for (var i:int = 0; i < len; i++){
				temp += "*";
			}
			return temp;*/
		}
		
		/**
		 *  是否是数值
		 */
		public static function isNumber(num : int) : Boolean {
			return num > 47 && num < 58;
		}
		
		public static function isLetter(num : int) : Boolean {
			return num > 96 && num < 123;
		}
		
		public static　function shield(player_msg:String):String
		{
			var msg:String = player_msg.toUpperCase();
			var real_msg:String = player_msg;
			var list1:Array = [];//保存屏蔽内容的下标位置
			var list2:Array = [];//保存屏蔽内容的长度
			var subXml:XML;
			var filterXml:XML;
			filterXml = ResourceManager.singleton.getScript().getBean("textFilter").getContent();

			for each(subXml in filterXml.elements())
			{
				var temp:String = subXml.@value;
				if (msg.indexOf(temp) != -1){
					var replace_len:int = temp.length;
					var replace_str:String = filter_replace(replace_len);
					var sub1:int = msg.indexOf(temp);
					/*屏蔽内容替换, 记录出现的下标位置和长度*/
					do{
						list1.push(sub1);
						list2.push(replace_len);
						msg = msg.replace(temp, replace_str);
						sub1 = msg.indexOf(temp);
					}while(sub1 != -1);
				}
			}

			/**对玩家发言内容的进行屏蔽内容的替换*/
			var len : int = list1.length;
			for(var i:int = 0; i < len; i++){
				for(var j:int = 0; j < list2[i]; j++){
					real_msg = real_msg.replace(real_msg.charAt(list1[i] + j), "*");
				}
			}
			return real_msg;
		}
		
		/**   
		 * return true 有敏感词
		 */
		public static function shieldTest(player_msg : String) : Boolean
		{
			var msg:String = player_msg.toUpperCase();
			var list1:Array = [];//保存屏蔽内容的下标位置
			var list2:Array = [];//保存屏蔽内容的长度
			var subXml:XML;
			var filterXml:XML;
			var cantPass : Boolean = false;
			filterXml = ResourceManager.singleton.getScript().getBean("RoleNameFilter").getContent();
			
			for each(subXml in filterXml.elements())
			{
				var temp:String = subXml.@value;
				if (msg.indexOf(temp) != -1){
					cantPass = true;
				}
			}
			
			return cantPass;
		}
	}
}
