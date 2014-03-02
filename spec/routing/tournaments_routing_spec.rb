require "spec_helper"

describe TournamentsController do
  describe "routing" do

    it "routes to #index" do
      get("/tournaments").should route_to("tournaments#index")
    end

    it "routes to #new" do
      get("/tournaments/new").should route_to("tournaments#new")
    end

    it "routes to #show" do
      get("/tournaments/1").should route_to("tournaments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tournaments/1/edit").should route_to("tournaments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tournaments").should route_to("tournaments#create")
    end

    it "routes to #update" do
      put("/tournaments/1").should route_to("tournaments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tournaments/1").should route_to("tournaments#destroy", :id => "1")
    end

  end
end
