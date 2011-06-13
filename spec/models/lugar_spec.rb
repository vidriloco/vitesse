require 'spec_helper'

describe Lugar do

  before(:each) do
    @lugar = Factory.build(:lugar)
  end

  it "debo poder cambiar las coordenadas de un lugar" do
    @lugar.aplica_geo({"lat" => "19.4", "lon" => "-99.15"})
    @lugar.coordenadas.lat.should == 19.4
    @lugar.coordenadas.lon.should == -99.15
  end
  
end
