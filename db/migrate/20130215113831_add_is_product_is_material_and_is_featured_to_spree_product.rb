class AddIsProductIsMaterialAndIsFeaturedToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :is_product, :boolean
    add_column :spree_products, :is_material, :boolean
    add_column :spree_products, :is_featured, :boolean
    add_column :spree_products, :sign_data_id, :integer
  end
end
