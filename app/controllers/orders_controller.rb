class OrdersController < ApplicationController

  before_filter :clerk_authorize, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :ensure_order_of_shop,  :only => [:show, :edit, :update, :destroy]

  @@per_page_item = 2
  
  # GET /orders
  # GET /orders.xml
  def index

    @orders = current_user.shop.orders.paginate :page => params[:page], :order=>'created_at desc',
    :per_page => @@per_page_item

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    if current_cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty"
    return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    shop_order_hash = {}

    
    #orders
    current_cart.line_items.each do
    |item|
      
      if current_user != nil
        history_item = HistoryItem.new
        history_item.shop_name = item.product.shop.name
        history_item.product_name = item.product.title
        history_item.product_id = item.product.id
        history_item.price = item.product.price
        history_item.shop_id = item.product.shop.id
        history_item.shop_email = item.product.shop.email
        history_item.shop_telephone = item.product.shop.telephone
        history_item.user_id = current_user.id
        history_item.save
      end
    
      item.product.sales += item.quantity
      item.product.save
    
      unless shop_order_hash.keys.include? item.product.shop
        order = Order.new(params[:order])
      order.shop = item.product.shop
      shop_order_hash[item.product.shop] = order
        
      end

      item.cart = nil;
      shop_order_hash[item.product.shop].line_items << item
    end

    success = true
    errors = nil
    shop_order_hash.values.each do
    |order|
      unless order.save
      success = false
      errors = order.errors
      @order = order
      break
      end
    end

    respond_to do |format|
      if success
        
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
   
   
        shop_order_hash.values.each do
          |order|
          Notifier.order_received(order).deliver
        end
        
        #Notifier.order_received(@order).deliver
        format.html { redirect_to(store_url, :notice=>'Thank you for your order') }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => errors, :status => :unprocessable_entity }
      end
    end

  end

  ## PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update_attributes(params[:order])

        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  private

  def ensure_order_of_shop
    order = Order.find(params[:id])

    if order.shop.id != current_user.shop.id
      redirect_to current_user.shop, :notice => "Not your order!"
    end
  end
end
