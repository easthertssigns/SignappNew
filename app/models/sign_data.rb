class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :spree_product_id, :price, :name, :shape_id, :show_as_product, :account_id, :width, :sign_data, :sharing_key, :image
  has_attached_file :image,
                    :styles => {
                        :extra_large => ["300x300", :jpg],
                        :large => ["300x300", :jpg],
                        :medium => ["300x300", :jpg],
                        :thumb => ["100x100", :jpg]
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "signapp-prod",
                    :url => '/spree/products/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/spree/products/:id/:style/:basename.:extension'
end
