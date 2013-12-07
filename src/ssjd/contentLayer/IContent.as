package ssjd.contentLayer
{
	import flash.display.DisplayObjectContainer;

	public interface IContent
	{
		function init(display : DisplayObjectContainer) : void; 
		function destroy() : void;
		function show() : void;
		function getContent() : DisplayObjectContainer;
		function get type() : int;
		function set baseDir(dir : String) : void;
	}
}