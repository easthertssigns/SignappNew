class AddEditorBackgroundImageIdToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :editor_background_image_id, :integer
  end
end
