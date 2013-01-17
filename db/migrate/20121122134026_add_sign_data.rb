class AddSignData < ActiveRecord::Migration
  def change
    create_table :custom_signs do |t|
      t.integer :spree_user_id
      t.integer :spree_product_id
      t.text :custom_data
      t.text :sharing_key
      t.text :name
      t.text :description
      t.integer :height
      t.integer :width
      t.timestamps
    end

    create_table :sign_data do |t|
      t.integer :spree_user_id
      t.integer :material_id
      t.integer :material_variant_id
      t.integer :shape_id
      t.integer :width
      t.integer :height
      t.text :name
      t.text :description
      t.boolean :show_as_product
      t.timestamps
    end

    add_column :sign_data, :sign_data, :text
    add_column :sign_data, :sharing_key, :text

    create_table :sign_base_shapes do |t|
      t.text :name
      t.text :description
      t.timestamps
    end

    add_column :sign_base_shapes, :svg_file_file_name, :string
    add_column :sign_base_shapes, :svg_file_content_type, :string
    add_column :sign_base_shapes, :svg_file_file_size, :integer
    add_column :sign_base_shapes, :svg_file_updated_at, :datetime

    create_table :sign_graphic_categories do |t|
      t.text :category_name
      t.text :category_description
      t.timestamps
    end

    create_table :sign_graphics do |t|
      t.text :title
      t.text :description
      t.timestamps
    end

    add_column :sign_graphics, :svg_file_file_name, :string
    add_column :sign_graphics, :svg_file_content_type, :string
    add_column :sign_graphics, :svg_file_file_size, :integer
    add_column :sign_graphics, :svg_file_updated_at, :datetime

    create_table :sign_graphic_to_categories do |t|
      t.integer :sign_graphic_id
      t.integer :sign_graphic_category_id
      t.timestamps
    end

    create_table :sign_base_shape_to_products do |t|
      t.integer :sign_base_shape_id
      t.integer :spree_product_id
      t.timestamps
    end

    create_table :sign_categories do |t|
      t.text :category_name
      t.text :category_description
      t.boolean :category_enabled
      t.timestamps
    end

    create_table :sign_data_to_categories do |t|
      t.integer :sign_data_id
      t.integer :sign_category_id

      t.timestamps
    end
  end
end
