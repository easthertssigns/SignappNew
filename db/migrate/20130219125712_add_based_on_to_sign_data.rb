class AddBasedOnToSignData < ActiveRecord::Migration
  def change
    add_column :sign_data, :based_on, :integer
  end
end
