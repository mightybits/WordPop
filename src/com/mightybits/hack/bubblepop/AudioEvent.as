package com.mightybits.hack.bubblepop
{
	import flash.events.Event;
	
	public class AudioEvent extends Event
	{
		public static var MODE_NORMAL:String = "AudioEvent.MODE_NORMAL";
		public static var MODE_TALKING:String = "AudioEvent.MODE_TALKING";
		public static var MODE_THINKING:String = "AudioEvent.MODE_THINKING";
		public static var MODE_COMPLETE:String = "AudioEvent.MODE_COMPLETE";
		
		public var words:Array;
		
		public function AudioEvent(type:String, words:Array = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.words = words;
			
			super(type, bubbles, cancelable);
		}
	}
}