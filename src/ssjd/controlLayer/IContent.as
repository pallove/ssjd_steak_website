package ssjd.controlLayer
{
	import flash.display.DisplayObjectContainer;

	public interface IContent
	{
		function init(display : DisplayObjectContainer) : void;
		function set baseDir(dir : String) : void;
		function destroy() : void;
		function getContent() : DisplayObjectContainer;
		function get type() : int;
	}
}