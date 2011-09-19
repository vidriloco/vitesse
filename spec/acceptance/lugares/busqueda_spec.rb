# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 
include Warden::Test::Helpers 

feature "Búsqueda de lugares: " do

  describe "habiendo ningún lugar registrado" do
    scenario "no puedo ver el botón de búsqueda" do
      visit lugares_path
      page.should_not have_content('Búsqueda')
    end
  end
  
  describe "habiendo varios lugares registrados" do
  
    background do
      Factory(:cebolla_morada)
      Factory(:taller_tuercas, :coordenadas => Point.from_lon_lat(-99.144831, 19.407242, 4326))
      
      visit lugares_path
      click_link('Búsqueda')
    end

    scenario "puedo ver los campos de búsqueda y puedo regresar al listado de lugares" do
      
      current_path.should == busqueda_lugares_path

      page.should have_content('Búsqueda de lugares')
      
      page.should have_content('Con nombre:')
      find_field('busqueda[nombre]')

      page.should have_content('Con palabras clave:')
      find_field('busqueda[tags]')

      page.should have_content('Sólo lugares que tengan todas las palabras clave anteriores')
      find_field('busqueda[tags_inclusivo]')

      page.should have_content('Localizar todos los lugares que esten dentro del área visible del mapa')
      page.should have_content('Ajustar mapa a mí posición actual:')    

      find_link('Ajustar')

      #page.should have_content('Desplegar primero a:')
      #find_field('busqueda[orden]')
      
      find_button('Buscar')
      
      click_link('Atrás')
      current_path.should == lugares_path
    end
    
    scenario "puedo buscar un lugar por su nombre y puedo volver al listado de lugares" do
      fill_in('busqueda[nombre]', :with => 'La Cebolla')
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (1 resultado)')
      
      page.should have_content('La Cebolla Morada')
      find_link('Nueva búsqueda')
      click_link('Atrás')
      current_path.should == lugares_path
    end
        
    scenario "al ver los resultados de búsqueda de un lugar puedo optar por realizar una nueva búsqueda" do
      fill_in('busqueda[nombre]', :with => 'La Opelina')
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (0 resultados)')
      
      page.should have_content('No se encontraron lugares que satisfagan los parámetros de búsqueda dados')
      
      find_link('Atrás')
      click_link('Nueva búsqueda')
      current_path.should == busqueda_lugares_path
    end
    
    scenario "puedo buscar un lugar por palabras clave OPCIONALES para cada lugar", :js => true do
      fill_token_input_field('busqueda_tags', :with => 'restaurante')
      fill_token_input_field('busqueda_tags', :with => 'taller')
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (2 resultados)')
      
      page.should have_content('La Cebolla Morada')
      page.should have_content('Los tuercas')
    end
    
    scenario "puedo buscar un lugar por palabras clave REQUERIDAS para cada lugar", :js => true do
      fill_token_input_field('busqueda_tags', :with => 'restaurante')
      fill_token_input_field('busqueda_tags', :with => 'taller')
      
      check('busqueda[tags_inclusivo]')
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (0 resultados)')
      
      page.should have_content('No se encontraron lugares que satisfagan los parámetros de búsqueda dados')
    end
    
    scenario "puedo buscar un lugar por nombre y palabras clave OPCIONALES para cada lugar", :js => true do
      fill_in('busqueda[nombre]', :with => 'La Cebolla')
      fill_token_input_field('busqueda_tags', :with => 'restaurante')
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (1 resultado)')
      
      page.should have_content('La Cebolla Morada')
    end
    
  end
  
  describe "habiendo varios sitios registrados a modo de cluster (en una zona única) y otros separados", :js => true do
    
    before(:each) do
      p=Factory(:taller_tuercas, 
              :coordenadas => Point.from_lon_lat(-99.12000792, 19.33933915, 4326))
      Factory(:taller_tuercas, 
              :coordenadas => Point.from_lon_lat(-99.124864, 19.348549, 4326),
              :tags => p.tags)
      Factory(:taller_tuercas, 
              :coordenadas => Point.from_lon_lat(-99.144831, 19.407242, 4326),
              :tags => p.tags)
      
      visit busqueda_lugares_path
    end
    
    it "puedo buscar un lugar por nombre y palabras clave OPCIONALES en el area del clúster y deben aparecer algunos" do
      fill_in('busqueda[nombre]', :with => 'Los tuercas')
      fill_token_input_field('busqueda_tags', :with => 'taller')
      
      simula_click_gmaps(19.343285, -99.125004)
      
      page.execute_script("geo.posiciona(mapa, {zoom : 15});")
      
      click_on('Buscar')
      current_path.should == busqueda_resultados_lugares_path
      page.should have_content('Resultados de la búsqueda (2 resultados)')
    end
    
  end
  
end