require "spec_helper"

describe ServersController do
  describe "routing" do

    it "routes to #index" do
      get("/servers").should route_to("servers#index")
    end

    it "routes to #new" do
      get("/servers/new").should route_to("servers#new")
    end

    it "routes to #show" do
      get("/servers/1").should route_to("servers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/servers/1/edit").should route_to("servers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/servers").should route_to("servers#create")
    end

    it "routes to #update" do
      put("/servers/1").should route_to("servers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/servers/1").should route_to("servers#destroy", :id => "1")
    end

  end
end
