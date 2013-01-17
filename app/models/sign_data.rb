class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :material_id, :material_variant_id, :name, :shape_id, :show_as_product, :spree_user_id, :width
end
