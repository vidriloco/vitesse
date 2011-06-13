# encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Listado de lugares: " do

  background do
    visit root_path
  end
  
  describe "No habiendo lugares registrados" do
    
    before(:each) do
      find_link('Lugares').click()
      current_path.should == lugares_path
    end
    
    scenario "debo ver un mensaje adecuado que me lo notifique" do  
      page.should have_content('Por ahora no hay lugares registrados')
      click_link('Registra uno nuevo')
      current_path.should == new_lugar_path
    end
  end
  
  describe "Habiendo registrados" do

    before(:each) do
      time_travel_to(5.months.ago) do
        Factory.create(:lugar)
        Factory.create(:lugar, :nombre => "Pa Thai")
      end
      
      time_travel_to(3.months.ago) do
        Factory.create(:lugar, :nombre => "Lilly")
      end
      
      time_travel_to(2.months.ago) do
        Factory.create(:lugar, :nombre => "Casa del Tío Toño")
        Factory.create(:lugar, :nombre => "La Cebolla Morada")
        Factory.create(:lugar, :nombre => "Mi gusto es")
        Factory.create(:lugar, :nombre => "Goldtaco")
      end
      
      Factory.create(:lugar, :nombre => "Bisquets, Bisquets de Obregón")
      Factory.create(:lugar, :nombre => "El sope loco")
      
      visit(lugares_path)
    end
      
    after(:each) { back_to_the_present }
      

    scenario "debo ver un grupo que contiene a los 7 más recientes con paginacion de 5 bloques" do 
        
      page.should have_content('Listando lugares')
        
      find_link('Más recientes')
      page.should_not have_content('Daikoku Condesa')
      page.should_not have_content('Pa Thai')
      
      page.should_not have_content('Lilly')
      page.should_not have_content('Casa del Tío Toño')
      page.should have_content('La Cebolla Morada')
      page.should have_content('Bisquets, Bisquets de Obregón')
      page.should have_content('El sope loco')
      page.find('a', :text => 'detalles', :count => 5)
      page.find('a', :text => 'ver en mapa', :count => 5)
      find_link('Siguiente').click()
      page.should have_content('Lilly')
      page.should have_content('Casa del Tío Toño')
    end
      
    scenario "los veo en un grupo que contiene a los más populares"
    
  end
end