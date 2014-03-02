require 'spec_helper'

describe "servers/index" do
  before(:each) do
    assign(:servers, [
      stub_model(Server),
      stub_model(Server)
    ])
  end

  it "renders a list of servers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
