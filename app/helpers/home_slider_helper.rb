module HomeSliderHelper
  def get_home_sliders
    Refinery::HomeSliders::HomeSlider.all()
  end
end
