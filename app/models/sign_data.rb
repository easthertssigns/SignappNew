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

  def get_local_svg
    # try and get the SVG file and read it


    f = File.open("#{Rails.root}/tmp/#{id}.svg")
    @doc = Nokogiri::XML(f)
    f.close

    svg = @doc.at_css "svg"

    width = svg["width"].to_i
    svg.attributes["width"].remove

    height = svg["height"].to_i
    svg.attributes["height"].remove

    svg["viewBox"] = "0 0 #{width} #{height}"

    svg["width"] = "100"
    svg["height"] = "60"

    @doc.to_s
  end
end

