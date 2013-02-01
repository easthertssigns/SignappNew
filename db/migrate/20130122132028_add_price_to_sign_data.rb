class AddPriceToSignData < ActiveRecord::Migration
  def change
    add_column :sign_data, :price, :decimal
  end
end
