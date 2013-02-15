class SignGraphic < ActiveRecord::Base
  attr_accessible :description, :title, :svg_file, :price
  has_attached_file :svg_file, :styles => { :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] },
                    :storage => :s3,
                    :s3_credentials => {:access_key_id => "AKIAJHMMYZ5GOYGV6OHQ", :secret_access_key => "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", :bucket => "signapp-dev" }
  has_many :sign_graphic_categories
end
