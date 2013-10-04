class SignBaseShape < ActiveRecord::Base
  has_many :sign_base_to_sizes

  attr_accessible :description, :name, :svg_file, :custom_size, :screw_hole_top_left,
                  :screw_hole_top, :screw_hole_top_right, :screw_hole_right, :screw_hole_bottom_right,
                  :screw_hole_bottom, :screw_hole_bottom_left, :screw_hole_left

  has_many :sign_sizes, :through => :sign_base_to_sizes

  has_attached_file :svg_file,
                    :styles => {
                        :medium => ["300x300", :jpg],
                        :thumb => ["100x100", :jpg],
                        :mini => ["20x20", :jpg]
                    },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => "signapp-prod",
                    :url => '/spree/products/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/spree/products/:id/:style/:basename.:extension'

  def has_size(sign_size_id)
    sign_base_to_sizes.where(:sign_size_id => sign_size_id).any?
  end

  def add_size_if_not_added(size)
    unless sign_base_to_sizes.where(:sign_size_id => size.id).any?
      sign_base_to_sizes << SignBaseToSize.new(:sign_size_id => size.id)
    end
  end

  def remove_size_if_added(size)
    if sign_base_to_sizes.where(:sign_size_id => size.id).any?
      sign_base_to_sizes.where(:sign_size_id => size.id).delete_all
    end
  end

end

