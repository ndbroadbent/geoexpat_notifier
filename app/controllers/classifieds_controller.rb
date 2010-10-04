class ClassifiedsController < ApplicationController

  set_tab :classifieds

  # GET /classifieds
  # GET /classifieds.xml
  def index
    @classifieds = Classified.paginate :page => params[:page], :order => 'list_date DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifieds }
    end
  end

  # GET /classifieds/1
  # GET /classifieds/1.xml
  def show
    @classified = Classified.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classified }
    end
  end

  # GET /classifieds/new
  # GET /classifieds/new.xml
  def new
    @classified = Classified.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classified }
    end
  end

  # DELETE /classifieds/1
  # DELETE /classifieds/1.xml
  def destroy
    @classified = Classified.find(params[:id])
    @classified.destroy

    respond_to do |format|
      format.html { redirect_to(classifieds_url) }
      format.xml  { head :ok }
    end
  end
end

