module Refinery
  module HomeSliders
    module Admin
      class HomeSlidersController < ::Refinery::AdminController

        crudify :'refinery/home_sliders/home_slider', :xhr_paging => true

      end
    end
  end
end
