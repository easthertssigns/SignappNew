class AddAttachmentImageToSignData < ActiveRecord::Migration
  def self.up
    add_column :sign_data, :image_file_name, :string
    add_column :sign_data, :image_content_type, :string
    add_column :sign_data, :image_file_size, :integer
    add_column :sign_data, :image_updated_at, :datetime
  end

  def self.down
    remove_column :sign_data, :image_file_name
    remove_column :sign_data, :image_content_type
    remove_column :sign_data, :image_file_size
    remove_column :sign_data, :image_updated_at
  end
end
