class TagsController < ActionController::Base
  protect_from_forgery
  
  def index
    @tags =  Tag.where("contenido ILIKE ?", "%#{params[:q]}%") if params.has_key?(:q)
    
    respond_to do |format|
      format.json { render :json => @tags.map(&:expone_atributos) }
    end
  end
end