class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :base_product_id, :price, :name, :shape_id, :show_as_product, :account_id, :width, :sign_data, :sharing_key, :image
  has_attached_file :image, :styles => {:extra_large => ["300x300", :jpg], :large => ["300x300", :jpg], :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] },
                      :storage => :s3,
                      :s3_credentials => {:access_key_id => "AKIAJHMMYZ5GOYGV6OHQ", :secret_access_key => "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", :bucket => "signapp-dev" }
end
