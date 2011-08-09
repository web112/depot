class ProductsController < ApplicationController

  before_filter :clerk_authorize,  :only => [:show, :edit, :update, :destroy]
  before_filter :ensure_your_product,  :only => [:show, :edit, :update, :destroy]

  @@per_page_item = 10
  # GET /products
  # GET /products.xml
  def index

    @products = current_user.shop.products.paginate :page => params[:page], :order=>'created_at desc',
    :per_page => @@per_page_item

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @per_page = 6
    @comments = @product.comments.paginate :page=>params[:page], :order=>'created_at desc', :per_page=>@per_page
    @num_of_comments_before = (params[:page]?params[:page].to_i-1:0)*@per_page
    @index_in_this_page = 1
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @shop = current_user.shop
    @product = Product.new
    @product_types= BookType.all
    @types = @product.book_types
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @types = @product.book_types
    @product_types= BookType.all
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    @product_types= BookType.all
    
    types = params[:type_name]
    if types != nil
      types.each do |type|
        type = BookType.find_by_name(type)
        if type
          @product.book_types << type
        end
      end
    end
    

    @product.shop = current_user.shop
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    @product.book_types = []
    @product_types= BookType.all
    types = params[:type_name]
   
    if types != nil
      types.each do |type|
          type = BookType.find_by_name(type)
          if type
          @product.book_types << type
          end
      end
    end
    
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    respone_to do |format|
      format.atom
      format.xml{ render :xml => @product }
    end
  end

  def show_to_buyers
    @cart = current_cart
    @product = Product.find(params[:id])
    @per_page = 6
    @comments = @product.comments.paginate :page=>params[:page], :order=>'created_at desc', :per_page=>@per_page
    @num_of_comments_before = (params[:page]?params[:page].to_i-1:0)*@per_page
    @index_in_this_page = 1

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end
    
  def add_comment
    @product = Product.find(params[:id])
    @product.comments << Comment.create(:content=>params[:content])
    respond_to do |format|
      format.html {redirect_to :action=>:show_to_buyers, :id=>params[:id]}
      #format.js {@comments = @product.comments}
    end
  end
  
  def destroy_comment 
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(product_url @product) }
      format.xml  { head :ok }
    end
  end

  def rate_to_product
    @product = Product.find(params[:id])
    rate = params[:rate]

    file = File.new('a.txt','w')
    file.puts rate
    file.close

    @product.rating_sum += rate.to_f
    @product.rating_times += 1

    if @product.save

    end

    respond_to do |format|
      flash[:notice] = 'Rating successfully'
      format.html { redirect_to(:action=>:show_to_buyers, :id=>@product.id ) }
      format.js
      format.xml  { render :xml => @product }
    end

  end

  private

  def ensure_your_product
    product = Product.find(params[:id])
    if product.shop.id != current_user.shop.id
      redirect_to current_user.shop, :notice => "Not your product!"
    end
  end

end
