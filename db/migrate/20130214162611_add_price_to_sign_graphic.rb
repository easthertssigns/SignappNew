class AddPriceToSignGraphic < ActiveRecord::Migration
  def change
    add_column :sign_graphics, :price, :decimal
  end
end
