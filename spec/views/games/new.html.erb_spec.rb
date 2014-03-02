require 'spec_helper'

describe "games/new" do
  before(:each) do
    assign(:game, stub_model(Game,
      :name => "MyText",
      :players_per_team => 1,
      :teams_per_match => 1,
      :set_rounds => 1,
      :randomized_teams => 1
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", games_path, "post" do
      assert_select "textarea#game_name[name=?]", "game[name]"
      assert_select "input#game_players_per_team[name=?]", "game[players_per_team]"
      assert_select "input#game_teams_per_match[name=?]", "game[teams_per_match]"
      assert_select "input#game_set_rounds[name=?]", "game[set_rounds]"
      assert_select "input#game_randomized_teams[name=?]", "game[randomized_teams]"
    end
  end
end
