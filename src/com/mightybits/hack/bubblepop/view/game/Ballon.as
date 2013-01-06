package com.mightybits.hack.bubblepop.view.game
{
	import com.mightybits.hack.bubblepop.AudioEvent;
	import com.mightybits.hack.bubblepop.core.AppModel;
	import com.mightybits.hack.bubblepop.core.AudioController;
	
	import flash.display.Shape;
	
	import assets.AssetManager;
	import assets.Assets;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Ballon extends AnimatedSprite
	{
		private var _shape:Shape;
		
		private var _velocity:Number = 1;
		
		public var word:String;
		
		private var _paused:Boolean = false;
		private var _pulsing:Boolean = false;
		private var _audioController:AudioController;
		private var _recordLabel:TextField;
		private var _wordLabel:TextField;
		private var _xaxis:Number;
		private var _ybuffer:Number;
		private var _particleSystem:PDParticleSystem;
		private var _background:Image;
		private var _counter:int;
		private var _originHeight:Number;
		private var _originWidth:Number;
		
		public function Ballon(word:String)
		{
			this.word = word;
			
			_counter = 0;
			
			var config:XML = XML(new AssetManager.ExplodeConfig());
			var texture:Texture = Texture.fromBitmap(new AssetManager.EplodeParticle());
			
			_particleSystem = new PDParticleSystem(config, texture);
			
			_xaxis = Math.random() * (AppModel.screenWidth - 200) + 50;
			_ybuffer = Math.random() * 360;
			
			_audioController = new AudioController();
			_audioController.addEventListener(AudioEvent.MODE_COMPLETE, audioComplete);
			_audioController.addEventListener(AudioEvent.MODE_TALKING, audioTalking);
			_audioController.addEventListener(AudioEvent.MODE_THINKING, audioThinking);

		}
		
		
		protected function audioComplete(event:AudioEvent):void
		{
			trace("--------------->>>");
			onWordsSpoken(event.words);
		}
		
		protected function audioTalking(event:AudioEvent):void
		{
			_recordLabel.visible = true;
		}
		
		protected function audioThinking(event:AudioEvent):void
		{
			trace("---------------");
			_pulsing = true;
			_wordLabel.visible = false;
			_recordLabel.visible = false;
		}
		
		private function reset():void
		{
			_pulsing = false;
			_paused = false;
			_wordLabel.visible = true;
			_recordLabel.visible = false;			
		}
		
		override protected function onClick():void
		{
			if(!_paused)
			{
				Assets.getSound("touch").play();
				
				_paused = true;
				_audioController.start();
			}
		}	
		
		override protected function init():void
		{
			_background = addChild(new Image(Assets.getTexture(AppModel.currentTheme.getRandomBubbleAsset()))) as Image;
			
			_originWidth = _background.width;
			_originHeight = _background.height;
			
			_wordLabel = new TextField(200, 100, word, "Arial", 35, 0xFFFFFF, true);
			
			_wordLabel.x = _background.width/2 - _wordLabel.width/2;
			_wordLabel.y = _background.width/2 - _wordLabel.height/2;
			
			addChild(_wordLabel);
			
			
			_recordLabel = new TextField(200, 100, "RECORDING", "Arial", 18, 0x22FF22, true);
			
			_recordLabel.x = _background.width/2 - _recordLabel.width/2;
			_recordLabel.y = _background.height/2 - _recordLabel.height/2;
			
			addChild(_wordLabel);	
			
			_recordLabel.visible = false;
		}
		
		override public function advanceTime(time:Number):void
		{
			_counter+= 40;
			
			if(_pulsing)
			{
				var diffX:Number = Math.sin(Math.PI * _counter/180) * 0.03;
				var diffY:Number = Math.cos(Math.PI * (_counter-150)/180) * 0.03;
				_background.scaleX = 1 - diffX;
				_background.scaleY = 1 - diffY;
				
				_background.x = 0 - (_originWidth - _background.width)/2;
				_background.y = 0 - (_originHeight - _background.height)/2;
			}else{
				_background.x = 0;
				_background.y = 0;
				scaleX = 1;
				scaleY = 1;
			}
			
			if(_paused) return;
			
			y -= _velocity;
			
			x = 30 * Math.sin(Math.PI * (y + _ybuffer)/180);
			x += _xaxis;
			
			if(y < -height)
				y = AppModel.screenHeight;
		}	
		
		private function onWordsSpoken(words:Array):void
		{
			var spoken:String = ""
			
			for each (var w:String in words)
			{
				spoken += cleanWord(w)+" ";
			}
			
			trace("WORDS: ", spoken);
//			_textOutput.text = spoken;
			
			for each (var spoke:String in words)
			{
				var a:String = cleanWord(this.word);
				var b:String = cleanWord(spoke);
				
				if(a == b)
				{
					explode();
					return;
				}
			}	
			
			reset();
			
			function cleanWord(word:String):String
			{
				word = word.toLowerCase();
				word = word.replace(/[.?!]/gi, "");
				
				return word;
			}
		}
		
		private function explode():void
		{
			Assets.getSound("pop").play();
			
			dispatchEvent(new Event(Event.COMPLETE));
			
			_paused = true;
			_background.visible = false;
			_wordLabel.visible = false;
			
			_particleSystem.x = _background.width/2;
			_particleSystem.y = _background.width/2;
			_particleSystem.addEventListener(Event.COMPLETE, onComplete);
			
			addChild(_particleSystem);
			Starling.juggler.add(_particleSystem);
			
			_particleSystem.start(0.1);
			
			function onComplete(event:Event):void
			{
				trace("EXPLODE COMPLETE");
				dispose();
				
			}	
			
		}		
		
	}
}