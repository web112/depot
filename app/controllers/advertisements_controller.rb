class AdvertisementsController < ApplicationController
  before_filter :administrator_authorize
  
  @@per_page_item = 10
  
  # GET /advertisements
  # GET /advertisements.xml
  def index
    @advertisements = Advertisement.all.paginate :page => params[:page], :order=>'created_at desc',
    :per_page => @@per_page_item


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advertisements }
    end
  end

  # GET /advertisements/1
  # GET /advertisements/1.xml
  def show
    @advertisement = Advertisement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advertisement }
    end
  end

  # GET /advertisements/new
  # GET /advertisements/new.xml
  def new
    @advertisement = Advertisement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advertisement }
    end
  end

  # GET /advertisements/1/edit
  def edit
    @advertisement = Advertisement.find(params[:id])
  end

  # POST /advertisements
  # POST /advertisements.xml
  def create
    @advertisement = Advertisement.new(params[:advertisement])

    respond_to do |format|
      if @advertisement.save
        format.html { redirect_to(@advertisement, :notice => 'Advertisement was successfully created.') }
        format.xml  { render :xml => @advertisement, :status => :created, :location => @advertisement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advertisement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /advertisements/1
  # PUT /advertisements/1.xml
  def update
    @advertisement = Advertisement.find(params[:id])

    respond_to do |format|
      if @advertisement.update_attributes(params[:advertisement])
        format.html { redirect_to(@advertisement, :notice => 'Advertisement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advertisement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisements/1
  # DELETE /advertisements/1.xml
  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy

    respond_to do |format|
      format.html { redirect_to(advertisements_url) }
      format.xml  { head :ok }
    end
  end
end
