class AddProductOveridePrice < ActiveRecord::Migration
  def up
    add_column :spree_products, :price_overide, :float
  end

  def down
    remove_column :spree_products, :price_overide
  end
end
