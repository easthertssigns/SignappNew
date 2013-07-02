module Refinery
  module HomePageSliders
    module Admin
      class HomePageSlidersController < ::Refinery::AdminController

        crudify :'refinery/home_page_sliders/home_page_slider',
                :title_attribute => 'banner_text', :xhr_paging => true

      end
    end
  end
end
