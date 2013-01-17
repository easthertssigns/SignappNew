module Refinery
  module HomeSliders
    class HomeSlidersController < ::ApplicationController

      before_filter :find_all_home_sliders
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_slider in the line below:
        present(@page)
      end

      def show
        @home_slider = HomeSlider.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_slider in the line below:
        present(@page)
      end

    protected

      def find_all_home_sliders
        @home_sliders = HomeSlider.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/home_sliders").first
      end

    end
  end
end
