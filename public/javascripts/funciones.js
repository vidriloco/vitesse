/*
 Funciones para acciones relacionadas al mapa
*/
$.extend({
	estaPresente: function(dom) {
		return $(dom).length;
	}
	
	/**,incluir: function(jsname,pos) {
		var th = document.getElementsByTagName(pos)[0];
		var s = document.createElement('script');
		s.setAttribute('type','text/javascript');
		s.setAttribute('src',jsname);
		th.appendChild(s);
	}*/
});



var geo = {
	inicializaMapa: function(dom, opts) {
		var defaults = { 
			center: new google.maps.LatLng(parseFloat(19.4), parseFloat(-99.15)),
			zoom: 13,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: true,
      mapTypeControl: false,
			navigationControl: false,
			navigationControlOptions: {
				position: google.maps.ControlPosition.TOP_RIGHT
			}
		}

		var m = new google.maps.Map(document.getElementById(dom), $.extend(defaults, opts));
		
		google.maps.event.addListener(m, "click", function(event) {
			if($.estaPresente('#mapa-editable')) {
        $('#coordenadas_lat').val(event.latLng.lat());
        $('#coordenadas_lon').val(event.latLng.lng());
        
				geo.posiciona(mapa, {
					lat: event.latLng.lat(),
					lon: event.latLng.lng()
				});
				marcador=geo.ponMarcadorCentrado(mapa, marcador);
				geo.ponDireccionEn(mapa, '#mapa-editable p');
			}
    });

		return m;
	},
	
	posiciona: function(mapa, opts) {
		if(opts.lon && opts.lat) {
			mapa.setCenter(new google.maps.LatLng(parseFloat(opts.lat), parseFloat(opts.lon)));
		} 
		if(opts.zoom) {
			mapa.setZoom(opts.zoom);
		}
	},
	
	ponDireccionEn: function(mapa, dom) {		
		var geocoder = new google.maps.Geocoder();
		geocoder.geocode({'location': mapa.getCenter()}, function(results, status) {            
			if (status == google.maps.GeocoderStatus.OK) {
				var address = results[0].formatted_address;
				$(dom).html(""+address+"");
			} 
		});
	},
	
	ponMarcadorCentrado: function(mapa, marcador) {
		if(marcador != null) {
			marcador.setMap(null);
		}
		return new google.maps.Marker({
		      position: mapa.getCenter(), 
					map: mapa
		});
	},
	
	seleccionarPunto: function(mapa, latDom, lonDom) {
		google.maps.event.addListener(mapa, "click", function(event) {
				geo.posiciona(mapa, { zoom: 15 });
        $(latDom).val(event.latLng.lat());
        $(lonDom).val(event.latLng.lng());
        ponDireccionEn(mapa, "#geografia_direccion");
    });
	},
	
	leeCoordenadasDesde: function(latDom, lonDom) {
		if($(latDom).val() != "" && $(lonDom).val() != "") {
			geo.simulaSeleccionEnMapa($(latDom).val(), $(lonDom).val());
		}
	},
	simulaSeleccionEnMapa: function(lat, lon) {
		$('#coordenadas_lat').val(lat);
    $('#coordenadas_lon').val(lon);
    
		geo.posiciona(mapa, {
			lat: lat,
			lon: lon
		});
		marcador=geo.ponMarcadorCentrado(mapa, marcador);
		geo.ponDireccionEn(mapa, '#mapa-editable p');
	}
}