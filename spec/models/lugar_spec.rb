# encoding: utf-8
require 'spec_helper'

describe Lugar do

  before(:each) do
    @taller = Factory(:taller_tuercas)
  end

  it "debo poder cambiar las coordenadas de un lugar" do
    @taller.aplica_geo({"lat" => "19.4", "lon" => "-99.15"})
    @taller.coordenadas.lat.should == 19.4
    @taller.coordenadas.lon.should == -99.15
  end
  
  describe "habiendo algunos lugares registrados" do
    before(:each) do
      @cebolla = Factory(:cebolla_morada)
    end
    
    it "al buscarlo por su nombre parcial lo encuentro" do
      Lugar.busca({:nombre => 'La Cebolla'}, 1).should == [@cebolla]
    end
    
    it "al buscarlo por su nombre completo lo encuentro" do
      Lugar.busca({:nombre => 'La Cebolla Morada'}, 1).should == [@cebolla]
    end
    
    it "al buscarlo por su nombre con cambio de minúsculas-mayúsculas lo encuentro" do
      Lugar.busca({:nombre => 'La cebolla moradA'}, 1).should == [@cebolla]
    end
    
    it "al buscarlo por su nombre en blanco no debo encontrar ningún lugar" do
      Lugar.busca({:nombre => ''}, 1).should == []
    end
    
    it "buscando por dos tags asignados a dos lugares diferentes cada uno encuentro a los dos lugares" do
      resultados = Lugar.busca({:tags => "#{@cebolla.tags.first.id}, #{@taller.tags.first.id}"}, 1)
      resultados.should include(@taller)
      resultados.should include(@cebolla)
      resultados.size.should == 2
    end
    
    it "buscando por tags en blanco no debo encontrar ningún lugar" do
      Lugar.busca({:tags => ""}, 1).should == []
    end
    
    it "buscando por dos tags cualquiera que debe tener cada lugar que aparezca como resultado" do
      Lugar.busca({:tags => "#{@cebolla.tags.first.id}, #{@taller.tags.first.id}", :tags_inclusivo => 1}, 1).should == []
    end
    
    it "buscando por nombre y tags devuelve lugares registrados" do
      @cebolla_taller = Factory(:cebolla_morada_taller, :tags => @taller.tags)
      resultados = Lugar.busca({:tags => "#{@taller.tags.first.id}", :nombre => 'La Cebolla Morada' }, 1)
      resultados.should include(@cebolla_taller)
      resultados.should_not include(@cebolla)
      resultados.size.should == 1
    end
    
  end
  
  describe "habiendo varios registrados en clusters y otros alejados del clúster" do
  
    before(:each) do      
      @granados_parque=Factory(:taller_tuercas, 
                               :coordenadas => Point.from_lon_lat(-99.12000792, 19.33933915, 4326),
                               :tags => @taller.tags)
      @naranjos_duraznos_parque=Factory(:taller_tuercas, 
                                        :coordenadas => Point.from_lon_lat(-99.124864, 19.348549, 4326),
                                        :tags => @taller.tags)
      @izt_viga =Factory(:taller_tuercas, 
                         :coordenadas => Point.from_lon_lat(-99.121850, 19.357467, 4326),
                         :tags => @taller.tags) 
    end
  
    it "usando tags busca dentro del área del mapa donde está el clúster debo encontrar los lugares, pero no todos" do
      rs=Lugar.busca({:tags => "#{@taller.tags.first.id}", 
                     :coordenadas => {:so => "19.33565648001082,-99.13297333717344", 
                                      :no => "19.350841289143293,-99.1150990962982"}},1)
      rs.should include(@granados_parque)
      rs.should include(@naranjos_duraznos_parque)
      rs.should_not include(@izt_viga)
    end
    
    it "usando nombre busca dentro del área del mapa donde está el clúster debo encontrar los lugares, pero no todos" do
      rs=Lugar.busca({:nombre => "Los tuercas", 
                      :coordenadas => {:so => "19.33565648001082,-99.13297333717344", 
                                      :no => "19.350841289143293,-99.1150990962982"}},1)
      rs.should include(@granados_parque)
      rs.should include(@naranjos_duraznos_parque)
      rs.should_not include(@izt_viga)
    end
  end
  
end
