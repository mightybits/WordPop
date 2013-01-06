package com.mightybits.hack.bubblepop.view.game
{

	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class InteractiveSprite extends BaseSprite {
		
		protected var _enable: Boolean = true;
		protected var _isPressed: Boolean;
		protected var _isRolledOver: Boolean;

		private var _useRoundCoordinates: Boolean = true;
		
		public function InteractiveSprite() 
		{
			addEventListener(TouchEvent.TOUCH, onTouchHandler);
		}
		
		public function get enable(): Boolean {return _enable;}
		
		public function set enable(value: Boolean): void 
		{
			_enable = value;
		}
		
		override public function set x(value: Number): void 
		{
			super.x = _useRoundCoordinates ? int(value) : value;
		}
		
		override public function set y(value: Number): void 
		{
			super.y = _useRoundCoordinates ? int(value) : value;
		}
		
		public function get useRoundCoordinates(): Boolean {return _useRoundCoordinates;}
		
		public function set useRoundCoordinates(value: Boolean): void 
		{
			_useRoundCoordinates = value;
			if (value) {
				x = x;
				y = y;
			}
		}
		
		protected function onTouchHandler(event: TouchEvent): void 
		{
			var touch: Touch = event.getTouch(this);
			if (touch) {
				switch (touch.phase) {
					case TouchPhase.HOVER:                                      // roll over
					{
						if (_isRolledOver) {
							return;
						}
						
						_isRolledOver = true;
						
//						dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
						break;
					}
						
					case TouchPhase.BEGAN:                                      // press
					{
						if (_isPressed) {
							return;
						}
						
						_isPressed = true;
						
//						dispatchEvent(new MouseEvent(MouseEvent.PRESS));
						break;
					}
						
					case TouchPhase.ENDED:                                      // click
					{
						_isPressed = false;
						
						isRolledOut();
						
						onClick();
//						dispatchEvent(new MouseEvent(MouseEvent.CLICK));
						break;
					}
						
					default :
					{
						
					}
				}
			} else {
				_isRolledOver = false;
				
//				dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
			}
		}
		
		protected function onClick():void
		{
			// override
		}
		
		private function isRolledOut(): Boolean {
			var stage: Stage = Starling.current.nativeStage;
			var mouseX: Number = stage.mouseX;
			var mouseY: Number = stage.mouseY;
			var bounds: Rectangle = getBounds(this);
			var point: Point = localToGlobal(new Point());
			if (mouseX > point.x &&
				mouseX < point.x + bounds.width &&
				mouseY > point.y &&
				mouseY < point.y + bounds.height) {
				return false;
			} else {
				_isRolledOver = false;
				
//				dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
				return true;
			}
			
		}
		
		// ------------------ END CLASS --------------------------------
		
	}
}