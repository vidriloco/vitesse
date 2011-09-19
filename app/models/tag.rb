class Tag < ActiveRecord::Base
  has_and_belongs_to_many :lugares
  
  
  def expone_atributos
    { :id => self.id, :name => self.contenido }
  end
end
