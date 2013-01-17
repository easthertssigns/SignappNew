class SignGraphic < ActiveRecord::Base
  attr_accessible :description, :title, :svg_file
  has_attached_file :svg_file, :styles => { :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] }
  has_many :sign_graphic_categories
end
