package com.mightybits.hack.bubblepop.view.game
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.collections.ArrayCollection;

	public class GameTimer
	{	
		static private var _instance:GameTimer;
		
		private var _timer:Timer;
		private var _lastTimer:int;
		
		private var _displays:ArrayCollection = new ArrayCollection();
		
		static public function get instance():GameTimer
		{
			if(!_instance)
				_instance = new GameTimer();
			
			return _instance;
		}	
		
		public function GameTimer()
		{
			if(_instance) throw new Error("Singleton Error", this);
			
			init();
		}
		
		public function addDisplay(display:IAnimated):void
		{
			_displays.addItem(display);
		}	
		
		public function removeDisplay(display:IAnimated):void
		{
			_displays.removeItemAt(_displays.getItemIndex(display));
		}	
		
		public function start():void
		{
			_lastTimer = getTimer();
			_timer.start();
		}	
		
		public function stop():void
		{
			_timer.stop();
		}
		
		private function init():void
		{
			_timer = new Timer(0,0);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			var delta:int = getTimer() - _lastTimer;
			
			for each (var item:IAnimated in _displays)
			{
				item.onTimer(delta);
			}	
			
			_lastTimer = getTimer();
		}	
		
		protected function onTimerComplete(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
	}
}