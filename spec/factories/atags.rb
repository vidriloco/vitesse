#encoding: utf-8

Factory.define(:restaurante, :class => Tag) do |l|
  l.contenido "restaurante"
end

Factory.define(:bici_e, :class => Tag) do |l|
  l.contenido "bici estacionamiento"
end

Factory.define(:bicis_ruta, :class => Tag) do |l|
  l.contenido "bicis de ruta"
end

Factory.define(:cascos, :class => Tag) do |l|
  l.contenido "cascos"
end

Factory.define(:taller, :class => Tag) do |l|
  l.contenido "taller"
end

Factory.define(:palabra_clave, :class => Tag) do |l|
  l.contenido ""
end