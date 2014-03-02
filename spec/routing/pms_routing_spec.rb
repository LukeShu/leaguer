require "spec_helper"

describe PmsController do
  describe "routing" do

    it "routes to #index" do
      get("/pms").should route_to("pms#index")
    end

    it "routes to #new" do
      get("/pms/new").should route_to("pms#new")
    end

    it "routes to #show" do
      get("/pms/1").should route_to("pms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pms/1/edit").should route_to("pms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pms").should route_to("pms#create")
    end

    it "routes to #update" do
      put("/pms/1").should route_to("pms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pms/1").should route_to("pms#destroy", :id => "1")
    end

  end
end
