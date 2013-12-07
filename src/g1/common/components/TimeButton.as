package g1.common.components
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import org.osmf.events.TimeEvent;

	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012-4-17 上午10:41:10
	 *		@说       明: 时间按钮
	 *
	 *		@作       者: 林秀娟
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 ********************************************************/
	
	public class TimeButton extends PButton
	{
		private var _interval:int;    //倒计时间
		private var _temp:int;    //临时变量
		private var timer:Timer;    //计时器
		
		public function TimeButton(enabled:Boolean=true)
		{
			super(enabled);
		}
		
		override protected function onMDown(me:MouseEvent):void
		{
		   super.onMDown(me);
		   
		   this.mouseEnabled = false;
		   var mat:Array =[0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0,0,0,1,0];
		   this.filters = [new ColorMatrixFilter(mat)];
		   
		   if(timer==null)
		       timer = new Timer(1000,interval);
		   timer.start();
		   timer.addEventListener(TimerEvent.TIMER,timerReplayHandler);
		   timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandler);
			   
		   //可以使用timer 代替 先这么用
//		   setTimeout(function():void{this.mouseEnabled=true;},interval);
		}
		
		private function timerReplayHandler(event:TimerEvent):void
		{
			_labelField.text = label+"("+(interval-timer.currentCount)+")";
			_labelField.x = (this.width - _labelField.textWidth)/2;
			_labelField.y = (this.height - _labelField.textHeight)/2;
		}
		
		private function timerCompleteHandler(event:TimerEvent):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,timerReplayHandler);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerCompleteHandler);
			timer = null;
			
			this.mouseEnabled=true;
			this.filters = null;
			_labelField.text = label;
			_labelField.x = (this.width - _labelField.textWidth)/2;
			_labelField.y = (this.height - _labelField.textHeight)/2;
		
		}

		public function get interval():int
		{
			return _interval;
		}

		public function set interval(value:int):void
		{
			_interval = value;
		}

	}
}