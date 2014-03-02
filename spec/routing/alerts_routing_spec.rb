require "spec_helper"

describe AlertsController do
  describe "routing" do

    it "routes to #index" do
      get("/alerts").should route_to("alerts#index")
    end

    it "routes to #new" do
      get("/alerts/new").should route_to("alerts#new")
    end

    it "routes to #show" do
      get("/alerts/1").should route_to("alerts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/alerts/1/edit").should route_to("alerts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/alerts").should route_to("alerts#create")
    end

    it "routes to #update" do
      put("/alerts/1").should route_to("alerts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/alerts/1").should route_to("alerts#destroy", :id => "1")
    end

  end
end
