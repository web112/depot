require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to login_url
  end

  test "should not get new" do
    get :new

    assert_redirected_to login_url
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, :product_id => products(:ruby).id
    end

    assert_redirected_to carts_url
  end

  test "should not show line_item" do
    get :show, :id => @line_item.to_param
    assert_redirected_to login_url
  end

  test "should get edit" do
    get :edit, :id => @line_item.to_param
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item.to_param, :line_item => @line_item.attributes
    assert_redirected_to login_url
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @line_item.to_param
    end

    assert_redirected_to carts_path
  end
end
