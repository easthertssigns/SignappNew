class AddSignDataIdToSpreeLineItem < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :sign_data_id, :integer
  end
end
