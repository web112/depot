require 'test_helper'



class ShopsControllerTest < ActionController::TestCase
  setup do
    @shop = shops(:one)
    @host = {:name => "hostname", :password => "password", :confirmation => "password"}
  end

  test "should get index" do

    login_as(:administrator)
    get :index
    assert_response :success
    assert_not_nil assigns(:shops)
  end

  test "should get new" do

    get :new
    assert_response :success
  end

  test "should create shop" do
    
    file = File.new('c.txt','w')
    file.puts @shop.attributes
    file.close
    
    assert_difference('Shop.count') do    
     post :create, :shop => @shop.attributes, :name => "hostname", :password => "password", :confirmation => "password"
    end
    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should show shop" do
    login_as(:host_of_one)

    get :show, :id => @shop.to_param
    assert_response :success
  end

  test "should get edit" do
    login_as(:host_of_one)

    get :edit, :id => @shop.to_param
    assert_response :success
  end

  test "should update shop" do
    login_as(:host_of_one)

    put :update, :id => @shop.to_param, :shop => @shop.attributes
    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should not destroy shop with orders" do
    login_as(:host_of_one)

    assert_difference('Shop.count', 0) do
      delete :destroy, :id => @shop.to_param
    end

    assert_redirected_to shops_path
  end
end
