class AddParwentProduyctIdToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :parent_id, :integer
  end
end
