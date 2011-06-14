# encoding: utf-8
class LugaresController < ActionController::Base
  protect_from_forgery

  def new
    @lugar = Lugar.new
  end
  
  def index
    @lugares = Lugar.paginate(:page => params[:page], :order => "created_at DESC")
  end
  
  def show
    @lugar = Lugar.find(params[:id], :include => :tags)
  end
  
  def create
    @lugar = Lugar.new(params[:lugar])
    @lugar.aplica_geo(params[:coordenadas])

    respond_to do |format|
      if @lugar.save
        format.html { redirect_to(@lugar, :notice => 'El lugar ha sido añadido correctamente') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end