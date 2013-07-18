class AddFeaturedProductToProduct < ActiveRecord::Migration
  def up
    add_column :spree_products, :featured_product, :boolean
  end

  def down
    remove_column :spree_products, :featured_product
  end

end
