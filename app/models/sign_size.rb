class SignSize < ActiveRecord::Base
  has_many :sign_base_to_sizes
  attr_accessible :height, :title, :width
end
