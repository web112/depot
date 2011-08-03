class StoreController < ApplicationController
  
  @@per_page_item = 5
  
  def index
    #@products = Product.all.paginate :page => params[:page], :order=>'created_at desc',
    #                        :per_page => @@per_page_item 
    #@cart = current_cart
    
    @hot_products = Product.all.sort{|p1, p2| p2.sales <=> p1.sales }[0,4]
    @recommend_products = Product.all.sort{|p1, p2| p2.rating_sum/(p2.rating_times+0.001) <=> p1.rating_sum/(p1.rating_times+0.001) } [0,4]
    @cart = current_cart
  end
  
  def show_products
    products = Product.all
    if params[:order] == "recommend"
      products.sort!{|p1, p2| p2.rating_sum/(p2.rating_times+0.001) <=> p1.rating_sum/(p1.rating_times+0.001) }
    elsif params[:order] == "hottest" 
      products.sort!{|p1, p2| p2.sales<=> p1.sales }
    end
    
    if params[:name] == "" || params[:name]== nil
      @products = products.paginate :page => params[:page], :order=>'created_at desc',
                             :per_page => @@per_page_item
      @products_all_num = products.size
    else
      @product = Product.new
      @products = @product.search(params[:name])
      @products_all_num = @products.size
      if @products.size != 0
        @products = @products.paginate :page => params[:page],:order=>'created_at desc',:per_page => @@per_page_item
      end
    end  
    @cart = current_cart
  end
  
  def ajax_show_products
    @product = Product.new
    @products = @product.search(params[:name])
    render :layout => false
  end
  

end
