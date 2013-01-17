class CreateHomeSlidersHomeSliders < ActiveRecord::Migration

  def up
    create_table :refinery_home_sliders do |t|
      t.string :title
      t.integer :background_id
      t.text :content
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-home_sliders"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/home_sliders/home_sliders"})
    end

    drop_table :refinery_home_sliders

  end

end
