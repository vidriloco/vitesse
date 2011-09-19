# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 
include Warden::Test::Helpers  

#TODO: Horarios
feature "Registro de lugares: " do

  background do
    visit root_path
  end
  
  describe "Estando en la pagina principal puedo acceder al formulario de registro", :js => true do
  
    before(:each) do
      Factory.create(:bici_e)
      Factory.create(:restaurante)
      @usuario=Factory.create(:usuario)
    end
    
    scenario "aunque si no estoy logeado tendré que estarlo" do
      click_link('Lugares')
      page.should have_content('Por ahora no hay lugares registrados')
      click_link('Registra uno')
      current_path.should == new_usuario_session_path
    end
    
    
    describe "solo si estoy logeado" do
      
      before(:each) do
        login_as(@usuario)
      end
      
      scenario "puedo regresar al listado de lugares sin haber registrado nada" do
        visit new_lugar_path
        click_link('Cancelar')
        current_path.should == lugares_path
        
        visit new_lugar_path
        click_link('Atrás')
        current_path.should == lugares_path
      end
      
      scenario "y guardar un lugar si tengo todos los campos requeridos", :js => true do
        click_link('Lugares')
    
        click_link('Registra uno')
        current_path.should == new_lugar_path
      
        page.should have_content('Nuevo lugar')
    
        page.should have_content('Selecciona su ubicación haciendo click en el mapa')
        page.should have_content('Usar mí ubicación actual')
        find_link('Determinar')
    
        find_field('Nombre')
        fill_in('Nombre', :with => 'La Cebolla Morada')
      
        find_field('Detalles')
        fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
      
        fill_in('Twitter', :with => '@LaCebollaMorada')
        fill_in('Facebook', :with => 'cebollaMorada')
      
        fill_token_input_field('Palabras Clave', :with => 'restaurante')
        fill_token_input_field('Palabras Clave', :with => 'comida')
      
        simula_click_gmaps(19.42007620847585, -99.25376930236814)
        sleep(3)
        find(:css, "#mapa-editable p").text.should_not be_blank

        click_on('Publicar')
      
        page.should have_content('El lugar ha sido añadido correctamente')
        current_path.should == lugar_path(Lugar.last)
        
        page.should have_content('La Cebolla Morada')
        page.should have_content('comida')
        
      end

=begin    scenario "y guardar un lugar si tengo todos los campos requeridos y elijo determinar mi ubicación al browser", :js => true do
      click_link('Lugares')
    
      click_link('Registrar nuevo')
      current_path.should == new_lugar_path
      
      page.should have_content('Nuevo lugar')
    
      page.should have_content('Selecciona su ubicación haciendo click en el mapa')
      page.should have_content('Usar mí ubicación actual')
      find_link('Determinar')
    
      find_field('Nombre')
      fill_in('Nombre', :with => 'La Cebolla Morada')
      
      find_field('Detalles')
      fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
      
      fill_in('Twitter', :with => '@LaCebollaMorada')
      fill_in('Facebook', :with => 'cebollaMorada')
      
      fill_token_input_field('Palabras Clave', :with => 'restaurante')
      
      click_on('Determinar')
      #ninguno de los dos sirve
      #page.driver.browser.switch_to.alert.accept
      #page.evaluate_script('window.confirm = function() { return true; }')
      
      
      find(:css, "#mapa-editable p").text.should_not be_blank

      click_on('Publicar')
      
      page.should have_content('El lugar ha sido añadido correctamente')
      current_path.should == lugar_path(Lugar.last)
    end
=end
      scenario "pero no podré guardarlo si hace falta el nombre" do
        visit(new_lugar_path)
        fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
        fill_in('Twitter', :with => '@LaCebollaMorada')
      
        fill_token_input_field('Palabras Clave', :with => 'restaurante')
        click_on('Publicar')
      
        page.should have_content('Wikicleta no pudo registrar este lugar debido a:')
        page.should have_content('Nombre no puede estar en blanco')
      end
    
      scenario "pero no podré guardarlo si no hay detalles" do
        visit(new_lugar_path)
        fill_in('Nombre', :with => 'La Cebolla Morada')
        fill_in('Twitter', :with => '@LaCebollaMorada')
      
        fill_token_input_field('Palabras Clave', :with => 'restaurante')
        click_on('Publicar')
      
        page.should have_content('Wikicleta no pudo registrar este lugar debido a:')
        page.should have_content('Detalles no puede estar en blanco')
      end
    
      scenario "pero no podré guardarlo si no hay palabras clave" do
        visit(new_lugar_path)
        fill_in('Nombre', :with => 'La Cebolla Morada')
        fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
        fill_in('Twitter', :with => '@LaCebollaMorada')
      
        click_on('Publicar')
      
        page.should have_content('Wikicleta no pudo registrar este lugar debido a:')
        page.should have_content('Palabras Clave debe incluir al menos una')
      end
    
      scenario "pero no podré guardarlo si no he seleccionado una ubicación en el mapa" do
        visit(new_lugar_path)
        fill_in('Nombre', :with => 'La Cebolla Morada')
        fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
        fill_in('Twitter', :with => '@LaCebollaMorada')
        fill_token_input_field('Palabras Clave', :with => 'restaurante')
      
        click_on('Publicar')
      
        page.should have_content('Wikicleta no pudo registrar este lugar debido a:')
        page.should have_content('No ha sido seleccionada una ubicación para este lugar')
      end
    end
  end

end