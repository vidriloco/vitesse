# encoding: utf-8
require 'spec_helper'

describe Uslu do
  
  before(:each) do
    @usuario = Factory(:usuario)
    @lugar = Factory(:lugar)
  end
  
  describe "dado que tengo permisos de escritura sobre un lugar" do
  
    before(:each) do
      Factory(:uslu, :usuario_id => @usuario.id, :lugar_id => @lugar.id, :permisos => WRITEABLE)
    end
  
    it "debe devolvermelo para que pueda hacerle cambios" do
      Uslu.alterable(:usuario => @usuario.id, :lugar => @lugar.id).should == @lugar
    end
  end
  
  describe "dado que NO tengo permisos de escritura sobre un lugar" do
  
    before(:each) do
      Factory(:uslu, :usuario_id => @usuario.id, :lugar_id => @lugar.id, :permisos => READABLE)
    end
  
    it "debe devolverme un resultado vacío" do
      Uslu.alterable(:usuario => @usuario.id, :lugar => @lugar.id).should == nil
    end
  end
  
  it "puedo registrar un lugar y automáticamente puedo alterarlo" do
    Uslu.puede_alterar_a(@usuario.id, @lugar.id)
    u=Uslu.last
    u.usuario_id.should == @usuario.id
    u.lugar_id.should == @lugar.id
    u.permisos.should == WRITEABLE
  end
end
