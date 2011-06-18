#encoding: utf-8

Factory.define(:lugar) do |l|
  l.nombre "Daikoku Condesa"
  l.detalles "Rica comida japonesa tradicional"
  l.twitter "@daikokuCondesa"
  l.facebook "daikoku"
  l.sitio_web "www.grupodaikoku.com"
  l.telefono_uno "564738322"
  l.telefono_dos ""
  l.correo "daikoku@condesa.com"
  l.coordenadas Point.from_lon_lat(19.323, -99.123, 4326)
  l.tags {|t| [t.association(:restaurante), t.association(:bici_e)] }
end


Factory.define(:cebolla_morada, :class => Lugar) do |l|
  l.nombre "La Ceboolla Morada"
  l.detalles "Restaurante de comida mexicana suculenta. Especializados en cochinita pibil"
  l.twitter "@LaCebollaMorada"
  l.facebook "cebollamorada"
  l.sitio_web "www.grupodaikoku.com"
  l.telefono_uno "564738322"
  l.telefono_dos ""
  l.correo "daikoku@condesa.com"
  l.coordenadas Point.from_lon_lat(19.323, -99.123, 4326)
  l.tags {|t| [t.association(:restaurante), t.association(:bici_e)] }
end