class AddShowInMenuToProduct < ActiveRecord::Migration
  def up
    add_column :spree_products, :show_in_menu, :boolean
  end

  def down
    remove_column :spree_products, :show_in_menu
  end
end
