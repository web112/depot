require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_attributes = {
      :name => "sam",
      :password => "private",
      :password_confirmation => "private"
    }
    
    @user = users(:one)
  end

  test "should get index" do
    login_as(:host_of_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    login_as(:host_of_one)
    get :new
    assert_response :success
  end

  test "should create clerk" do
    login_as(:host_of_one)
    assert_difference('User.count') do
      post :create, :user => @input_attributes
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    login_as(:host_of_one)
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    login_as(:host_of_one)
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    login_as(:host_of_one)
    put :update, :id => @user.to_param, :user => @input_attributes
    assert_redirected_to users_path
  end

  test "should destroy user" do 
    login_as(:host_of_one)
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
