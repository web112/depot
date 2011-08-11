class StoreController < ApplicationController

  @@per_page_item = 5
  def index
    #@products = Product.all.paginate :page => params[:page], :order=>'created_at desc',
    #                        :per_page => @@per_page_item
    #@cart = current_cart

    @hot_products = Product.all.sort{|p1, p2| p2.sales <=> p1.sales }[0,12]
    @recommend_products = Product.all.sort{|p1, p2| p2.rating_sum/(p2.rating_times+0.001) <=> p1.rating_sum/(p1.rating_times+0.001) } [0,12]
    @cart = current_cart
  end

  def show_products

    @cart = current_cart
    @products = Product.all

    #搜索
    if params[:name] == "" || params[:name] == nil
    @products_all_num = @products.size
    else
      @product = Product.new
      @products = @product.search(params[:name])
    end

    #筛选类型
    if params[:type] != nil && params[:type] != ""
      @products = @products.select{ |product| !product.book_types.where(:name => params[:type]).empty?}
    end

    #排序
    if params[:order] == "recommend"
      @products.sort!{|p1, p2| p2.rating_sum/(p2.rating_times+0.001) <=> p1.rating_sum/(p1.rating_times+0.001) }
    elsif params[:order] == "hottest"
      @products.sort!{|p1, p2| p2.sales <=> p1.sales }
    end

    #分页
    if @products.size != 0
      @products = @products.paginate :page => params[:page], :per_page => @@per_page_item
    end

    @products_all_num = @products.size

  end

  def ajax_show_products
    @product = Product.new
    @products = @product.search(params[:name])
    render :layout => false
  end

end
