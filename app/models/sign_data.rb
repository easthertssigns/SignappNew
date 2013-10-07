class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :spree_product_id, :price, :name, :shape_id, :show_as_product,
                  :account_id, :width, :sign_data, :sharing_key, :image, :svg_data, :spree_variant_id

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

  def get_background_image
    image = nil
    if spree_variant_id
      # get variant
      if Spree::Variant.where(:id => spree_variant_id).count > 0 && Spree::Variant.where(:id => spree_variant_id).first.images.count > 0
        image = Spree::Variant.where(:id => spree_variant_id).first.images.first
      end
    end

    unless image
      #raise "no variant match"
    end

    if !image && spree_product_id && Spree::Product.where(:id => spree_product_id).count > 0
      product = Spree::Product.where(:id => spree_product_id).first

      if !product.editor_background_image_id.nil?
        if Spree::Asset.where("id = ?", product.editor_background_image_id).count > 0
          image = Spree::Asset.find product.editor_background_image_id
        end
      end
    end

    image
  end

  def get_mask
    result = nil

    if shape_id
      base_shape = SignBaseShape.find(shape_id)
      if base_shape.svg_file.present?
        result = "/custom_sign/#{shape_id}/get_sign_shape_svg.svg"
      else
        nil
      end
    else
      nil
    end

    result
  end

  def get_local_svg
    # try and get the SVG file and read it
    if svg_data
      @doc = Nokogiri::XML(svg_data)

      svg = @doc.at_css "svg"


      width = svg["width"].to_i
      height = svg["height"].to_i

      # add clipping path?!?!?!

      #<defs>
      #  <clipPath id="signClip">
      #  <rect x="0" y ="0" width="150" height="150" style="fill:black;stroke:pink;stroke-width:5;fill-opacity:0; stroke-opacity:1"/>
      #  </clipPath>
      #</defs>

      defs = Nokogiri::XML::Node.new "defs", @doc
      clip_path = Nokogiri::XML::Node.new "clipPath", @doc
      rect = Nokogiri::XML::Node.new "rect", @doc

      rect["x"] = 0
      rect["y"] = 0
      rect["width"] = width
      rect["height"] = height
      #rect["style"] = "fill:black;stroke:pink;stroke-width:5;fill-opacity:0; stroke-opacity:1"

      clip_path["id"] = "signClip"
      #clip_path["clipPathUnits"] = "objectBoundingBox"

      g = @doc.at_css "g"

      @doc.css("g").each do |node|
        t = node["transform"]

        translate_match = false
        scale_match = false

        neg_t = ""

        # match translate
        if t =~ /translate\((-?[0-9]\d*(\.\d+)?) (-?[0-9]\d*(\.\d+)?)\)/
          matches = t.match /translate\((-?[0-9]\d*(\.\d+)?) (-?[0-9]\d*(\.\d+)?)\)/
          #raise matches[0]

          tmp = matches[0].gsub! 'translate(', ''
          tmp = tmp.gsub! ')', ''

          nums = tmp.split

          neg_t = "translate(" + (-nums[0].to_f).to_s + " " + (-nums[1].to_f).to_s + ")"
        end

        # match scale
        if t =~ /scale\((-?[0-9]\d*(\.\d+)?) (-?[0-9]\d*(\.\d+)?)\)/
          matches = t.match /scale\((-?[0-9]\d*(\.\d+)?) (-?[0-9]\d*(\.\d+)?)\)/

          tmp = matches[0].gsub! 'scale(', ''
          tmp = tmp.gsub! ')', ''

          nums = tmp.split

          if neg_t.length > 0
            neg_t += " "
          end
          neg_t += "scale(" + (-nums[0].to_f).to_s + " " + (-nums[1].to_f).to_s + ")"
        end

        #raise neg_t + " > " + t

        # <use xlink:href="#words" transform="translate(110,0)" style="clip-path: url(#circularPath);"/>
        use = Nokogiri::XML::Node.new "use", @doc

        #use[""]
      end

      Spree::Variant


      g["clip-path"] = "url(#signClip)"
      g["overflow"] = "hidden"
      svg["overflow"] = "hidden"

      clip_path.add_child(rect)
      defs.add_child(clip_path)

      svg.add_child(defs)

      #g.attributes["transform"].remove

      svg["width"] = 500
      svg["height"] = 300

      svg["viewBox"] = "0 0 #{width} #{height}"

      g["viewBox"] = "0 0 #{width} #{height}"

      @doc.to_s
    end
  end

end

