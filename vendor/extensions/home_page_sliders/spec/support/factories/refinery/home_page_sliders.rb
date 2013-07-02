
FactoryGirl.define do
  factory :home_page_slider, :class => Refinery::HomePageSliders::HomePageSlider do
    sequence(:banner_text) { |n| "refinery#{n}" }
  end
end

