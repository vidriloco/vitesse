# encoding:utf-8
class Lugar < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  has_many :uslus
  has_many :usuarios, :through => :uslus
  
  validates_presence_of :nombre, :detalles
  validate :presencia_de_tags
  validate :tiene_una_ubicacion
    
  cattr_reader :per_page 
  @@per_page = 5
  
  attr_accessor :tags_lista
  
  def tags_lista=(ids)
    self.tag_ids = ids.split(",").inject([]) do |resultado, token|
      token = token.to_i if token.to_i > 0
      if token.is_a?(String)
        token.gsub!("'", "")
        resultado << Tag.create(:contenido => token).id 
      end
      
      resultado << token if token.is_a?(Integer)
      resultado
    end    
  end
  
  def aplica_geo(hash)
    return self if hash["lon"].blank? || hash["lat"].blank?
    self.coordenadas = Point.from_lon_lat(hash["lon"].to_f, hash["lat"].to_f, 4326)
    self
  end
  

  
  #condicion_nombre = "nombre ILIKE ?", "%#{params[:nombre]}%"
=begin
  def self.busca(params, pagina)
    return [] if params[:nombre].blank? && params[:tags].blank?
    
    geo=""
    if params[:coordenadas]
      geo = "AND ST_Within(lugares.coordenadas, ST_GeomFromEWKT(E'#{Lugar.poligono(params[:coordenadas]).as_hex_ewkb}'))"
    end
     
    unless params[:nombre].blank?
      return Lugar.paginate(:page => pagina, :conditions => ["nombre ILIKE ?", "%#{params[:nombre]}%"])
    end
     
    unless params[:tags].blank?
      
      clausula_inclusion = params[:tags_inclusivo].blank? ? "IN" : "= ALL"
      
      return Lugar.paginate_by_sql("SELECT * FROM lugares
      LEFT OUTER JOIN lugares_tags ON lugares_tags.lugar_id = lugares.id
      WHERE lugares_tags.tag_id #{clausula_inclusion} (SELECT id FROM tags WHERE id IN (#{params[:tags]}))
      #{geo}", :page => pagina, :per_page => per_page)
    end
  end
=end
  
  def self.busca(params, pagina)
    return [] if params[:nombre].blank? && params[:tags].blank?
    
    dentro_de=""
    nombre=""
    join=""
    subquery=""
    
    poli = Lugar.poligono(params[:coordenadas])
    unless poli.nil?
      dentro_de = "AND ST_Within(lugares.coordenadas, ST_GeomFromEWKT(E'#{poli.as_hex_ewkb}'))"
    end
    
    unless params[:nombre].blank?
      nombre="nombre ILIKE '%#{params[:nombre]}%'"
    end
     
    unless params[:tags].blank?
      clausula_inclusion = params[:tags_inclusivo].blank? ? "IN" : "= ALL"
      join="JOIN lugares_tags ON lugares_tags.lugar_id = lugares.id"
      subquery="lugares_tags.tag_id #{clausula_inclusion} (SELECT id FROM tags WHERE id IN (#{params[:tags]}))"
      subquery+= " AND" unless nombre.blank?
    end
     
    return Lugar.paginate_by_sql("SELECT * FROM lugares #{join} WHERE #{subquery} #{nombre} #{dentro_de}", 
                                :page => pagina, :per_page => per_page)
    
  end
  
  def self.poligono(coordenadas)
    return nil if coordenadas.nil?
    return nil if coordenadas[:so].blank? || coordenadas[:no].blank?
    
    lat_so, lon_so = coordenadas[:so].split(',').map { |n| n.to_f }
    lat_no, lon_no = coordenadas[:no].split(',').map { |n| n.to_f }
    
    # Empezando en (0,0) en sentido de las manecillas del reloj
    Polygon.from_coordinates([[[lon_so, lat_no], [lon_no, lat_no], [lon_no, lat_so], [lon_so, lat_so], [lon_so, lat_no]]],4326)
  end
  
  protected
    def presencia_de_tags
      errors.add(:base, 'Palabras Clave debe incluir al menos una') if self.tags.empty?
    end
    
    def tiene_una_ubicacion
      errors.add(:base, 'No ha sido seleccionada una ubicación para este lugar') if self.coordenadas.nil?
    end
end
