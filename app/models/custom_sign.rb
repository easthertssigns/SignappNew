class CustomSign < ActiveRecord::Base
  belongs_to :spree_user
  attr_accessible :custom_data, :sharing_key, :spree_product_id, :spree_user_id, :name, :description, :width, :height
end
