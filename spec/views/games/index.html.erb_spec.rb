require 'spec_helper'

describe "games/index" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :name => "MyText",
        :players_per_team => 1,
        :teams_per_match => 2,
        :set_rounds => 3,
        :randomized_teams => 4
      ),
      stub_model(Game,
        :name => "MyText",
        :players_per_team => 1,
        :teams_per_match => 2,
        :set_rounds => 3,
        :randomized_teams => 4
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
