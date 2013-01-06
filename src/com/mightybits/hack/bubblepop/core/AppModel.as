package com.mightybits.hack.bubblepop.core
{
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
		

		public function AppModel()
		{
			
		}
	}
}