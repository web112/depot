require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:one)
  end

  test "should not get index" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_redirected_to login_url
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, :cart => @cart.attributes
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should not show cart" do
    get :show, :id => @cart.to_param
    assert_redirected_to login_url
  end

  test "should not get edit" do
    get :edit, :id => @cart.to_param
    assert_redirected_to login_url
  end

  test "should not update cart" do
    put :update, :id => @cart.to_param, :cart => @cart.attributes
    assert_redirected_to login_url
  end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
      delete :destroy, :id => @cart.to_param
    end

    assert_redirected_to store_path
  end
end
