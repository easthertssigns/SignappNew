# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "HomeSliders" do
    describe "Admin" do
      describe "home_sliders" do
        login_refinery_user

        describe "home_sliders list" do
          before(:each) do
            FactoryGirl.create(:home_slider, :title => "UniqueTitleOne")
            FactoryGirl.create(:home_slider, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.home_sliders_admin_home_sliders_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.home_sliders_admin_home_sliders_path

            click_link "Add New Home Slider"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::HomeSliders::HomeSlider.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::HomeSliders::HomeSlider.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:home_slider, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.home_sliders_admin_home_sliders_path

              click_link "Add New Home Slider"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::HomeSliders::HomeSlider.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:home_slider, :title => "A title") }

          it "should succeed" do
            visit refinery.home_sliders_admin_home_sliders_path

            within ".actions" do
              click_link "Edit this home slider"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:home_slider, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.home_sliders_admin_home_sliders_path

            click_link "Remove this home slider forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::HomeSliders::HomeSlider.count.should == 0
          end
        end

      end
    end
  end
end
