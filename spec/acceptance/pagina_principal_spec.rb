# encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Página Principal", %q{
  En la página principal
} do

  background do
    visit root_path
  end

  scenario "Al visitar la página principal debo ver" do
    page.should have_content('Wikicleta')
    #page.should have_content('Ciudad de México')
    page.should have_link('Iniciar Sesión')
    page.should have_content('Lugares')
  end
end