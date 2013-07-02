# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "HomePageSliders" do
    describe "Admin" do
      describe "home_page_sliders" do
        login_refinery_user

        describe "home_page_sliders list" do
          before do
            FactoryGirl.create(:home_page_slider, :banner_text => "UniqueTitleOne")
            FactoryGirl.create(:home_page_slider, :banner_text => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.home_page_sliders_admin_home_page_sliders_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.home_page_sliders_admin_home_page_sliders_path

            click_link "Add New Home Page Slider"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Banner Text", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::HomePageSliders::HomePageSlider.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Banner Text can't be blank")
              Refinery::HomePageSliders::HomePageSlider.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:home_page_slider, :banner_text => "UniqueTitle") }

            it "should fail" do
              visit refinery.home_page_sliders_admin_home_page_sliders_path

              click_link "Add New Home Page Slider"

              fill_in "Banner Text", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::HomePageSliders::HomePageSlider.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:home_page_slider, :banner_text => "A banner_text") }

          it "should succeed" do
            visit refinery.home_page_sliders_admin_home_page_sliders_path

            within ".actions" do
              click_link "Edit this home page slider"
            end

            fill_in "Banner Text", :with => "A different banner_text"
            click_button "Save"

            page.should have_content("'A different banner_text' was successfully updated.")
            page.should have_no_content("A banner_text")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:home_page_slider, :banner_text => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.home_page_sliders_admin_home_page_sliders_path

            click_link "Remove this home page slider forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::HomePageSliders::HomePageSlider.count.should == 0
          end
        end

      end
    end
  end
end
