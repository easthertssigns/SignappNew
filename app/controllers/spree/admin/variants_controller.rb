module Spree
  module Admin
    class VariantsController < ResourceController
      belongs_to 'spree/product', :find_by => :permalink
      #create.before :create_before
      #new_action.before :new_before

      def index
        #raise params.to_yaml
        respond_with(collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end

      # override the destory method to set deleted_at value
      # instead of actually deleting the product.
      def destroy
        raise params.to_yaml
      end

      def update_positions
        params[:positions].each do |id, index|
          Variant.where(:id => id).update_all(:position => index)
        end

        respond_with(@variant) do |format|
          format.html { redirect_to admin_product_variants_url(params[:product_id]) }
          format.js { render :text => 'Ok' }
        end
      end

      protected

      def create_before
        option_values = params[:new_variant]
        option_values.each_value { |id| @object.option_values << OptionValue.find(id) }
        @object.save
      end


      def new_before
        @object.attributes = @object.product.master.attributes.except('id', 'created_at', 'deleted_at',
                                                                      'sku', 'is_master', 'count_on_hand')
      end

      def collection
        @collection = Spree::Product.find_by_permalink(params[:product_id]).child_products
      end

      def json_data
        (parent.variants.presence || [parent.master]).map do |v|
          {:label => v.options_text.presence || v.name, :id => v.id}
        end
      end

    end
  end
end