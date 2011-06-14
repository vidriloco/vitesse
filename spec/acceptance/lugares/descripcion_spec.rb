# encoding: utf-8
require 'acceptance/acceptance_helper'
require 'acceptance/helpers'
include AcceptanceHelpers 

feature "Detalles de lugares: " do

  background do
    visit root_path
  end
  
  describe "Habiendo un lugar registrado" do
    
    before(:each) do
      @lugar=Factory.build(:lugar, 
                            :telefono_uno => "50000000", 
                            :telefono_dos => "60000000", 
                            :correo => "atencion@cebollamorada.com",
                            :sitio_web => "www.lacebollamorada.com")
    end
    
    it "puedo ver su descripción completa y ver su ubicación en el mapa", :js => true do
      @lugar.save
      visit lugar_path(@lugar)
      
      page.should have_content('Daikoku Condesa')
      page.should have_content('restaurante')
      page.should have_content('bici estacionamiento')
      
      page.should have_content('Rica comida japonesa tradicional')
      page.should have_content('Ubicación:')
      find_link('Ver en el mapa')
      find(:css, ".direccion").text.should_not be_blank
      
      within(:css, ".redes-sociales") do
        find(:css, ".twitter")
        page.should have_content("@daikokuCondesa")
        find(:css, ".facebook")
        page.should have_content("daikoku")
      end 
      page.should have_content('Datos de Contacto')
      
      page.should have_content('Sitio web:')
      page.should have_content('www.lacebollamorada.com')
      page.should have_content('Teléfono(s):')
      page.should have_content("50000000")
      page.should have_content("60000000")
      page.should have_content('Correo:')
      page.should have_content('atencion@cebollamorada.com')
      
      page.should have_content('Fotos')
      find_link('Agregar foto')
      
      click_link('Volver')
      current_path.should == lugares_path
    end
    
    it "puedo ver su descripción parcial cuando no están los campos de las redes sociales" do
      @lugar.facebook = ""
      @lugar.twitter = ""
      @lugar.save
      visit lugar_path(@lugar)
      
      page.should have_no_css('.redes-sociales')
    end
    
    it "puedo ver su descripción parcial cuando está algún campo de las redes sociales" do
      @lugar.facebook = ""
      @lugar.twitter = "@daikokuCondesa"
      @lugar.save
      visit lugar_path(@lugar)
      
      within(:css, ".redes-sociales") do
        find(:css, ".twitter")
        page.should have_content("@daikokuCondesa")
        page.should have_no_css('.facebook')
      end
    end
    
    it "puedo ver su descripción parcial cuando faltan campos de contacto" do
      @lugar.telefono_uno = ""
      @lugar.telefono_dos = ""
      @lugar.sitio_web = ""
      @lugar.correo = ""
      @lugar.save
      visit lugar_path(@lugar)
      
      page.should have_content('Sitio web:')
      page.should have_content('No está registrado aún')
      page.should have_content('Teléfono(s):')
      page.should have_content("Ninguno ha sido registrado")
      page.should have_content('Correo:')
      page.should have_content('No está registrado aún')
    end
    
    it "si yo lo registré puedo modificarlo"
  end

end