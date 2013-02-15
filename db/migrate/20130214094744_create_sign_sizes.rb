class CreateSignSizes < ActiveRecord::Migration
  def change
    create_table :sign_sizes do |t|
      t.string :title
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
