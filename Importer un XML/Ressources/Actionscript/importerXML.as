package Ressources.Actionscript{
	// Fichier créé par Maxime CHEVASSON/Masamune pour le tutoriel situé à l'adresse suivante :
	// http://www.masamune.fr/blog/2010/12/actionscript-as3-xml-import-manipulation-et-utilisation/
	// Imports
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
    public class importerXML extends MovieClip {
        // Variables
		private var urlXML:String = "Ressources/XML/Masamune.xml";
		
        // Constructeur
        public function importerXML():void{
			var instanceURLLoader:URLLoader = new URLLoader();
			
			instanceURLLoader.addEventListener(Event.COMPLETE, URLLoaderComplete);
			instanceURLLoader.load(new URLRequest(urlXML));
        }

        // Fonctions
		private function URLLoaderComplete(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, URLLoaderComplete);
			var monXml:XML = new XML( e.target.data );
			
			// Afficher tout
			trace("Afficher l'ensemble du XMl :");
			// Notez qu'on ne passe pas par la balise "personnes" qui englobe l'ensemble, cf. fichier xml.
			trace(monXml.personne); trace();
			
			trace("Afficher un attribut :");
			trace(monXml.personne[0].caracteritiques.@nom); trace();
			
			trace("Afficher uniquement un type de sous élément :");
			trace(monXml.personne..sexe); trace();
			
			trace("Afficher un élément en fonction de la valeur d'un élément :");
			trace(monXml.personne.caracteritiques.(sexe == "Masculin").toXMLString()); trace();
			
			trace("Afficher un élément en fonction d'un attribut :");
			trace(monXml.personne.caracteritiques.(@nom == "Margot").toXMLString()); trace();
			
			// Affecter à une liste
			var liste:XMLList = monXml.elements();
			
			// Une liste peut être composée d'une partie d'un xml seulement.
			var liste2:XMLList = monXml.personne.caracteritiques.(sexe == "Masculin");
			// On peut ensuite effectuer les mêmes opérations sur ces sous ensembles..
		}
    } // Fin de classe
} // Fin de package