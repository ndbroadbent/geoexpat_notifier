class CategoriesController < ApplicationController

  set_tab :categories

  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    if params[:id] == "all"
      Category.all.each do |category|
        category.destroy
      end
    else
      @category = Category.find(params[:id])
      @category.destroy
    end

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end

