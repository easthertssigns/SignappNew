Spree::Taxon.class_eval do
has_attached_file :icon,
                    :styles => {:mini => '32x32>', :normal => '400x400#'},
                    :default_style => :mini,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :url => '/spree/taxons/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/spree/taxons/:id/:style/:basename.:extension',
                    :convert_options => {
                        :mini => "-background transparent -gravity center -extent 75x75 -strip",
                        :normal => "-background transparent -gravity center -extent 400x400 -strip",
                    }
end