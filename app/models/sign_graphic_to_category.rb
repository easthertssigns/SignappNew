class SignGraphicToCategory < ActiveRecord::Base
  attr_accessible :sign_graphic_category_id, :sign_graphic_id

  belongs_to :sign_graphic
  belongs_to :sign_graphic_category
end
