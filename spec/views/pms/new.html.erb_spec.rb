require 'spec_helper'

describe "pms/new" do
  before(:each) do
    assign(:pm, stub_model(Pm,
      :author => nil,
      :recipient => nil,
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new pm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pms_path, "post" do
      assert_select "input#pm_author[name=?]", "pm[author]"
      assert_select "input#pm_recipient[name=?]", "pm[recipient]"
      assert_select "textarea#pm_message[name=?]", "pm[message]"
    end
  end
end
