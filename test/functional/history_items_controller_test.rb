require 'test_helper'

class HistoryItemsControllerTest < ActionController::TestCase
  setup do
    @history_item = history_items(:one)
  end

  test "should get index" do
    login_as(:buyer)
    
    get :index
    assert_response :success
    assert_not_nil assigns(:history_items)
  end




  test "should destroy history_item" do
    login_as(:buyer)
    
    assert_difference('HistoryItem.count', -1) do
      delete :destroy, :id => @history_item.to_param
    end

    assert_redirected_to history_items_path
  end
end
