package g1.common.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * 通用四帧动画按钮
	 *
	 * 状态：
	 * 1 普通态
	 * 2 悬浮态
	 * 3 点击态
	 * 4 灰态
	 *
	 */
	public class PButton extends Sprite
	{
		public function PButton(enabled:Boolean=true)
		{
			super();
			_enabled = enabled;
		}

		protected var _enabled:Boolean=true;

		protected var _buttonPic:Array=[];
		
		protected var _labelField:TextField;
		
		protected var _label:String;

		public function init(label:String,picNormal:DisplayObject, picOver:DisplayObject=null, picClick:DisplayObject=null, picGray:DisplayObject=null):void
		{
			if (picNormal == null)
			{
				throw new Error("Button surface must not be empty!");
			}
			_buttonPic[0]=picNormal;
			_buttonPic[1]=picOver ? picOver : picNormal;
			_buttonPic[2]=picClick ? picClick : picNormal;
			_buttonPic[3]=picGray ? picGray : picNormal;
			addChild(_buttonPic[0]);
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.color = 0xFF9900;
			txtFormat.size = TextFiledConst.NORMAL_SIZE;
			txtFormat.font = TextFiledConst.FONT;
			
			this.label = label;
			_labelField = new TextField();
			_labelField.autoSize = TextFieldAutoSize.CENTER;
			_labelField.defaultTextFormat = txtFormat;
			_labelField.setTextFormat(txtFormat);
			_labelField.text = label;
			_labelField.x = (this.width - _labelField.textWidth)/2;
			_labelField.y = (picNormal.height - _labelField.textHeight)/2;
			addChild(_labelField);
			
			if (_enabled)
			{
				enable();
			}
			else
			{
				disable();
			}
			
		}

		protected function onMOver(me:MouseEvent):void
		{
			removeChild(_buttonPic[0]);
			addChild(_buttonPic[1]);
			setChildIndex(_buttonPic[1],0);
		}

		protected function onMOut(me:MouseEvent):void
		{
			if (this.contains(_buttonPic[1]))
				removeChild(_buttonPic[1]);
			if (this.contains(_buttonPic[2]))
				removeChild(_buttonPic[2]);
			addChild(_buttonPic[0]);
			setChildIndex(_buttonPic[0],0);
		}

		protected function onMDown(me:MouseEvent):void
		{
			if (this.contains(_buttonPic[1]))
				removeChild(_buttonPic[1]);
			addChild(_buttonPic[2]);
			setChildIndex(_buttonPic[2],0);
		}

		protected function onMUp(me:MouseEvent):void
		{
			removeChild(_buttonPic[2]);
			addChild(_buttonPic[0]);
			setChildIndex(_buttonPic[0],0);
		}

		public function enable():void
		{
			if (!hasEventListener(MouseEvent.MOUSE_OVER))
			{
				addEventListener(MouseEvent.MOUSE_OVER, onMOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMOut);
				addEventListener(MouseEvent.MOUSE_DOWN, onMDown);
				addEventListener(MouseEvent.MOUSE_UP, onMUp);
			}
			if (_buttonPic[3] && this.contains(_buttonPic[3]))
			{
				removeChild(_buttonPic[3]);
			}
			addChild(_buttonPic[0]);
			setChildIndex(_buttonPic[0],0);
		}

		public function disable():void
		{
			if (hasEventListener(MouseEvent.MOUSE_OVER))
			{
				removeEventListener(MouseEvent.MOUSE_OVER, onMOver);
				removeEventListener(MouseEvent.MOUSE_OUT, onMOut);
				removeEventListener(MouseEvent.MOUSE_DOWN, onMDown);
				removeEventListener(MouseEvent.MOUSE_UP, onMUp);
			}
			if (this.contains(_buttonPic[0]))
				removeChild(_buttonPic[0]);
			if(_buttonPic[3])
			{
				addChild(_buttonPic[3]);
				setChildIndex(_buttonPic[3],0);
			}
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

	}
}