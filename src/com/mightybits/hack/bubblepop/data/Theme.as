package com.mightybits.hack.bubblepop.data
{
	public class Theme
	{
		
		public var words:Array;
		public var backgroundAsset:String;
		
		public var bubbleAssets:Array;
		
		public function Theme()
		{
			
		}
		
		public function getRandomBubbleAsset():String
		{
			return bubbleAssets[Math.floor(Math.random() * bubbleAssets.length)];
		}	
	}
}