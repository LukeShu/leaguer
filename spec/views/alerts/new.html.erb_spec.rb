require 'spec_helper'

describe "alerts/new" do
  before(:each) do
    assign(:alert, stub_model(Alert,
      :author => nil,
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new alert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", alerts_path, "post" do
      assert_select "input#alert_author[name=?]", "alert[author]"
      assert_select "textarea#alert_message[name=?]", "alert[message]"
    end
  end
end
