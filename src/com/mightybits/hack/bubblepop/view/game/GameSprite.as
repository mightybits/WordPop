package com.mightybits.hack.bubblepop.view.game
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameSprite extends Sprite
	{
		protected var _timer:GameTimer = GameTimer.instance;
		
		public function GameSprite()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
		}
		
		public function destroy():void
		{
			while(this.numChildren > 0)
			{
				var child:Sprite = getChildAt(0) as Sprite;
				
				if(child is GameSprite)
					GameSprite(child).destroy();
				
				removeChild(child);
			}
		}	
		
		protected function onAddedToStageHandler(event:Event):void
		{
			onAdded();
		}
		
		protected function onAdded():void
		{
			init();
		}
		
		protected function init():void
		{
			// override	
		}	
	}
}