require 'test_helper'

class RemoteUsernamesControllerTest < ActionController::TestCase
  setup do
    @remote_username = remote_usernames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remote_usernames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remote_username" do
    assert_difference('RemoteUsername.count') do
      post :create, remote_username: { game_id: @remote_username.game_id, user_id: @remote_username.user_id, user_name: @remote_username.user_name }
    end

    assert_redirected_to remote_username_path(assigns(:remote_username))
  end

  test "should show remote_username" do
    get :show, id: @remote_username
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @remote_username
    assert_response :success
  end

  test "should update remote_username" do
    patch :update, id: @remote_username, remote_username: { game_id: @remote_username.game_id, user_id: @remote_username.user_id, user_name: @remote_username.user_name }
    assert_redirected_to remote_username_path(assigns(:remote_username))
  end

  test "should destroy remote_username" do
    assert_difference('RemoteUsername.count', -1) do
      delete :destroy, id: @remote_username
    end

    assert_redirected_to remote_usernames_path
  end
end
