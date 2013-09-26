class AdSvgFieldToSignData < ActiveRecord::Migration
  def up
    add_column :sign_data, :svg_data, :text
  end

  def down
    remove_column :sign_data, :svg_data
  end
end
