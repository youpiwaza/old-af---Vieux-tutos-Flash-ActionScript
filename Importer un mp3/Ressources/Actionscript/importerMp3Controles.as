package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3%E2%80%93mp3-imports-streaming-controles-et-barres-visuelles/
	// Imports
	import fl.controls.Button;
	import fl.controls.Slider;
	
	import fl.events.SliderEvent;
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	
    import flash.media.Sound;
    import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
    import flash.net.URLRequest;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import fl.transitions.Zoom;
	
    public class importerMp3Controles extends Sprite{
        // Variables
		private var urlMp3:String = "Ressources/Mp3/The Prodigy - Omen.mp3";
		private var instanceSound:Sound = new Sound();
		private var instanceSoundChannel:SoundChannel = new SoundChannel();
		private var sauvST:SoundTransform = new SoundTransform();
		private var pos:uint = 0;
		private var btnPlayPause:Button = new Button();
		// Placement composant
		private var marge:uint = 20;
		
        // Constructeur
        public function importerMp3Controles():void{
            instanceSound.load(new URLRequest(urlMp3));
			configControles();
			
			sauvST.volume = 0.5;
			instanceSoundChannel.soundTransform = sauvST;
        }
		
		// Fonctions
		function configControles():void{
			// Bouton play/pause
			btnPlayPause.label = "play";
			addChild(btnPlayPause);
			btnPlayPause.x = marge;
			btnPlayPause.y = marge;
			btnPlayPause.addEventListener( MouseEvent.CLICK, onPlayclic );
			
			// Bouton stop
			var btnStop:Button = new Button();
			btnStop.label = "stop";
			addChild(btnStop);
			btnStop.x = btnPlayPause.width + 2*marge;
			btnStop.y = marge;
			btnStop.addEventListener( MouseEvent.CLICK, onStopclic );
			
			// Slider volume
			var labelVolume:TextField = new TextField();
			labelVolume.text = "Volume";
			addChild(labelVolume);
			labelVolume.x = marge;
			labelVolume.y = btnPlayPause.height + 2*marge;
			labelVolume.autoSize = TextFieldAutoSize.LEFT;
			
			var sldVolume:Slider = new Slider();
			addChild(sldVolume);
			sldVolume.x = marge;
			sldVolume.y = btnPlayPause.height + 4*marge - 10;
			sldVolume.liveDragging = true;
			sldVolume.minimum = 0;
			sldVolume.maximum = 1;
			sldVolume.snapInterval = 0.01;
			sldVolume.tickInterval = 0.25;
			sldVolume.value = 0.5;
			sldVolume.addEventListener( SliderEvent.CHANGE, onVolumeChange );
			
			// Slider balance
			var labelBalance:TextField = new TextField();
			labelBalance.text = "Balance";
			addChild(labelBalance);
			labelBalance.x = marge;
			labelBalance.y = btnPlayPause.height + 5*marge;
			labelBalance.autoSize = TextFieldAutoSize.LEFT;
			
			var sldBalance:Slider = new Slider();
			addChild(sldBalance);
			sldBalance.x = marge;
			sldBalance.y = btnPlayPause.height + sldVolume.height + 6*marge + 10;
			sldBalance.liveDragging = true;
			sldBalance.minimum = -1;
			sldBalance.maximum = 1;
			sldBalance.snapInterval = 0.01;
			sldBalance.tickInterval = 0.25;
			sldBalance.value = 0;
			sldVolume.addEventListener( SliderEvent.CHANGE, onBalanceChange );
		}
		
	// Fonctions des écouteurs
	function onPlayclic ( e:MouseEvent ):void{
		if(e.target.label == "play"){
			instanceSoundChannel = instanceSound.play(pos);
			e.target.label = "pause";
			instanceSoundChannel.soundTransform = sauvST;
		}
		else { // == "pause"
			pos = instanceSoundChannel.position;
			instanceSoundChannel.stop();
			e.target.label = "play";
		}
	}
	
	function onStopclic ( e:MouseEvent ):void{
		instanceSoundChannel.stop();
		btnPlayPause.label = "play";
		pos = 0;
	}
	
	function onVolumeChange ( e:SliderEvent ):void{
		// On récupère la valeur actuelle de ST, au cas ou le volume ou la balance aient déjà été changés,
		// pour ne pas perdre les autres réglages (cumul des prop)
		var newST:SoundTransform = instanceSoundChannel.soundTransform;
		newST.volume = e.target.value; // 0 à 1;
		instanceSoundChannel.soundTransform = newST;
		sauvST = newST;
	}
	
	function onBalanceChange ( e:SliderEvent ):void{
		var newST:SoundTransform = instanceSoundChannel.soundTransform;
		newST.pan = e.target.value; // -1 à 1
		instanceSoundChannel.soundTransform = newST;
		sauvST = newST;
	}
    } // Fin de classe
} // Fin de package





















