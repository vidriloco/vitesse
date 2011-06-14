module AcceptanceHelpers
  def fill_token_input_field(dummy, opts) 
    page.execute_script " $('.token-input-list-facebook').trigger(\"mouseenter\").click();"
    
    if opts.has_key?(:erase_prev) && opts[:erase_prev]
      page.execute_script "$('ul.token-input-list-facebook li.token-input-input-token-facebook :text').autotype('{{back}}{{back}}');"
      sleep 2
    end
    
    if opts.has_key?(:with)
      page.execute_script "$('ul.token-input-list-facebook li.token-input-input-token-facebook :text').autotype('#{opts[:with]}');"
      sleep 3
    end
    page.execute_script "$('ul.token-input-list-facebook li.token-input-input-token-facebook :text').autotype('{{enter}}');"
  end
  
  def simula_click_gmaps(lat, lon)
    page.execute_script("geo.simulaSeleccionEnMapa(#{lat},#{lon}, '#mapa-editable p');")
  end
  
  def find_not_link(locator)
    !find(:xpath, XPath::HTML.link(locator))
  end
end