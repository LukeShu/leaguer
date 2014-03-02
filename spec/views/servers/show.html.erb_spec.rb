require 'spec_helper'

describe "servers/show" do
  before(:each) do
    @server = assign(:server, stub_model(Server))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
