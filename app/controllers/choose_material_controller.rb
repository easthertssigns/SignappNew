class ChooseMaterialController < ApplicationController
  def show

  end

  def index
    @taxon = Spree::Taxon.find_by_permalink!("material")
  end
end
