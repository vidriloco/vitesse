require "spec_helper"

describe PrincipalController do
  describe "rutas" do
    it "hace match de / con accion #index en controller :principal" do
      { :get => "/" }.should route_to(:controller => "principal", :action => "index")
    end
  end
end