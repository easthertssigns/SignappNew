class SignData < ActiveRecord::Base
  attr_accessible :description, :height, :spree_product_id, :price, :name, :shape_id, :show_as_product,
                  :account_id, :width, :sign_data, :sharing_key, :image, :svg_data, :spree_variant_id, :deleted_by_admin, :deleted_by_user

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

  belongs_to :product, :class_name => 'Spree::Product', :foreign_key => :spree_product_id, :primary_key => :id

  def self.search_admin(taxon_id = nil, query = nil)

    result = []

    conditions = "account_id IS NOT NULL"

    SignData.where(conditions).order("created_at DESC").each do |r|
      if taxon_id && !taxon_id.blank?
        if r.product
          if r.product.taxons.where("id = ?", taxon_id).count > 0

            if query && !query.blank? && ((r.name.include? query.downcase) || (r.description.include? query.downcase))
              result << r
            elsif !query || query.blank?
              result << r
            end
          end
        end
      else
        result << r
      end
    end

    result
  end

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

  def get_base_shape
    result = nil

    if shape_id
      result = SignBaseShape.find(shape_id)
    end

    result
  end

  def get_local_svg
    # try and get the SVG file and read it
    if svg_data
      svg_data
    end
  end

end

