
FactoryGirl.define do
  factory :home_slider, :class => Refinery::HomeSliders::HomeSlider do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

