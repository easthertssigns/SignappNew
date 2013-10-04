class SignBaseToSize < ActiveRecord::Base
  belongs_to :sign_base_shape
  belongs_to :sign_size

  attr_accessible :sign_base_shape_id, :sign_size_id
end
