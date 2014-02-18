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

  def collection
    return @collection if @collection.present?

    unless request.xhr?
      params[:q] ||= {}
      params[:q][:deleted_at_null] ||= "1"

      params[:q][:s] ||= "name asc"

      @search = super.ransack(params[:q])
      @collection = @search.result.
          not_child_product.
          group_by_products_id.
          includes([:master, {:variants => [:images, :option_values]}]).
          page(params[:page]).
          per(Spree::Config[:admin_products_per_page])

      if params[:q][:s].include?("master_price")
        # By applying the group in the main query we get an undefined method gsub for Arel::Nodes::Descending
        # It seems to only work when the price is actually being sorted in the query
        # To be investigated later.
        @collection = @collection.group("spree_variants.price")
      end
    else
      includes = [{:variants => [:images,  {:option_values => :option_type}]}, {:master => :images}]

      @collection = super.where(["name #{LIKE} ?", "%#{params[:q]}%"])
      @collection = @collection.includes(includes).limit(params[:limit] || 10)

      tmp = super.where(["#{Variant.table_name}.sku #{LIKE} ?", "%#{params[:q]}%"])
      tmp = tmp.includes(:variants_including_master).limit(params[:limit] || 10)
      @collection.concat(tmp)
    end
    @collection
  end
end