class AddCanvasDimentionsToSignData < ActiveRecord::Migration
  def change
    add_column :sign_data, :canvas_width, :integer
    add_column :sign_data, :canvas_height, :integer
    add_column :sign_data, :canvas_scale, :float
  end
end
