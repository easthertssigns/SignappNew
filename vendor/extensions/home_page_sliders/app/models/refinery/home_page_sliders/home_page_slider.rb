module Refinery
  module HomePageSliders
    class HomePageSlider < Refinery::Core::BaseModel
      self.table_name = 'refinery_home_page_sliders'

      attr_accessible :banner_text, :display, :background_id, :position, :show_text

      acts_as_indexed :fields => [:banner_text]

      validates :banner_text, :presence => true, :uniqueness => true

      belongs_to :background, :class_name => '::Refinery::Image'
    end
  end
end
