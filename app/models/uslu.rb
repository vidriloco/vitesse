# Uslu : UsuariosLugares
class Uslu < ActiveRecord::Base
  
  belongs_to :lugar
  belongs_to :usuario
  
  def self.alterable(params)
    conds=["uslus.usuario_id = ? AND uslus.lugar_id = ? AND uslus.permisos = #{WRITEABLE}", params[:usuario], params[:lugar]]
    Lugar.first(:conditions => conds, :joins => :uslus)
  end
  
  def self.puede_alterar_a(usuario, lugar)
    self.create(:usuario_id => usuario, :lugar_id => lugar, :permisos => WRITEABLE)
  end
end
