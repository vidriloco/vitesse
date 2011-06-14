# encoding: utf-8

Factory.define :usuario do |u|
  u.nombre "Anacleta"
  u.permisos 777
  u.password "prueba"
  u.password_confirmation "prueba"
  u.email "cleta@gmail.com"
end
