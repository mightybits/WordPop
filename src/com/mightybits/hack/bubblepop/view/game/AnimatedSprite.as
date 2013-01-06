package com.mightybits.hack.bubblepop.view.game
{
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	
	public class AnimatedSprite extends InteractiveSprite implements IAnimatable
	{
		public function AnimatedSprite()
		{
			Starling.juggler.add(this);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			Starling.juggler.remove(this);
		}

		public function advanceTime(time:Number):void
		{
			// override 
		}
	}
}