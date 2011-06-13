# encoding:utf-8
class Lugar < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  validates_presence_of :nombre, :detalles
  validate :presencia_de_tags
  validate :tiene_una_ubicacion
  
  cattr_reader :per_page 
  @@per_page = 5
  
  attr_accessor :tags_lista
  
  def tags_lista=(ids)
    self.tag_ids = ids.split(",") if ids.is_a?(String)
  end
  
  def aplica_geo(hash)
    return self if hash["lon"].blank? || hash["lat"].blank?
    self.coordenadas = Point.from_lon_lat(hash["lon"].to_f, hash["lat"].to_f, 4326)
    self
  end
  
  protected
    def presencia_de_tags
      errors.add(:base, 'Palabras Clave debe incluir al menos una') if self.tags.empty?
    end
    
    def tiene_una_ubicacion
      errors.add(:base, 'No ha sido seleccionada una ubicación para este lugar') if self.coordenadas.nil?
    end
end
