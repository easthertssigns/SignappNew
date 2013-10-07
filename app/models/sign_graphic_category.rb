class SignGraphicCategory < ActiveRecord::Base
  attr_accessible :category_description, :category_name
  has_many :sign_graphic_to_categories
  has_many :sign_graphics, :through => :sign_graphic_to_categories
end
