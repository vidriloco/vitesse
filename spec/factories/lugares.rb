#encoding: utf-8

Factory.define(:lugar) do |l|
  l.nombre "Daikoku Condesa"
  l.detalles "Rica comida japonesa tradicional"
  l.twitter "@daikokuCondesa"
  l.facebook ""
  l.sitio_web "www.grupodaikoku.com"
  l.telefono_uno "564738322"
  l.telefono_dos ""
  l.correo "daikoku@condesa.com"
  l.tags {|t| [t.association(:restaurante), t.association(:bici_e)] }
end
