// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// application.js -> base.js por extraña doble carga usando 
// javascript_include_tag :defaults 

var mapa;
var marcador;

$(document).ready(function() {
		
		if($.estaPresente('.messages-and-alerts')) {
			if($('.messages-and-alerts p').text() != "") {
				var klass = $('.messages-and-alerts p').attr('class');
				$('.messages-and-alerts').addClass(klass);
				$('.messages-and-alerts').fadeIn().delay(4000).fadeOut('slow');
			}
		}	
		
		
		if($.estaPresente('.reciente-act')) {
			$('.reciente-act').click(function() {
				if($('.lugares .recientes').hasClass('oculto')) {
					$('.lugares .recientes').removeClass('oculto');
					$(this).addClass('negro');
				} else {
					$('.lugares .recientes').addClass('oculto');
					$(this).removeClass('negro');
				}
			});
		}
		
		if($.estaPresente('.bloque .titulo')) {
			$('.bloque .titulo a').click(function() {
				if($(this).parent().next().hasClass('oculto')) {
					$(this).parent().next().removeClass('oculto');
				} else {
					$(this).parent().next().addClass('oculto');
				}
			});
		}
		
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
		
		if($.estaPresente('#mapa-pasivo')) {
			if($.estaPresente('.pon-en-pos')) {
				geo.leeCoordenadasDesdeHacia("#coordenadas_lat", "#coordenadas_lon", '.direccion');
				geo.posiciona(mapa, {zoom: 17});
				$('.pon-en-pos').click(function() {
					geo.posiciona(mapa, {lon: marcador.getPosition().lng(), lat: marcador.getPosition().lat()});
				});
			}
			
			if($.estaPresente('.pos-en-mapa')) {
				$('.pos-en-mapa').click(function() {
					var lat = $(this).parent().siblings('#lat').val();
					var lon = $(this).parent().siblings('#lon').val();
					geo.posiciona(mapa, {zoom: 17, lon: lon, lat : lat});
					geo.ponMarcadorCentrado(mapa, marcador);
				});
			}
		}
		
		if($.estaPresente('.charcounter-250')) {
			$(".charcounter-250").charCounter(250, {
					container: "#charCount",
	        format: "%1 caracteres restantes",
	        delay: 100,
	        pulse: false
	    });
		}
		
		if($.estaPresente('#mapa-editable')) {
			
			geo.leeCoordenadasDesdeHacia("#coordenadas_lat", "#coordenadas_lon", '#mapa-editable p');
			
			//determine if the handset has client side geo location capabilities
			$('.pregunta-pos').click(function() {
				if(geo_position_js.init()){
			   	geo_position_js.getCurrentPosition(function(p) {
						geo.simulaSeleccionEnMapa(p.coords.latitude, p.coords.longitude, '#mapa-editable p');
					}, function() {
						alert("Ocurrió un error al intentar obtener tú ubicación. Seleccionala del mapa por favor ó intenta de nuevo.");
					}, {enableHighAccuracy:true});
				}
				else{
			   	alert("No fue posible obtener tu ubicación de manera automática. Seleccionala del mapa por favor.");
				}
			});
		}
		
		if($.estaPresente('.confirmacion-de-eliminacion')) {
			$(document.body).addClass('color-de-confirmacion-de-eliminacion');
			geo.leeCoordenadasDesdeHacia("#coordenadas_lat", "#coordenadas_lon", '.confirmacion-de-eliminacion .direccion');
			geo.posiciona(mapa, {zoom: 17});
		}
});