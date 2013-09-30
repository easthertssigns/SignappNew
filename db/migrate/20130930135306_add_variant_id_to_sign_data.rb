class AddVariantIdToSignData < ActiveRecord::Migration
  def up
    add_column :sign_data, :spree_variant_id, :integer
  end

  def down
    remove_column :sign_data, :spree_variant_id
  end
end
