class BookTypesController < ApplicationController
  # GET /book_types
  # GET /book_types.xml
  def index
    @book_types = BookType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @book_types }
    end
  end

  # GET /book_types/1
  # GET /book_types/1.xml
  def show
    @book_type = BookType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book_type }
    end
  end

  # GET /book_types/new
  # GET /book_types/new.xml
  def new
    @book_type = BookType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book_type }
    end
  end

  # GET /book_types/1/edit
  def edit
    @book_type = BookType.find(params[:id])
  end

  # POST /book_types
  # POST /book_types.xml
  def create
    @book_type = BookType.new(params[:book_type])

    respond_to do |format|
      if @book_type.save
        format.html { redirect_to(@book_type, :notice => 'Book type was successfully created.') }
        format.xml  { render :xml => @book_type, :status => :created, :location => @book_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /book_types/1
  # PUT /book_types/1.xml
  def update
    @book_type = BookType.find(params[:id])

    respond_to do |format|
      if @book_type.update_attributes(params[:book_type])
        format.html { redirect_to(@book_type, :notice => 'Book type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /book_types/1
  # DELETE /book_types/1.xml
  def destroy
    @book_type = BookType.find(params[:id])
    @book_type.destroy

    respond_to do |format|
      format.html { redirect_to(book_types_url) }
      format.xml  { head :ok }
    end
  end
end
