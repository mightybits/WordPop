package com.mightybits.hack.bubblepop.view.game
{
	public class GameContainer extends BaseSprite
	{
		
		private var _game:GameView;
		
		public function GameContainer()
		{
			super();

		}
		
		public function createGame():void
		{
			removeGame();
			
			_game = new GameView();
			addChild(_game);
		}	
		
		public function removeGame():void
		{
			if(_game)
				removeChild(_game);
		}	
	}
}