package com.mightybits.hack.bubblepop.view.game
{
	
	public class GameAnimatedSprite extends GameSprite implements IAnimated
	{
		public function GameAnimatedSprite()
		{
			GameTimer.instance.addDisplay(this);
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			GameTimer.instance.removeDisplay(this);
		}
		
		public function onTimer(delta:int):void
		{
			// override 
		}
	}
}