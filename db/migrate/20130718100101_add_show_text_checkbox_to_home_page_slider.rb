class AddShowTextCheckboxToHomePageSlider < ActiveRecord::Migration
  def up
    add_column :refinery_home_page_sliders, :show_text, :boolean
  end

  def down
    remove_column :refinery_home_page_sliders, :show_text
  end
end
