require 'spec_helper'

describe "alerts/edit" do
  before(:each) do
    @alert = assign(:alert, stub_model(Alert,
      :author => nil,
      :message => "MyText"
    ))
  end

  it "renders the edit alert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", alert_path(@alert), "post" do
      assert_select "input#alert_author[name=?]", "alert[author]"
      assert_select "textarea#alert_message[name=?]", "alert[message]"
    end
  end
end
