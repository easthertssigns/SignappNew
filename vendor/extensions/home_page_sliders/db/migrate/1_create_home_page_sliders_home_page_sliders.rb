class CreateHomePageSlidersHomePageSliders < ActiveRecord::Migration

  def up
    create_table :refinery_home_page_sliders do |t|
      t.string :banner_text
      t.boolean :display
      t.integer :background_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-home_page_sliders"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/home_page_sliders/home_page_sliders"})
    end

    drop_table :refinery_home_page_sliders

  end

end
