require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  setup do
    
    @news = news(:one)
  end

  test "should get index" do
    login_as(:administrator)
    get :index
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "should get new" do
    login_as(:administrator)
    get :new
    assert_response :success
  end

  test "should create news" do
    login_as(:administrator)
    assert_difference('News.count') do
      post :create, :news => @news.attributes
    end

    assert_redirected_to news_path(assigns(:news))
  end

  test "should show news" do
    login_as(:administrator)
    get :show, :id => @news.to_param
    assert_response :success
  end

  test "should get edit" do
    login_as(:administrator)
    get :edit, :id => @news.to_param
    assert_response :success
  end

  test "should update news" do
    login_as(:administrator)
    put :update, :id => @news.to_param, :news => @news.attributes
    assert_redirected_to news_path(assigns(:news))
  end

  test "should destroy news" do
    login_as(:administrator)
    assert_difference('News.count', -1) do
      delete :destroy, :id => @news.to_param
    end

    assert_redirected_to news_index_path
  end
end
