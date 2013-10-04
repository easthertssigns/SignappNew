class CreateSignBaseToSizes < ActiveRecord::Migration
  def change
    create_table :sign_base_to_sizes do |t|
      t.integer :sign_base_shape_id
      t.integer :sign_size_id

      t.timestamps
    end
  end
end
