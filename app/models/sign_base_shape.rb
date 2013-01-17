class SignBaseShape < ActiveRecord::Base
  attr_accessible :description, :name, :svg_file
  has_attached_file :svg_file, :styles => { :medium => ["300x300", :jpg], :thumb => ["100x100", :jpg] }
end

