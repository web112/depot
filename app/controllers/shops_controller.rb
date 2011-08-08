class ShopsController < ApplicationController

  before_filter :administrator_authorize, :only => [:index, :change_state]
  before_filter :host_authorize
  skip_before_filter :host_authorize, :only => [:show_to_buyers, :create, :new, :index,  :change_state]
  before_filter :ensure_your_shop,  :only => [:show, :edit, :update, :destroy]
  before_filter :ensure_open, :only => [:show, :show_to_buyers]

  @@per_page_item = 3
  # GET /shops
  # GET /shops.xml
  def index
    @shops = Shop.all.paginate :page => params[:page], :order=>'created_at desc',
    :per_page => @@per_page_item

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shops }
    end
  end

  # GET /shops/1
  # GET /shops/1.xml
  def show
    @shop = Shop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shop }
    end
  end

  # GET /shops/new
  # GET /shops/new.xml
  def new
    @user = User.new
    @shop = Shop.new

    file = File.new("a.txt", "w")
    file.puts "new shop"
    file.close

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shop }
    end
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops
  # POST /shops.xml
  def create
    
    file = File.new("b.txt", "w")

    @shop = Shop.new(params[:shop])
    
    file.puts params[:shop]
    
    file.puts @shop.attributes

    username = params[:name]
    password = params[:password]
    confirm = params[:confirmation]

    respond_to do |format|
      if  password != confirm

        flash[:notice] = "confirmation failure"
        format.html { redirect_to(:action => "new") }
      else

        @user = User.new
        @user.name = username
        @user.password = password
        @user.role = 'host'
        
        @shop.users << @user
        
        file.puts "create shop"

        if @shop.save         
          
           file.puts "save shop"       
          
          format.html { redirect_to(@shop, :notice=> 'Shop was successfully created.') }
          format.xml  { render :xml => @shop, :status => :created, :location => @shop }
        else
          @shop.errors.each do |error|
            file.puts error
          end
          format.html { render :action => "new" }
          format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
        end
      end
      
      file.close
      
    end
  end

  # PUT /shops/1
  # PUT /shops/1.xml
  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to(@shop, :notice => 'Shop was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.xml
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to(shops_url) }
      format.xml  { head :ok }
    end
  end

  def show_to_buyers
    @cart = current_cart
    @shop = Shop.find(params[:id])

    @products = @shop.products.paginate :page => params[:page], :order=>'created_at desc',
    :per_page => @@per_page_item

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shop }
    end
  end
  
  def change_state
    @shop = Shop.find(params[:id])
    if @shop.state == "open"
      @shop.state = "close"
    else
      @shop.state = "open"
    end
      
    @shop.save!
    respond_to do |format|
      format.html { redirect_to(shops_url, :page => params[:page]) }
      format.xml  { head :ok }
    end
    
  end

  private
  def ensure_your_shop
    shop = Shop.find(params[:id])
    if shop.id != current_user.shop.id
      redirect_to current_user.shop, :notice => "Not your shop!"
    end
  end
  
  def ensure_open
    shop = Shop.find(params[:id])
    if shop.state != "open"
      redirect_to store_url, :notice => "The shop is close!"
    end
  end
  
end
