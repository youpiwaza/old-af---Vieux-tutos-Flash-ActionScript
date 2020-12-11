package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3%E2%80%93mp3-imports-streaming-controles-et-barres-visuelles/
	// Imports
	import flash.display.Sprite;
	
	import flash.events.Event;
	
    import flash.media.Sound;
    import flash.media.SoundChannel;
	
    import flash.net.URLRequest;
	
    public class importerMp3 extends Sprite{
        // Variables
		private var urlMp3:String = "Ressources/Mp3/The Prodigy - Omen.mp3";
		private var instanceSoundChannel:SoundChannel = new SoundChannel();
		
        // Constructeur
        public function importerMp3():void{
			var instanceSound:Sound = new Sound();
            instanceSound.load(new URLRequest(urlMp3));
			// On peut se permettre de commencer la lecture avant que le son ai été complètement chargé grace au streaming
            instanceSoundChannel = instanceSound.play();
        }
    } // Fin de classe
} // Fin de package