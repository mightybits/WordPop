package com.mightybits.hack.bubblepop.core
{
	import com.mightybits.hack.bubblepop.data.Theme;
	
	import flash.geom.Rectangle;
	
	import starling.core.Starling;

	public class AppModel
	{
		public static var screenWidth:int;
		public static var screenHeight:int;
		
		public static const APP_KEY:String = "61e80e33bb249d92d4ea046e5287019a";
		public static const APP_SECRET:String = "6de94cc942365112";
	
		// OATH Token
		public static const API_URL_OAUTH_TOKEN:String = "https://api.att.com/oauth/token";
		public static var access_token:String;
		public static var expires_in:int;
		public static var refresh_token:String;
		
		public static const API_URL_SPEECH:String = "https://api.att.com/rest/2/SpeechToText";
		
		public static var currentTheme:Theme;
		public static var farmTheme:Theme;
		public static var ocenaTheme:Theme;
		
		public static var starling:Starling;
		
		public static function getViewPort():Rectangle
		{
			return new Rectangle(0,0,screenWidth, screenHeight);
			
		}	

		public function AppModel()
		{
			
		}
	}
}