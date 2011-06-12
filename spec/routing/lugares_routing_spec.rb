require "spec_helper"

describe LugaresController do
  describe "rutas" do
    it "hace match de /lugares/nuevo con accion #new en controller :lugares" do
      { :get => "/lugares/nuevo" }.should route_to(:controller => "lugares", :action => "new")
    end
    
    it "hace match de /lugares/index con accion #index en controller :lugares" do
      { :get => "/lugares" }.should route_to(:controller => "lugares", :action => "index")
    end
  end
end