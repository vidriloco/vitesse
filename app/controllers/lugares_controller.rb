class LugaresController < ActionController::Base
  protect_from_forgery
  
  def new
  
  end
  
  def index
    @lugares = Lugar.paginate(:page => params[:page], :order => "created_at DESC")
  end
end