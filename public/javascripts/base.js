// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// application.js -> base.js por extraña doble carga usando 
// javascript_include_tag :defaults 

var mapa;
var marcador;

$(document).ready(function() {
		$('#notice').delay(2700).fadeOut('slow');
    $('#alert').delay(2700).fadeOut('slow');
		
		if($.estaPresente('#map_canvas')) {
			mapa = geo.inicializaMapa('map_canvas', {
				backgroundColor: 'black',
				zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }
			});
		}
		
		if($.estaPresente('#lugar_tags_lista')) {
			$("#lugar_tags_lista").tokenInput("/tags.json", {
				prePopulate: $("#lugar_tags_lista").data("pre"),
				crossDomain: false,
				theme: 'facebook',
				preventDuplicates: true,
				noResultsText: 'No hay resultados que mostrar',
				hintText: 'Escribe un término de búsqueda',
				searchingText: 'Buscando...'
			});  
		}
		
		if($.estaPresente('#mapa-editable')) {
			
			geo.leeCoordenadasDesde("#coordenadas_lat", "#coordenadas_lon");
			
			//determine if the handset has client side geo location capabilities
			$('.pregunta-pos').click(function() {
				if(geo_position_js.init()){
			   	geo_position_js.getCurrentPosition(function(p) {
						geo.simulaSeleccionEnMapa(p.coords.latitude, p.coords.longitude);
					}, function() {
						alert("Ocurrió un error al intentar obtener tú ubicación. Seleccionala del mapa por favor ó intenta de nuevo.");
					}, {enableHighAccuracy:true});
				}
				else{
			   	alert("No fue posible obtener tu ubicación de manera automática. Seleccionala del mapa por favor.");
				}
			});
		}
});