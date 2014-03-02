require 'spec_helper'

describe "pms/show" do
  before(:each) do
    @pm = assign(:pm, stub_model(Pm,
      :author => nil,
      :recipient => nil,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
