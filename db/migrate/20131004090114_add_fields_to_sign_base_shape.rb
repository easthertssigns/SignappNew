class AddFieldsToSignBaseShape < ActiveRecord::Migration
  def up
    add_column :sign_base_shapes, :custom_size, :boolean

    add_column :sign_base_shapes, :screw_hole_top_left, :boolean
    add_column :sign_base_shapes, :screw_hole_top, :boolean
    add_column :sign_base_shapes, :screw_hole_top_right, :boolean
    add_column :sign_base_shapes, :screw_hole_right, :boolean
    add_column :sign_base_shapes, :screw_hole_bottom_right, :boolean
    add_column :sign_base_shapes, :screw_hole_bottom, :boolean
    add_column :sign_base_shapes, :screw_hole_bottom_left, :boolean
    add_column :sign_base_shapes, :screw_hole_left, :boolean
  end

  def down
    remove_column :sign_base_shapes, :custom_size

    remove_column :sign_base_shapes, :screw_hole_top_left
    remove_column :sign_base_shapes, :screw_hole_top
    remove_column :sign_base_shapes, :screw_hole_top_right
    remove_column :sign_base_shapes, :screw_hole_right
    remove_column :sign_base_shapes, :screw_hole_bottom_right
    remove_column :sign_base_shapes, :screw_hole_bottom
    remove_column :sign_base_shapes, :screw_hole_bottom_left
    remove_column :sign_base_shapes, :screw_hole_left
  end
end
