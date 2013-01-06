package com.mightybits.hack.bubblepop.core
{
	import com.mightybits.hack.bubblepop.AudioEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Microphone;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	public class AudioController extends EventDispatcher
	{
		public static var mic:Microphone = Microphone.getMicrophone();

		private var recorder:MicRecorder;		
		
		private var callBack:Function;
		
		public function AudioController()
		{
			this.callBack = callBack;
			
			init();
		}
		
		protected function init():void
		{
			
			recorder = new MicRecorder(new WaveEncoder(), mic, 50, 44, 0);
			recorder.addEventListener(RecordingEvent.TALK_COMPLETE, onTalkingComplete);

		}
		
		public function start():void
		{	
			recorder.record();	
			dispatchEvent(new AudioEvent(AudioEvent.MODE_TALKING));
		}
		
		public function stop():void
		{
			dispatchEvent(new AudioEvent(AudioEvent.MODE_THINKING));
			getTextFromSpeach();
		}
		
		private function getTextFromSpeach():void
		{
			
			
			trace(this, "getTextFromSpeach");
			
			var request:URLRequest = new URLRequest(AppModel.API_URL_SPEECH);
			request.requestHeaders.push(new URLRequestHeader("Authorization", "Bearer "+ AppModel.access_token));
			request.requestHeaders.push(new URLRequestHeader("Accept", "application/json"));
			request.requestHeaders.push(new URLRequestHeader("Content-Type", "audio/wav"));
			request.requestHeaders.push(new URLRequestHeader("X-SpeechContext", "SMS"));
			
			request.method = URLRequestMethod.POST;
			
			request.data = recorder.output;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onSpeechComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onSpeechError);
			
			loader.load(request);
			
			function onSpeechComplete(event:Event):void
			{
				var object:Object = JSON.parse(event.currentTarget.data);			
				var words:Array = [];
				var hypothesis:String;
				
				if(object.Recognition.Status == "OK")
				{
					words = object.Recognition.NBest[0].Words;
					hypothesis = object.Recognition.NBest[0].Hypothesis;
				}else{
					if(object.Recognition)
						trace("ERROR RESULT", object.Recognition.Status);	
				}
				
				dispatchEvent(new AudioEvent(AudioEvent.MODE_COMPLETE, words)); 			
			}
			
			function onSpeechError(event:IOErrorEvent):void
			{
				trace("ERROR SPEECH", event);
			}
		}
		
		
		protected function onTalkingComplete(event:Event):void
		{
			trace(this, "onTalkingComplete");
			
			stop();
		}
	}
}