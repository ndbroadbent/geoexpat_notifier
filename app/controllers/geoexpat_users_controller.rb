class GeoexpatUsersController < ApplicationController

  set_tab :geoexpat_users

  # GET /geoexpat_users
  # GET /geoexpat_users.xml
  def index
    @geoexpat_users = GeoexpatUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @geoexpat_users }
    end
  end

  # GET /geoexpat_users/1
  # GET /geoexpat_users/1.xml
  def show
    @geoexpat_user = GeoexpatUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @geoexpat_user }
    end
  end

  # DELETE /geoexpat_users/1
  # DELETE /geoexpat_users/1.xml
  def destroy
    @geoexpat_user = GeoexpatUser.find(params[:id])
    @geoexpat_user.destroy

    respond_to do |format|
      format.html { redirect_to(geoexpat_users_url) }
      format.xml  { head :ok }
    end
  end
end

