package com.mightybits.hack.bubblepop.view.game
{
	import com.mightybits.hack.bubblepop.core.AppController;
	import com.mightybits.hack.bubblepop.core.AppModel;
	
	import flash.utils.getTimer;
	
	import mx.collections.ArrayCollection;
	
	import assets.Assets;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class GameView extends AnimatedSprite
	{
		
		private const _minBalloons:int = 6;
		private var _totalBalloons:int = 0;
		private var _popped:int = 0;
		
		private var _words:Array;
		private var _balloons:ArrayCollection = new ArrayCollection();
		private var _selectedBloon:Ballon;
		private var _lastBalloonLanch:int = 0;
		private var _homeBtn:Button;
		
		
		public function GameView()
		{
			super();
			
			_words = AppModel.currentTheme.words.concat();
			
		}
		
		override protected function init():void
		{
			addChild(new Image(Assets.getTexture(AppModel.currentTheme.backgroundAsset)));		
			
			
			_homeBtn = addChild(new Button(Assets.getTexture("home_btn"))) as Button;
			_homeBtn.addEventListener(Event.TRIGGERED, onHome);
			
			_homeBtn.x = 10;
			_homeBtn.y = 10;
		}	
		
		private function onHome(event:Event):void
		{
//			AppController.instance.changeState("home");
			
			if(AppModel.currentTheme == AppModel.farmTheme)
			{
				AppModel.currentTheme = AppModel.ocenaTheme;
				(AppModel.starling.root as GameContainer).createGame();
			}else{
				AppModel.currentTheme = AppModel.farmTheme;
				(AppModel.starling.root as GameContainer).createGame();
			}
			
		}
		
		override public function advanceTime(time:Number):void
		{
			if(getTimer() - _lastBalloonLanch > 3000)
			{
				if(_totalBalloons < _minBalloons && _words.length > 0)
				{
					launchBalloon();
				}
			}			
		}
		
		private function launchBalloon():void
		{
			trace("launch");
			
			_lastBalloonLanch = getTimer();
			var bloon:Ballon = new Ballon(_words.shift());
			bloon.y = (Math.random() * 100) + AppModel.screenHeight;
			bloon.addEventListener(Event.COMPLETE, onBallonComplete);
			addChild(bloon);
			
			_totalBalloons++;
		}
		
		private function onBallonComplete(event:Event):void
		{
			var balloon:Ballon = event.currentTarget as Ballon;
			
			_totalBalloons--;
			_popped++;
			
			checkGameStatus();
			
		}
		
		private function checkGameStatus():void
		{
			if((_words.length <= 0 && _totalBalloons <= 0) || _popped >= 2)
			{
				
				Assets.getSound("cheer").play();
				
				var panel:Image = addChild(new Image(Assets.getTexture("game_over_panel"))) as Image;	
				
				panel.x = AppModel.screenWidth/2 - panel.width/2;
				panel.y = AppModel.screenHeight/2 - panel.height/2;
			}
		}
	}
}