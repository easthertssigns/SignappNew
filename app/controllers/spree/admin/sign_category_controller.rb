class Spree::Admin::SignCategoryController < ApplicationController

  helper "spree/admin/navigation"
  layout "spree/layouts/admin"

  def index
    @categories = SignCategory.paginate(:page => params[:page])
  end

  def new
    @category = SignCategory.new
  end

  def create
    @category = SignCategory.new
    @category.update_attributes(params[:sign_category])
    @category.save
    redirect_to "/admin/sign_category"
  end

  def show
    @category = SignCategory.find params[:id]
  end

  def edit
    @category = SignCategory.find params[:id]
  end

  def update
    @category = SignCategory.find params[:id]
    @category.update_attributes(params[:sign_category])
    redirect_to "/admin/sign_category"
  end

  def destroy
    category = SignCategory.find params[:id]
    #delete any links to sign graphics
    SignDataToCategory.delete_all(["sign_category_id = ?", :params[id]])
    category.destroy
    redirect_to "/admin/sign_category"
  end
end
