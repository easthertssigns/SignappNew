Spree::Admin::VariantsController.class_eval do

  def destroy
    raise params[:id]
    @product = Product.where(:permalink => params[:id]).first!
    @product.delete

    flash.notice = I18n.t('notice_messages.product_deleted')

    respond_with(@product) do |format|
      format.html { redirect_to collection_url }
      format.js  { render_js_for_destroy }
    end
  end
end