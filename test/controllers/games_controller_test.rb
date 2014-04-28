require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { max_players_per_team: @game.max_players_per_team, max_teams_per_match: @game.max_teams_per_match, min_players_per_team: @game.min_players_per_team, min_teams_per_match: @game.min_teams_per_match, name: @game.name, parent_id: @game.parent_id, scoring_method: @game.scoring_method }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { max_players_per_team: @game.max_players_per_team, max_teams_per_match: @game.max_teams_per_match, min_players_per_team: @game.min_players_per_team, min_teams_per_match: @game.min_teams_per_match, name: @game.name, parent_id: @game.parent_id, scoring_method: @game.scoring_method }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
