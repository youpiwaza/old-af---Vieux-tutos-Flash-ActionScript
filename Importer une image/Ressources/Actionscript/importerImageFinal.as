package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/11/actionscript-as3-creer-une-classe-pour-importer-une-image/
	
	// Imports
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	
	import flash.events.Event;
	
	import flash.net.URLRequest;
	
    public class importerImageFinal extends MovieClip {
        // Variables
		private var instanceBitmap:Bitmap;
		private var instanceBitmapData:BitmapData;
		
        // Constructeur
        public function importerImageFinal(urlImage:String):void{
			var instanceLoader:Loader = new Loader();
			
			instanceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
			instanceLoader.load(new URLRequest(urlImage));
        }

        // Fonctions
		private function loaderComplete(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, loaderComplete);
			
			instanceBitmap = e.target.content as Bitmap;
			addChild(instanceBitmap);
			
			instanceBitmapData = instanceBitmap.bitmapData;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getBitmapData():BitmapData{
			return instanceBitmapData;
		}
    } // Fin de classe
} // Fin de package