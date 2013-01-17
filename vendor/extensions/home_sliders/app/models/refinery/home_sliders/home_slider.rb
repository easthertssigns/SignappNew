module Refinery
  module HomeSliders
    class HomeSlider < Refinery::Core::BaseModel
      self.table_name = 'refinery_home_sliders'

      attr_accessible :title, :background_id, :content, :position

      acts_as_indexed :fields => [:title, :content]

      validates :title, :presence => true, :uniqueness => true
      belongs_to :background, :class_name => '::Refinery::Image'
    end
  end
end
