class AddCustomizationTables < ActiveRecord::Migration
  def change
    create_table :spree_product_customizations do |t|
      t.integer :line_item_id
      t.integer :product_customization_type_id
      t.timestamps
    end

    create_table :spree_product_customization_types do |t|
      t.string :name
      t.string :presentation
      t.string :description
      t.timestamps
    end

    create_table :spree_product_customization_types_products, :id => false do |t|
      t.integer :product_customization_type_id
      t.integer :product_id
    end

  end


end
