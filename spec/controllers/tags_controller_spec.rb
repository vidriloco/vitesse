# encoding: utf-8
require 'spec_helper'

describe TagsController do
  describe "GET index" do
    
    before(:each) do
      @tag = Factory(:bici_e)
    end
    
    it "asigna los tags encontrados por la busqueda a @tags" do
      Tag.should_receive(:where).with("contenido ILIKE ?", "%Musica%").and_return([@tag])
      get :index, :q => 'Musica'
      
      assigns(:tags).should eq([@tag])
    end
  end
end