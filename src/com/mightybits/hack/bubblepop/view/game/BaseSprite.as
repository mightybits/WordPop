package com.mightybits.hack.bubblepop.view.game
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BaseSprite extends Sprite
	{
		
		private var _initialized:Boolean = false;
		
		public function BaseSprite()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		protected function onAddedToStageHandler(event:Event):void
		{
			onAdded();
		}
		
		protected function onAdded():void
		{
			if(!_initialized)
			{
				_initialized = true;
				init();
			}
		}
		
		protected function init():void
		{
			// override	
		}	
	}
}