class HistoryItemsController < ApplicationController
  # GET /history_items
  # GET /history_items.xml
  before_filter :buyer_authorize
  
  def index
    
    @history_items = current_user.history_items.sort{|x,y|y.created_at<=>x.created_at}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @history_items }
    end
  end

  

  # DELETE /history_items/1
  # DELETE /history_items/1.xml
  def destroy
    @history_item = HistoryItem.find(params[:id])
    @history_item.destroy

    respond_to do |format|
      format.html { redirect_to(history_items_url) }
      format.xml  { head :ok }
    end
  end
end
