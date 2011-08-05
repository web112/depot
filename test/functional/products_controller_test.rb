require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:ruby)
    @update = 
    {
      :title => 'Lorem Ipsum',
      :description => 'Wibbles are fun!',
      :image_url => 'lorem.jpg',
      :price => 19.95
    }
  end

  test "should get index" do
    login_as(:host_of_one)
	
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    login_as(:host_of_one)
	
    get :new
    assert_response :success
  end

  test "should create product" do
    login_as(:host_of_one)
	
    assert_difference('Product.count') do
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    login_as(:host_of_one)
	
    get :show, :id => @product.to_param
    assert_response :success
  end

  test "should get edit" do
    
    login_as(:host_of_one)
    get :edit, :id => @product.to_param
    assert_response :success
  end

  test "should update product" do
    
    login_as(:host_of_one)
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    
    login_as(:host_of_one)
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product.to_param
    end

    assert_redirected_to products_path
  end
  

end
