Spree::Image.class_eval do

  has_attached_file :attachment,
                    :styles => {
                        :micro => '40x40#', # thumbs under image
                        :mini => '75x75#', # thumbs under image
                        :small => '235x235#', # images on category view
                        :basket_icon => '124x84#', # images on category view
                        :product => '400x400#', # full product image
                        :large => ['1000x1000#',:jpg] # light box image
                    },
                    :default_style => :product,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "signapp-prod",
                    :url => '/spree/products/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/spree/products/:id/:style/:basename.:extension',
                    :convert_options => {
                        #:mini => "-resize 40x40 -background white -gravity center -extent 40x40 -quality 92 -strip -colorspace RGB",
                        #:micro => "-resize 62x35 -background white -gravity center -extent 62x35 -quality 92 -strip -colorspace RGB",
                        #:small => "-resize 120x70 -background white -gravity center -extent 120x70 -quality 92 -strip -colorspace RGB",
                        #:thumb => "-resize 270x155 -background white -gravity center -extent 270x155 -quality 92 -strip -colorspace RGB",
                        #:product => "-resize 520x300 -background white -gravity center -extent 520x300 -quality 92 -strip -colorspace RGB",
                        #:large => "-resize 1000x1000 -background white -gravity center -extent 1000x1000 -quality 92 -strip -colorspace RGB",
                        :micro => "-background transparent -gravity center -extent 40x40 -strip",
                        :mini => "-background transparent -gravity center -extent 75x75 -strip",
                        :small => "-background transparent -gravity center -extent 235x235 -strip",
                        :basket_icon => "-background transparent -gravity center -extent 124x84 -strip",
                        :product => "-background transparent -gravity center -extent 400x400 -strip",
                        :large => "-background transparent -gravity center -extent 1000x1000 -strip"
                    }

  # Load user defined paperclip settings
  if Spree::Config[:use_s3]
    s3_creds = {:access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket]}
    Spree::Image.attachment_definitions[:attachment][:storage] = :s3
    Spree::Image.attachment_definitions[:attachment][:s3_credentials] = s3_creds
    Spree::Image.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
    Spree::Image.attachment_definitions[:attachment][:bucket] = Spree::Config[:s3_bucket]
  end

end