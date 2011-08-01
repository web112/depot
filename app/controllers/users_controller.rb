class UsersController < ApplicationController
  
  before_filter :clerk_authorize
  before_filter :host_authorize, :only => [:new, :create, :index, :destroy, :edit, :update]
  
  @@per_page_item = 5
  
  # GET /users
  # GET /users.xml
  def index
	@users = current_user.shop.users.paginate :page => params[:page], :order=>'created_at desc',
                             :per_page => @@per_page_item 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
	file = File.open("test.txt","w")
	file.puts @user.attributes
	file.close
	
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end 

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
	
	if(current_user.role == 'host')
		@user.role = 'clerk'
		@user.shop = current_user.shop
	end


    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_url, :notice => "#{@user.role} #{@user.name} was successfully created.") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url, :notice => "#{@user.role} #{@user.name} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
	unless @user.id.eql? current_user.id
		@user.destroy
	end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
