# encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Página Principal: " do

  background do
    visit root_path
  end

  scenario "Al visitar la página principal debo ver" do
    find_link('Iniciar sesión')
    page.should have_content('Lugares')
  end
end