package com.mightybits.hack.bubblepop.view.game
{
	import com.mightybits.hack.bubblepop.core.AppModel;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import assets.AssetManager;

	public class Ballon extends GameAnimatedSprite
	{
		private var _shape:Shape;
		
		private var _velocity:Number = 0.5;
		
		public var word:String;
		
		public function Ballon(word:String)
		{
			this.word = word;
			super();
		}
		
		override protected function init():void
		{
			var bg:Bitmap = new AssetManager.BubbleAsset();
			addChild(bg);
			
			var format:TextFormat = new TextFormat("Arial", 35, 0xFFFFFF, true);
			var text:TextField = new TextField();
			text.defaultTextFormat = format;
			text.autoSize = "left";
			text.text = word;
			
			text.x = bg.width/2 - text.width/2;
			text.y = bg.height/2 - text.height/2;
			
			addChild(text);	
		}
		
		override public function onTimer(delta:int):void
		{
			y -= _velocity;
			
			if(y < -height)
				y = AppModel.screenHeight + height;
		}
	}
}