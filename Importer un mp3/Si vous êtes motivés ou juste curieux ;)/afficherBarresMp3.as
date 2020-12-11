package {
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3%E2%80%93mp3-imports-streaming-controles-et-barres-visuelles/
	// Enfin celui la non, je vous le met en bonus ;)
	// Globalement c'est la même chose, en générant un dégradé de couleur aléatoire pour chaque barre ^_^
	// Servez vous de l'aide pour chaque propriété et ca devrait aller, au pire demandez.
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

	
	public class afficherBarresMp3 extends MovieClip {
		private var file:String ="../Ressources/Mp3/The Prodigy - Omen.mp3";
		
		// Réglages
		private var nbBarres:uint = 20;
		private var epaisseurBarre:int = 25;
		private var espaceEntreBarres:int = 1;
		private var versLeHaut:Boolean = true;
		
		private var hauteur:uint = 150;
		private var hauteurMini:uint = 50;
		
		private var degrade = true;
		private var couleurAleatoire:Boolean = true;
		// Couleur simple
		private var color:uint = 0x00ffcc;
		// Dégradé
		private var fillType:String = GradientType.LINEAR;
		// Random color dégradé
		private var colors:Array = [0xFFFFFF, 0x32323CD, 0x000000];
		private var alphas:Array = [1,1,1];
		private var ratios:Array = [0x00, 0xFF/3 ,0xFF];
		private var matr:Matrix = new Matrix();
		private var spreadMethod:String = SpreadMethod.PAD;
		// Paramètres matrice dégradé, cf. http://livedocs.adobe.com/flash/9.0_fr/ActionScriptLangRefV3/flash/geom/Matrix.html#createGradientBox%28%29
		private var Mrotation:Number  = Math.PI / 2; // 90°
		
		// Valeurs non paramétrables
		private var ba:ByteArray = new ByteArray();
		private var son:Sound = new Sound();
		private var sc:SoundChannel;
		private var t:Array = new Array();
		
		public function afficherBarresMp3():void{
			if(couleurAleatoire){
				// couleur aléatoire
				color = Math.round( Math.random()*0xFFFFFF );
				// couleurs aléatoires dégradé
				colors = new Array();
				alphas  = new Array();
				ratios = new Array();
				var numColors = Math.round( Math.random() * (4-2) ) +2;
				
				for(var i=0;i<numColors;i++){
					colors.push(Math.round( Math.random()*0xFFFFFF ));
					alphas.push(1);
					if(i==0)
						ratios.push(0x00);
					else if(i==numColors-1)
						ratios.push(0xFF);
					else
						ratios.push(0xFF/(numColors-1)*i);
					
				}
				/*
				for(var i=0;i<numColors;i++){
					trace(colors[i]);
					trace(alphas[i]);
					trace(ratios[i]);
					trace();
				}*/
			}
			
			creationBarres();
			son.load(new URLRequest(file));
			sc = son.play(0,1);
			
			this.addEventListener(Event.ENTER_FRAME, majSpectre);
		}
		
		private function creationBarres():void{
			for(var i=0;i<nbBarres;i++){
				var barre:Sprite = new Sprite();
				
				
				if(!degrade)
					barre.graphics.beginFill(color);
				else{
					matr.createGradientBox(epaisseurBarre, hauteurMini, Mrotation, 0, 0);
					barre.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
				}

				//barre.graphics.beginFill(color);
           	 	barre.graphics.drawRect(0, 0, epaisseurBarre, hauteurMini);
            	barre.graphics.endFill();

				t.push(barre);
				addChild(barre);
				barre.x =i*(epaisseurBarre + espaceEntreBarres);
				barre.cacheAsBitmap = true;
			}
		}
		
		private var cpt = 0;
		private function majSpectre(event:Event){
			cpt++;
			if(cpt >= 2){
				cpt = 0;
				SoundMixer.computeSpectrum(ba,true,0);
				var tab:Vector.<Number> = new Vector.<Number>();
				for(var i=0; i<256 ; i++){
					tab.push(ba.readFloat());
				}
					
				for(var j=0; j<nbBarres; j++){
					// Spectre à cet instant
					var pow:Number = tab[(Math.ceil(j*256/nbBarres))];
					pow = Math.abs((pow * (hauteur-hauteurMini)))+ hauteurMini;
					
					// Redimensionner/Redessiner
					t[j].graphics.clear();
					
					if(!degrade)
						t[j].graphics.beginFill(color);
					else{
						matr.createGradientBox(epaisseurBarre, pow, Mrotation, 0, 0);
						t[j].graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
					}
					
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