require 'spec_helper'

module Refinery
  module HomePageSliders
    describe HomePageSlider do
      describe "validations" do
        subject do
          FactoryGirl.create(:home_page_slider,
          :banner_text => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:banner_text) { should == "Refinery CMS" }
      end
    end
  end
end
