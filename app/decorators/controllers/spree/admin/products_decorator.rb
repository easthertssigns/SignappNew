Spree::Admin::ProductsController.class_eval do
  def update_editor_bg_image
    product = Spree::Product.find params[:product_id]
    #product is being found, need to figure out where to store the background image id now.
    product.editor_background_image_id = params["image_id"]
    product.save
    render :json => { :result => "ok" }
  end

  def edit
    #@product = Spree::Product.find_by_permalink(params[:id], :conditions => ["is_material=true"]) || nil
    @product = Spree::Product.first(:conditions => ["permalink = ?", params[:id]]) || nil
    if @product.nil?
      redirect_to "/admin/products/product_not_found"
    end
  end

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

  def create
    authorize! :create, Spree::Product
    params[:product][:available_on] ||= Time.now
    @product = Spree::Product.new(params[:product])
    @product.is_material = 't'
    if @product.save
      render :edit, :status => 201
    else
      invalid_resource!(@product)
    end
  end

  def product_not_found

  end
end