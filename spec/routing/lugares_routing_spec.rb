require "spec_helper"

describe LugaresController do
  describe "rutas" do
    it "hace match de /lugares/nuevo con accion #new en controller :lugares" do
      { :get => "/lugares/nuevo" }.should route_to(:controller => "lugares", :action => "new")
    end
    
    it "hace match con get sobre /lugares/index con accion #index en controller :lugares" do
      { :get => "/lugares" }.should route_to(:controller => "lugares", :action => "index")
    end
    
    it "hace match con get sobre /lugares/1 con accion #show en controller :lugares" do
      { :get => "/lugares/1" }.should route_to(:controller => "lugares", :action => "show", :id => "1")
    end
    
    it "hace match con post sobre /lugares con accion #create en controller :lugares" do
      { :post => "/lugares" }.should route_to(:controller => "lugares", :action => "create")
    end
    
    it "hace match con get sobre /lugares/eliminar/1 con accion #confirm_destroy en controller :lugares" do
      { :get => "/lugares/1/eliminar" }.should route_to(:controller => "lugares", :action => "confirm_destroy", :id => "1")
    end
    
    it "hace match con post sobre /lugares con accion #destroy en controller :lugares" do
      { :delete => "/lugares/1" }.should route_to(:controller => "lugares", :action => "destroy", :id => "1")
    end
  end
end