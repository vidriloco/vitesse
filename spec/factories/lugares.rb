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
  l.coordenadas Point.from_lon_lat(-99.123, 19.323, 4326)
  l.tags {|t| [t.association(:restaurante), t.association(:bici_e)] }
end


Factory.define(:cebolla_morada, :class => Lugar) do |l|
  l.nombre "La Cebolla Morada"
  l.detalles "Restaurante de comida mexicana suculenta. Especializados en cochinita pibil"
  l.twitter "@LaCebollaMorada"
  l.facebook "cebollamorada"
  l.sitio_web "www.cebollamorada.com"
  l.telefono_uno "564738322"
  l.telefono_dos ""
  l.correo "comida@cebollamorada.com"
  l.coordenadas Point.from_lon_lat(-99.171610, 19.405704, 4326)
  l.tags {|t| [t.association(:restaurante), t.association(:bici_e)] }
end

Factory.define(:cebolla_morada_taller, :class => Lugar) do |l|
  l.nombre "La Cebolla Morada"
  l.detalles "El taller de la patrona"
  l.twitter "@LaCebollaMoradaTaller"
  l.facebook "cebollamoradataller"
  l.sitio_web "taller.cebollamorada.com"
  l.telefono_uno "564573832"
  l.telefono_dos ""
  l.correo "taller@cebollamorada.com"
  l.coordenadas Point.from_lon_lat(-99.171610, 19.405704, 4326)
  l.tags {|t| [t.association(:taller), t.association(:bici_e)] }
end

Factory.define(:taller_tuercas, :class => Lugar) do |l|
  l.nombre "Los tuercas"
  l.detalles "Este es el buen taller de unos amigos sureños del pedal"
  l.twitter ""
  l.facebook ""
  l.sitio_web ""
  l.telefono_uno "566783932"
  l.telefono_dos ""
  l.correo ""
  l.coordenadas Point.from_lon_lat(-99.137192, 19.305776, 4326)
  l.tags {|t| [t.association(:taller), t.association(:bicis_ruta), t.association(:cascos)] }
end