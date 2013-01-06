package com.mightybits.hack.bubblepop.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Microphone;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import org.bytearray.micrecorder.MicRecorder;
	import org.bytearray.micrecorder.encoder.WaveEncoder;
	import org.bytearray.micrecorder.events.RecordingEvent;

	public class AudioController
	{
		private var mic:Microphone;
		private var encoder:WaveEncoder;
		private var recorder:MicRecorder;
		
		private var recording:Boolean = false;
		
		private var callBack:Function;
		
		public function AudioController(callBack:Function)
		{
			this.callBack = callBack;
			
			init();
		}
		
		protected function init():void
		{
			
			mic = Microphone.getMicrophone();
			
			mic.setSilenceLevel(0);
			mic.gain = 50;
			
			encoder = new WaveEncoder();
			recorder = new MicRecorder(encoder, mic);
			recorder.addEventListener(RecordingEvent.TALK_COMPLETE, onTalkingComplete);
			recorder.record();
		}
		
		public function start():void
		{	
			recording = true;
			recorder.record();	
		}
		
		public function stop():void
		{
			recording = false;
			recorder.stop();
		}
		
		public function restart():void
		{
			if(recording) recorder.record();	
		}	
		
		
		private function getTextFromSpeach():void
		{
			var request:URLRequest = new URLRequest(AppModel.API_URL_SPEECH);
			request.requestHeaders.push(new URLRequestHeader("Authorization", "Bearer "+ AppModel.access_token));
			request.requestHeaders.push(new URLRequestHeader("Accept", "application/json"));
			request.requestHeaders.push(new URLRequestHeader("Content-Type", "audio/wav"));
			request.requestHeaders.push(new URLRequestHeader("X-SpeechContext", "Generic"));
			
			request.method = URLRequestMethod.POST;
			
			request.data = recorder.output;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onSpeechComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onSpeechError);
			
			loader.load(request);
			
			function onSpeechComplete(event:Event):void
			{
				var object:Object = JSON.parse(event.currentTarget.data);			
				var words:Array;
				var hypothesis:String;
				
				if(object.Recognition.Status == "OK")
				{
					words = object.Recognition.NBest[0].Words;
					hypothesis = object.Recognition.NBest[0].Hypothesis;
					
					submitWords(words);
				}else{
					if(object.Recognition)
						trace("ERROR RESULT", object.Recognition.Status);	
				}
				
			}
			
			function onSpeechError(event:IOErrorEvent):void
			{
				trace("ERROR SPEECH", event);
			}
		}
		
		private function submitWords(words:Array):void
		{
			callBack(words);
		}
		
	/*	protected function playSound(event:MouseEvent):void
		{
			trace("PLAY");
			
			var player:WavSound = new WavSound(recorder.output);
			player.play();	
		}*/
		
		protected function onTalkingComplete(event:Event):void
		{
			recorder.stop();
			
			getTextFromSpeach();
			
			restart();
		}
	}
}