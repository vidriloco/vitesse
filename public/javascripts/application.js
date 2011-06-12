// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
});