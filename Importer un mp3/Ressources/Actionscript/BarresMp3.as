package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3%E2%80%93mp3-imports-streaming-controles-et-barres-visuelles/
	// Imports
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import flash.geom.*
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	import flash.net.URLRequest;
	
	import flash.utils.ByteArray;

	public class BarresMp3 extends MovieClip {
		private var file:String = "Ressources/Mp3/The Prodigy - Omen.mp3";
		
		// Réglages
		private var nbBarres:uint = 256;
		private var epaisseurBarre:int = 1;
		private var espaceEntreBarres:int = 1;
		private var versLeHaut:Boolean = true;
		
		private var hauteur:uint = 175;
		private var hauteurMini:uint = 10;
		
		// Valeurs non paramétrables
		private var ba:ByteArray = new ByteArray();
		private var son:Sound = new Sound();
		private var sc:SoundChannel;
		private var t:Array = new Array();
		private var color:uint;
		
		// Constructeur
		public function BarresMp3():void{
			// couleur aléatoire
			color = Math.round( Math.random()*0xFFFFFF );
			
			creationBarres();
			son.load(new URLRequest(file));
			sc = son.play(0,1);
			
			this.addEventListener(Event.ENTER_FRAME, majSpectre);
		}
		
		private function creationBarres():void{
			for(var i=0;i<nbBarres;i++){
				var barre:Sprite = new Sprite();
				
				barre.graphics.beginFill(color);

           	 	barre.graphics.drawRect(0, 0, epaisseurBarre, hauteurMini);
            	barre.graphics.endFill();

				t.push(barre);
				addChild(barre);
				barre.x = i*(epaisseurBarre + espaceEntreBarres);
				barre.cacheAsBitmap = true;
			}
		}
		
		private var cpt = 0;
		private function majSpectre(e:Event){
			cpt++;
			if(cpt >= 3){
				cpt = 0;
				
				// Spectre à cet instant
				SoundMixer.computeSpectrum(ba,true,0);
				var tab:Vector.<Number> = new Vector.<Number>();
				for(var i=0; i<256 ; i++){
					tab.push(ba.readFloat());
				}
					
				for(var j=0; j<nbBarres; j++){
					
					var pow:Number = tab[(Math.ceil(j*256/nbBarres))];
					pow = Math.abs((pow * (hauteur-hauteurMini)))+ hauteurMini;
					
					// Redimensionner/Redessiner
					t[j].graphics.clear();
					
					t[j].graphics.beginFill(color);
					
					t[j].graphics.drawRect(0, 0, epaisseurBarre, pow);
					t[j].graphics.endFill();
		
					// Retourner
					if(versLeHaut)
						t[j].y = stage.stageHeight/2 - t[j].height;
					else
						t[j].y = stage.stageHeight/2;
				}
			
			}
		}
	}
}