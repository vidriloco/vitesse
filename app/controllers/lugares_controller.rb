# encoding: utf-8
class LugaresController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_usuario!, :except => [:index, :show, :busqueda, :busqueda_resultados]
    
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
        Uslu.puede_alterar_a(current_usuario.id, @lugar.id)
        format.html { redirect_to(@lugar, :notice => 'El lugar ha sido añadido correctamente') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @lugar = Lugar.find(params[:id])
    @lugar.destroy
    redirect_to(lugares_path)
  end
  
  def confirm_destroy
    @lugar=Uslu.alterable(:lugar => params[:id], :usuario => current_usuario.id)
    redirect_to(lugar_path(params[:id]), :alert => ('No tienes permisos suficientes para eliminar este lugar')) if @lugar.nil?
  end
  
  def edit
    @lugar = Lugar.find(params[:id], :include => :tags)
  end
  
  def update
    @lugar = Lugar.find(params[:id])
    @lugar.aplica_geo(params[:coordenadas])
    
    respond_to do |format|
      if @lugar.update_attributes(params[:lugar])
        format.html { redirect_to(lugar_url(@lugar), :notice => 'El lugar ha sido modificado correctamente') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def busqueda
  end
  
  def busqueda_resultados
    @lugares = Lugar.busca(params[:busqueda], params[:page])
  end
end