package com.mightybits.hack.bubblepop.view.game
{
	import com.mightybits.hack.bubblepop.core.AppModel;
	import com.mightybits.hack.bubblepop.core.AudioController;
	
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	
	import assets.AssetManager;
	
	
	public class GameView extends GameSprite
	{
		private var _audioController:AudioController;
		private var _words:Array;
		private var _balloons:ArrayCollection = new ArrayCollection();
		private var _textOutput:TextField;
		
		
		public function GameView()
		{
			super();
			
			_words = ["CAT", "DOG", "BARN", "COW", "ROOSTER", "APPLE", "TRACTOR", "HORSE"];
			
			_audioController = new AudioController(onWordsSpoken);
		}
		
		override protected function init():void
		{
			var bg:Bitmap = new AssetManager.OceanBackGroundAsset();
			addChild(bg);
			
			
			var bloon:Ballon;
			for (var i:int = 0; i<_words.length; i++)
			{
				bloon = new Ballon(_words[i]);
				bloon.x = Math.random() * AppModel.screenWidth;
				bloon.y = Math.random() * AppModel.screenHeight;
				addChild(bloon);
				
				_balloons.addItem(bloon);
			}
			
			GameTimer.instance.start();
			_audioController.start();
			
			var format:TextFormat = new TextFormat("Arial", 55, 0xCCCCCC, true);
			_textOutput = new TextField();
			_textOutput.autoSize = "left";
			_textOutput.defaultTextFormat = format;
			_textOutput.text = "...";
			
			addChild(_textOutput);
			
			_textOutput.x = 10;
			_textOutput.y = AppModel.screenHeight - _textOutput.height - 10;
			
		}
		
		private function onWordsSpoken(words:Array):void
		{
			var spoken:String = ""
			
			for each (var w:String in words)
			{
				spoken += cleanWord(w)+" ";
			}
			
			trace("WORDS: ", spoken);
			_textOutput.text = spoken;
			
			for each (var item:Ballon in _balloons)
			{
				for each (var word:String in words)
				{
					var a:String = cleanWord(item.word);
					var b:String = cleanWord(word);
				
					
					if(a == b)
					{
						this.removeChild(item);
						_balloons.removeItemAt(_balloons.getItemIndex(item));
					}
				}	
			}	
			
			
			
			
			function cleanWord(word:String):String
			{
				word = word.toLowerCase();
				word = word.replace(/[.?!]/gi, "");
				
				return word;
			}
		}		
		
		
	}
}