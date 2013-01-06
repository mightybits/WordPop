package com.mightybits.hack.bubblepop.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class AppServices
	{
		public function AppServices()
		{
		}
		
		static public function getServiceToken(success:Function, fail:Function):void
		{
			var request:URLRequest = new URLRequest(AppModel.API_URL_OAUTH_TOKEN);
			request.requestHeaders.push(new URLRequestHeader("Accept", "application/json"));
			request.requestHeaders.push(new URLRequestHeader("Content-Type", "application/x-www-form-urlencoded"));
			request.method = URLRequestMethod.POST;
			
			var data:URLVariables = new URLVariables();
			data.client_id = AppModel.APP_KEY;
			data.client_secret = AppModel.APP_SECRET;
			data.grant_type = "client_credentials";
			data.scope = "SPEECH";
			
			request.data = data;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onTokenComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onTokenError);
			
			loader.load(request);
			
			function onTokenComplete(event:Event):void
			{
				var object:Object = JSON.parse(event.currentTarget.data);	
				AppModel.access_token = object.access_token;
				AppModel.expires_in = int(object.expires_in);
				AppModel.refresh_token = object.refresh_token;
				
				trace("Authenticated: ", AppModel.access_token);
				
				success();
			}
			
			function onTokenError(event:IOErrorEvent):void
			{
				fail();
			}
		}	
	}
}