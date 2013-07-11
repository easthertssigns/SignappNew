class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :base_product_id, :price, :name, :shape_id, :show_as_product, :account_id, :width, :sign_data, :sharing_key, :image
  has_attached_file :image, :styles => {:extra_large => ["300x300", :jpg], :large => ["300x300", :jpg], :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] },
                      :storage => :s3,
                      :s3_credentials => {:access_key_id => "AKIAJSZTTNHJIAPK672A", :secret_access_key => "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", :bucket => "signapp-prod" }
end
