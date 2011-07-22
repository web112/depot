class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
	@cart = current_cart
	@products = Product.all
  end
end
