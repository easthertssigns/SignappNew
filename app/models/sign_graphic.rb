class SignGraphic < ActiveRecord::Base
  attr_accessible :description, :title, :svg_file, :price
  has_attached_file :svg_file, :styles => { :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] },
                    :storage => :s3,
                    :s3_credentials => {:access_key_id => "AKIAJSZTTNHJIAPK672A", :secret_access_key => "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", :bucket => "signapp-prod" }
  has_many :sign_graphic_categories
end
