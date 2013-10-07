class SignGraphic < ActiveRecord::Base
  attr_accessible :description, :title, :svg_file, :price
  has_attached_file :svg_file,
                    :styles => {
                        :medium => ["300x300", :jpg],
                        :thumb => ["100x100", :jpg] },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "signapp-prod",
                    :url => '/spree/products/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/spree/products/:id/:style/:basename.:extension'

  has_many :sign_graphic_categories

end
