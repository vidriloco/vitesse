class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout

  private

  def layout
    # only turn it off for login pages:
    if is_a?(Devise::SessionsController) || 
      is_a?(Devise::RegistrationsController) || 
      is_a?(Devise::PasswordsController) 
      "devise"
    end
  end
  
end
