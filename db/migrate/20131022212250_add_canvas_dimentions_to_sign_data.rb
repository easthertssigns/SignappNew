class AddCanvasDimentionsToSignData < ActiveRecord::Migration
  def change
    add_column :sign_base_shapes, :canvas_width, :integer
    add_column :sign_base_shapes, :canvas_height, :integer
    add_column :sign_base_shapes, :canvas_scale, :float
  end
end
