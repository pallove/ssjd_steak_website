package  g1.common.utils{
	import flash.utils.ByteArray;
	
	public class StringSort {
		public function StringSort()
		{
			throw new Error("单例...");
		}
		
		/**
		 * 获取一串中文的拼音字母
		 * @param chinese Unicode格式的中文字符串
		 * @return 
		 * 
		 */
		public static function convertString(chinese:String):String 
		{
			var len:int = chinese.length;
			var ret:String = "";
			for (var i:int = 0; i < len; i++) {
				ret += convertChar(chinese.charAt(i));
			}
			return ret;
		}
		
		/**
		 * 获取中文第一个字的拼音首字母
		 * @param chineseChar
		 * @return 
		 * 
		 */
		public static function convertChar(chineseChar:String):String 
		{
			var bytes:ByteArray = new ByteArray;
			bytes.writeMultiByte(chineseChar.charAt(0), "gb2312");
			//得到第一个中文字符的gb2312编码
			var n:int = bytes[0] << 8;
			n += bytes[1];
			if (isIn(0xB0A1, 0xB0C4, n)) 
				return "a";
			if (isIn(0XB0C5, 0XB2C0, n)) 
				return "b";
			if (isIn(0xB2C1, 0xB4ED, n))
				return "c";
			if (isIn(0xB4EE, 0xB6E9, n))
				return "d";
			if (isIn(0xB6EA, 0xB7A1, n))
				return "e";
			if (isIn(0xB7A2, 0xB8c0, n))
				return "f";
			if (isIn(0xB8C1, 0xB9FD, n))
				return "g";
			if (isIn(0xB9FE, 0xBBF6, n))
				return "h";
			if (isIn(0xBBF7, 0xBFA5, n))
				return "j";
			if (isIn(0xBFA6, 0xC0AB, n))
				return "k";
			if (isIn(0xC0AC, 0xC2E7, n))
				return "l";
			if (isIn(0xC2E8, 0xC4C2, n))
				return "m";
			if (isIn(0xC4C3, 0xC5B5, n))
				return "n";
			if (isIn(0xC5B6, 0xC5BD, n))
				return "o";
			if (isIn(0xC5BE, 0xC6D9, n))
				return "p";
			if (isIn(0xC6DA, 0xC8BA, n))
				return "q";
			if (isIn(0xC8BB, 0xC8F5, n))
				return "r";
			if (isIn(0xC8F6, 0xCBF0, n))
				return "s";
			if (isIn(0xCBFA, 0xCDD9, n))
				return "t";
			if (isIn(0xCDDA, 0xCEF3, n))
				return "w";
			if (isIn(0xCEF4, 0xD188, n))
				return "x";
			if (isIn(0xD1B9, 0xD4D0, n))
				return "y";
			if (isIn(0xD4D1, 0xD7F9, n))
				return "z";
			return "\0";
		}
		
		private static function isIn(from:int, to:int, value:int):Boolean 
		{
			return value >= from && value <= to;
		}
		
		/**
		 * 是否为中文 
		 * @param chineseChar
		 * @return 
		 * 
		 */
		public static function isChinese(chineseChar:String):Boolean 
		{
			if (convertChar(chineseChar) == "\0")
				return false;
			return true;
		}
		
		/**
		 * 修改后可支持第一个字符的中英文混排
		 * 中文只支持第一个字的排序
		 * @param arr 要进行排序的对象数组
		 * @param childName 如果要进行排序的键名不是当前对象的属性，而是当前对象的属性的属性，则需要将对象的属性名传进来(最多就一层嵌套)
		 * @param key 要进行排序的键名(对象数组时使用)
		 * @param isNumeric 数字排序，要将isNumeric置为true
		 */
		public static function sort(arr:Array, childName : String = "", key:String = "",sortType : String = "ascending", isNumeric : Boolean = false):Array 
		{
			var byte:ByteArray = new ByteArray();
			var cnStrArr:Array = [];
			var enStrArr : Array = [];
			var returnArr:Array = [];
			var item:*;
			var tempCnStrArr : Array = [];
			var obj:Object;
			if(!isNumeric)
			{
				for each(item in arr)
				{
					if (key == "") 
					{
						if(isChinese(item))
							tempCnStrArr.push(item);
						else
							enStrArr.push({a : item, b : item});
					}
					else
					{
						if(childName == "")
						{
							if(isChinese(item[key]))
								tempCnStrArr.push(item);
							else
								enStrArr.push({a : item[key], b : item});
						}
						else
						{
							if(isChinese(item[childName][key]))
								tempCnStrArr.push(item);
							else
								enStrArr.push({a : item[childName][key], b : item});
						}
					}
				}
				
				for each (item in tempCnStrArr) 
				{
					if (key == "") 
						byte.writeMultiByte(String(item).charAt(0), "gb2312");
					else
					{
						if(childName == "")
							byte.writeMultiByte(String(item[key]).charAt(0), "gb2312");
						else
							byte.writeMultiByte(String(item[childName][key]).charAt(0), "gb2312");
					}
				}
				byte.position = 0;
				var len:int = byte.length / 2;
				for (var i:int = 0; i < len; i++) 
				{
					cnStrArr[cnStrArr.length] = {a: ((byte[i * 2] << 8) + byte[i * 2 + 1]), b: tempCnStrArr[i]};
				}
				
				if(sortType == "ascending")
				{
					cnStrArr = cnStrArr.sortOn(["a"],Array.NUMERIC);
					enStrArr = enStrArr.sortOn(["a"] );
					for each (obj in enStrArr) 
					{
						returnArr.push(obj.b);
					}
					for each (obj in cnStrArr) 
					{
						returnArr.push(obj.b);
					}
				}
				else if(sortType == "descending")
				{
					cnStrArr = cnStrArr.sortOn(["a"],Array.DESCENDING);
					enStrArr = enStrArr.sortOn(["a"],Array.DESCENDING);
					for each (obj in cnStrArr) 
					{
						returnArr.push(obj.b);
					}
					for each (obj in enStrArr) 
					{
						returnArr.push(obj.b);
					}
				}
			}
			else
			{
				for each(item in arr)
				{
					if (key == "") 
					{
						enStrArr.push({a : item, b : item});
					}
					else
					{
						if(childName == "")
						{
							enStrArr.push({a : item[key], b : item});
						}
						else
						{
							enStrArr.push({a : item[childName][key], b : item});
						}
					}
				}
				
				enStrArr = enStrArr.sortOn(["a"],Array.NUMERIC);
				for each (obj in enStrArr) 
				{
					returnArr.push(obj.b);
				}
				
				if(sortType == "descending")
					returnArr.reverse();
			}
			
			arr = null;
			tempCnStrArr = null;
			cnStrArr = null;
			enStrArr = null;
			return returnArr;
		}
	}
}