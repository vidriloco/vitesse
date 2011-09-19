# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 
include Warden::Test::Helpers  

feature "Eliminación de lugares: " do
  
  before(:each) do
    @lugar=Factory(:lugar)
  end
  
  describe "Dado que NO estoy logeado" do
  
    scenario "me regresa a la página del lugar cada que intento acceder al path: lugares/1/eliminar" do
      visit confirm_destroy_lugar_path(@lugar)
      current_path.should == new_usuario_session_path
    end
  
  end

  describe "Estando logeado en la página con el listado de todos los lugares" do
  
    before(:each) do
      @usuario=Factory(:usuario)
      login_as @usuario
      visit lugares_path
    end
    
    describe "al consultar los detalles de un lugar" do
      
      before(:each) do
        click_link('detalles')
      end
      
      describe "dado que tengo todos los permisos sobre el lugar" do
        
        before(:each) do
          Factory(:uslu, :lugar_id => @lugar.id, :usuario_id => @usuario.id, :permisos => WRITEABLE)
        end
      
        scenario "puedo eliminarlo" do
          click_link('Eliminar')
          current_path.should == confirm_destroy_lugar_path(@lugar)
          page.should have_content(@lugar.nombre)
          page.should have_content('¿Realmente deseas eliminar este lugar?')
          find_link('No')
          click_on('Si')
        
          current_path.should == lugares_path
          page.should have_content('Por ahora no hay lugares registrados')
          click_link('Registra uno')
        end
        
        scenario "puedo decidir no eliminarlo" do
          click_link('Eliminar')
          page.should have_content('¿Realmente deseas eliminar este lugar?')
          find_button('Si')
          click_link('No')
          current_path.should == lugar_path(@lugar)
        end
      end
      
      describe "dado que NO tengo todos los permisos sobre el lugar" do
        
        before(:each) do
          Factory(:uslu, :lugar_id => @lugar.id, :usuario_id => @usuario.id, :permisos => READABLE)
        end
      
        scenario "me regresa a la página del lugar cada que intento acceder al path: lugares/1/eliminar" do
          visit confirm_destroy_lugar_path(@lugar)
          current_path.should == lugar_path(@lugar)
          page.should have_content('No tienes permisos suficientes para eliminar este lugar')
        end
      
        scenario "NO puedo eliminarlo" do
          click_link('Eliminar')
          current_path.should == lugar_path(@lugar)
          page.should have_content(@lugar.nombre)
          page.should have_content('No tienes permisos suficientes para eliminar este lugar')
        end
        
      end
      
    end
    
  end

end