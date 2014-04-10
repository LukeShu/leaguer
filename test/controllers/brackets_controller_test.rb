require 'test_helper'

class BracketsControllerTest < ActionController::TestCase
  setup do
    @bracket = brackets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brackets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bracket" do
    assert_difference('Bracket.count') do
      post :create, bracket: { name: @bracket.name, tournament_id: @bracket.tournament_id, user_id: @bracket.user_id }
    end

    assert_redirected_to bracket_path(assigns(:bracket))
  end

  test "should show bracket" do
    get :show, id: @bracket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bracket
    assert_response :success
  end

  test "should update bracket" do
    patch :update, id: @bracket, bracket: { name: @bracket.name, tournament_id: @bracket.tournament_id, user_id: @bracket.user_id }
    assert_redirected_to bracket_path(assigns(:bracket))
  end

  test "should destroy bracket" do
    assert_difference('Bracket.count', -1) do
      delete :destroy, id: @bracket
    end

    assert_redirected_to brackets_path
  end
end
