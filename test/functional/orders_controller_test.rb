require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
	
=begin
	@order_of_shop_one = orders(:order_of_shop_one)
	@shop_one = shops(:one)
	@host = User.find(session[:user_id])
	@order_of_shop_one.shop = @shop_one
	@host.shop = @shop_one
	@order_of_shop_one.save
	@host.save
=end
    @order = orders(:one)
  end

  test "should get index" do
    login_as(:host_of_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    
    cart = Cart.create
    session[:cart_id] = cart.id
    LineItem.create(:cart => cart, :product => products(:ruby))
    
    get :new
    assert_response :success
  end

  test "should create order" do
	
	cart = Cart.create
    session[:cart_id] = cart.id
    LineItem.create(:cart => cart, :product => products(:ruby))
	
    assert_difference('Order.count') do
      post :create, :order => @order.attributes
    end

    assert_redirected_to store_url
  end

  test "should show order" do
    login_as(:host_of_one)
    
	order = orders(:order_of_shop_one)
    get :show, :id => order.to_param
    assert_response :success
  end

  test "should get edit" do
    login_as(:host_of_one)
  
	order = orders(:order_of_shop_one)
	
    get :edit, :id => order.to_param
    assert_response :success
  end

  test "should update order" do
    login_as(:host_of_one)
	order = orders(:order_of_shop_one)
	
    put :update, :id => order.to_param, :order => order.attributes
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    login_as(:host_of_one)
  
	order = orders(:order_of_shop_one)
	
    assert_difference('Order.count', -1) do
      delete :destroy, :id => order.to_param
    end

    assert_redirected_to orders_path
  end
  
  test "requires item in cart" do
    get :new
    assert_redirected_to store_path
    assert_equal flash[:notice], 'Your cart is empty'
  end
  
end
