package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3%E2%80%93mp3-imports-streaming-controles-et-barres-visuelles/
	// Imports
    import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
	import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    public class importerMp3Avance extends Sprite {
		// Variables
        private var sound:Sound = new Sound();
        private var channel:SoundChannel;
        private var tfChargement:TextField = new TextField();
		private var tfLecture:TextField = new TextField();

		// Constructeur
        public function importerMp3Avance(){
            tfChargement.autoSize = TextFieldAutoSize.LEFT;
			this.addChild(tfChargement);
			tfLecture.autoSize = TextFieldAutoSize.LEFT;
			this.addChild(tfLecture);
			tfLecture.y = 50;
			
			var req:URLRequest = new URLRequest("Ressources/Mp3/The Prodigy - Omen.mp3");
            
			sound.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
            try {
                sound.load(req);
                channel = sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            }
            catch (err:Error) {
                trace(err.message);
            }
        }
    	
		//Fonctions
        private function progressHandler(e:ProgressEvent):void {    
            var loadTime:Number = sound.bytesLoaded / sound.bytesTotal;
            var loadPercent:uint = Math.round(100 * loadTime);
            var estimatedLength:int = Math.ceil(sound.length / (loadTime));
            var playbackPercent:uint = Math.round(100 * (channel.position / estimatedLength));
      
            tfChargement.text = 	"Chargement : " + sound.bytesLoaded +"/"+ sound.bytesTotal + " bytes.\n" 
                                   + "Pourcentage du fichier chargé : " + loadPercent + "%.\n"
                                   + "Lecture du mp3 en chargement : " + playbackPercent + "% complete.";
			
			if(loadPercent == 100){
				sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				sound.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				
				tfChargement.text = "Pourcentage du fichier chargé : " + loadPercent + "%.\n"
                                  	+ "Chargement terminé avec succès !";
			}
        }
 
        private function errorHandler(errorEvent:IOErrorEvent):void {
			sound.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
            tfChargement.text = "Le fichier n'a pu être chargé : " + errorEvent.text;
        }

        private function soundCompleteHandler(event:Event):void {
			channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
            tfChargement.text = "Le fichier à correctement été lu.";
        }
		
		private function enterFrameHandler(e:Event):void{
			tfLecture.text = "Lecture du mp3 : "+String(Math.ceil(channel.position/1000)) +"/"+ Math.ceil(sound.length/1000) +" en secondes.";
		}
    }
}