require 'spec_helper'

describe "pms/index" do
  before(:each) do
    assign(:pms, [
      stub_model(Pm,
        :author => nil,
        :recipient => nil,
        :message => "MyText"
      ),
      stub_model(Pm,
        :author => nil,
        :recipient => nil,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of pms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
