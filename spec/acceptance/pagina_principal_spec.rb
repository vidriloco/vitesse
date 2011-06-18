# encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Página Principal: " do

  background do
    Factory(:usuario)
    visit root_path
  end

  scenario "Al visitar la página principal debo ver" do
    find_link('Iniciar sesión')
    page.should have_content('Lugares')
  end
  
  scenario "Desde la página principal puedo iniciar sesión" do
    click_link('Iniciar sesión')
    current_path.should == new_usuario_session_path
    fill_in('Email', :with => 'cleta@gmail.com')
    fill_in('Contraseña', :with => 'prueba')
    click_on('Iniciar')
    current_path.should == root_path
    click_link('Cerrar sesión')
    current_path.should == root_path
    find_link('Iniciar sesión')
  end
end