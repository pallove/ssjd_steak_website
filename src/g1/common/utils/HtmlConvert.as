package g1.common.utils {
	/**
	 * @author leon.liu
	 */
	public class HtmlConvert {
		// 高亮颜色
		public static function hightLight(color:uint, text:String):String {
			return "<font color='#" + StringUtil.getFixedZeroStr(color, 6, 16) + "'>" + text + "</font>";
		}
		
		// 链接转换
		public static function link(text:String, ...args):String {
			return "<a href='event:" + args.concat(",") + "'>" + text + "</a>";
		}
		
		// 添加下划线
		public static function addUnderLine(text:String):String
		{
			return "<u>" + text + "</u>";
		}
		
		// 颜色转换
		public static function colorConvert(text : String) : String 
		{ 
			return text.replace(/\[c='?(#[0-9a-fA-F]{6})'?\](.+?)\[\/c\]/g, "<font color='$1'>$2</font>");
		}
		
		//粗体字转换
		private static function sizeConvert(txt : String) : String
		{
			return txt.replace(/\[b\](.+?)\[\/b\]/g, "<b>$1</b>");
		}
		
		/**
		 * 颜色和粗字体转换
		 */
		public static function colorAndSizeConvert(txt : String) : String
		{
			return sizeConvert(colorConvert(txt));
		}
		
		//文字大小转换
		public static function fontConvert(txt : String) : String
		{
			return txt.replace(/\[f='?([1-9]?[0-9])'?\](.+?)\[\/f\]/g, "<font size='$1'>$2</font>");
		}
		
		/**
		 * 颜色和文字大小转换
		 */
		public static function colorAndFontconver(txt : String) : String
		{
			return fontConvert(colorConvert(txt));
		}
		
		/**
		 * 设置字体大小
		 */
		public static function fontSet(size:uint, text:String):String {
			return "<font size='" + size + "'>" + text + "</font>";
		}
	}
}
