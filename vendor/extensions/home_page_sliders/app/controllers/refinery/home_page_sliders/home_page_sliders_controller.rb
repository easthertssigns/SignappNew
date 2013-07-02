module Refinery
  module HomePageSliders
    class HomePageSlidersController < ::ApplicationController

      before_filter :find_all_home_page_sliders
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_page_slider in the line below:
        present(@page)
      end

      def show
        @home_page_slider = HomePageSlider.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @home_page_slider in the line below:
        present(@page)
      end

    protected

      def find_all_home_page_sliders
        @home_page_sliders = HomePageSlider.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/home_page_sliders").first
      end

    end
  end
end
