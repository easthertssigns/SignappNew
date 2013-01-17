class Spree::Admin::SignGraphicCategoryController < ApplicationController

  helper "spree/admin/navigation"
  layout "spree/layouts/admin"

  def index
    @categories = SignGraphicCategory.paginate(:page => params[:page])
  end

  def create
    @category = SignGraphicCategory.new
    @category.update_attributes(params[:sign_graphic_category])
    @category.save
    redirect_to "/admin/sign_graphic_category"
  end

  def new
    @category = SignGraphicCategory.new
  end

  def edit
    @category = SignGraphicCategory.find params[:id]
  end

  def show
    @category = SignGraphicCategory.find params[:id]
  end

  def update
    @category = SignGraphicCategory.find params[:id]
    @category.update_attributes(params[:sign_graphic_category])
    redirect_to "/admin/sign_graphic_category"
  end

  def destroy
    category = SignGraphicCategory.find params[:id]
    #delete any links to sign graphics
    SignGraphicToCategory.delete_all(["sign_graphic_category_id = ?", :params[id]])
    category.destroy
    redirect_to "/admin/sign_graphic_category"
  end

end
