require 'spec_helper'

describe "pms/edit" do
  before(:each) do
    @pm = assign(:pm, stub_model(Pm,
      :author => nil,
      :recipient => nil,
      :message => "MyText"
    ))
  end

  it "renders the edit pm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pm_path(@pm), "post" do
      assert_select "input#pm_author[name=?]", "pm[author]"
      assert_select "input#pm_recipient[name=?]", "pm[recipient]"
      assert_select "textarea#pm_message[name=?]", "pm[message]"
    end
  end
end
