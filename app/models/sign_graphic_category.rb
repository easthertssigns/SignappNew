class SignGraphicCategory < ActiveRecord::Base
  attr_accessible :category_description, :category_name
  has_many :sign_graphics
end
