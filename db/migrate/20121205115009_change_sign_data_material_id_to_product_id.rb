class ChangeSignDataMaterialIdToProductId < ActiveRecord::Migration
  def change
    rename_column :sign_data, :material_id, :base_product_id
    rename_column :sign_data, :spree_user_id, :account_id
    remove_column :sign_data, :material_variant_id
  end
end
