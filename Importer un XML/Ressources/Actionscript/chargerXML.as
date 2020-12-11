package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/12/actionscript-as3-xml-import-manipulation-et-utilisation/
	// Imports
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
    public class chargerXML extends MovieClip {
        // Variables
		private var retour:XML;
		
        // Constructeur
        public function chargerXML(urlXML:String):void{
			var instanceURLLoader:URLLoader = new URLLoader();
			
			instanceURLLoader.addEventListener(Event.COMPLETE, URLLoaderComplete);
			instanceURLLoader.load(new URLRequest(urlXML));
        }

        // Fonctions
		private function URLLoaderComplete(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, URLLoaderComplete);
			retour = new XML( e.target.data );
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		// Accesseurs
		public function getXML():XML {
			return retour;
		}
    } // Fin de classe
} // Fin de package