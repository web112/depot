class TestsController < ApplicationController
  # GET /products
  # GET /products.xml
  def hi
	id = params[:id];
	logger.warn("hi logger")
	#redirect_to(:id => 3, :action => 'show', :controller => 'products', :notice => 'Product was successfully created.')

  end
end
