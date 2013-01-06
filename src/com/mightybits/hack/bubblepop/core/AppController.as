package com.mightybits.hack.bubblepop.core
{
	public class AppController
	{	
		static private var _instance:AppController;
		
		[Bindable]
		public var currentState:String = "loading";
		
		public function AppController()
		{
			if(_instance) throw new Error("Singleton Error", this);
		}
		
		static public function get instance():AppController
		{
			if(!_instance)
				_instance = new AppController();
			
			return _instance;
		}	
		
		public function changeState(state:String):void
		{
			currentState = state;
		}	
		
		
	}
}