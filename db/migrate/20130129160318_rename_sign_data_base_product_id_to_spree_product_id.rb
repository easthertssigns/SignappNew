class RenameSignDataBaseProductIdToSpreeProductId < ActiveRecord::Migration
  def up
    rename_column :sign_data, :base_product_id, :spree_product_id
  end

  def down
    rename_column :sign_data, :spree_product_id, :base_product_id
  end
end
