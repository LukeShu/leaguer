require 'spec_helper'

describe "alerts/show" do
  before(:each) do
    @alert = assign(:alert, stub_model(Alert,
      :author => nil,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
