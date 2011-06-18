# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 
include Warden::Test::Helpers  

feature "Modificación de lugares: " do

  describe "Estando en la página con el listado de todos los lugares", :js => true do
  
    before(:each) do
      @lugar=Factory(:cebolla_morada, :nombre => "La Ceboolla Morada", :facebook => "cebollamorada")
      @usuario=Factory(:usuario)
      Factory(:palabra_clave, :contenido => "punto de reunion ciclista")
      visit lugar_path(@lugar)
    end
    
    scenario "requiero iniciar sesión para poder modificar los campos de un lugar registrado" do
      click_link 'Modificar'
      current_path.should == new_usuario_session_path
    end
    
    
    describe "solo si estoy logeado" do
      
      before(:each) do
        login_as(@usuario)
      end
      
      scenario "puedo modificar los datos de un lugar", :js => true do
        click_link 'Modificar'
        current_path.should == edit_lugar_path(@lugar)
      
        page.should have_content('Modificar lugar')
    
        page.should have_content('Selecciona su ubicación haciendo click en el mapa')
        page.should have_content('Usar mí ubicación actual')
        
        find(:css, "#mapa-editable p").text.should_not be_blank
        
        find_link('Determinar')
    
        find_field('Nombre').value.should == 'La Ceboolla Morada'
        fill_in('Nombre', :with => 'La Cebolla Morada')
      
        find_field('Detalles').value.should == 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil'
        fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil y algo más')
      
        find_field('Twitter').value.should == '@LaCebollaMorada'
        
        find_field('Facebook').value.should == 'cebollamorada'
        fill_in('Facebook', :with => '')
            
        within('.token-input-list-facebook') do
          page.should have_content('restaurante')
          page.should have_content('bici estacionamiento')
        end
        
        fill_token_input_field('Palabras Clave', :with => 'punto de reunion ciclista')
        
        simula_click_gmaps(19.42007620847585, -99.35376930236814)
        sleep(3)
        find(:css, "#mapa-editable p").text.should_not be_blank

        click_on('Guardar')
      
        page.should have_content('El lugar ha sido modificado correctamente')
        current_path.should == lugar_path(Lugar.last)
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
        click_link 'Modificar'
        fill_in('Nombre', :with => '')
      
        click_on('Guardar')
      
        page.should have_content('Wikicleta no pudo guardar los cambios para este lugar debido a:')
        page.should have_content('Nombre no puede estar en blanco')
      end
    
      scenario "pero no podré guardarlo si no hay detalles" do
        click_link 'Modificar'
        fill_in('Detalles', :with => '')
      
        click_on('Guardar')
      
        page.should have_content('Wikicleta no pudo guardar los cambios para este lugar debido a:')
        page.should have_content('Detalles no puede estar en blanco')
      end
    
      scenario "pero no podré guardarlo si no hay palabras clave" do
        click_link 'Modificar'
        
        fill_token_input_field('Palabras Clave', :erase_prev => true)
        fill_token_input_field('Palabras Clave', :erase_prev => true)
        
        click_on('Guardar')
      
        page.should have_content('Wikicleta no pudo guardar los cambios para este lugar debido a:')
        page.should have_content('Palabras Clave debe incluir al menos una')
      end
    
    end
  end

end