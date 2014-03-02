require 'spec_helper'

describe "tournaments/edit" do
  before(:each) do
    @tournament = assign(:tournament, stub_model(Tournament,
      :game => nil
    ))
  end

  it "renders the edit tournament form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tournament_path(@tournament), "post" do
      assert_select "input#tournament_game[name=?]", "tournament[game]"
    end
  end
end
