# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 

feature "Registro de lugares: " do

  background do
    visit root_path
  end
  
  describe "Estando en la pagina principal puedo acceder al formulario de registro de lugar", :js => true do
  
    scenario "y guardar un lugar si tengo todos los campos requeridos" do
      
      find_link('Lugares').click()
    
      find_link('Registrar nuevo').click()
      current_path.should == new_lugar_path
      
      page.should have_content('Nuevo lugar:')
    
      page.should have_content('Selecciona una ubicación haciendo click en el mapa')
      page.should have_content('Usar mí ubicación actual')
      find_link('Determinar')
    
      find_field('Nombre')
      fill_in('Nombre', :with => 'La Cebolla Morada')
      
      find_field('Detalles')
      fill_in('Detalles', :with => 'Restaurante de comida mexicana suculenta. Especializados en cochinita pibil')
      
      fill_in('Twitter', :with => '@LaCebollaMorada')
      
      fill_token_input_field('Palabras Clave', :with => 'restaurante')
      
      click_on('Publicar')
      current_path.should == lugar_path(Lugar.last)
    end
    
  end

end