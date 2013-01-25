Spree::Admin::ProductsController.class_eval do
  def update_editor_bg_image
    product = Spree::Product.find params[:product_id]
    #product is being found, need to figure out where to store the background image id now.
    product.editor_background_image_id = params["image_id"]
    product.save
    render :json => { :result => "ok" }
  end
end