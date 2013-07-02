module Refinery
  module HomePageSliders
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::HomePageSliders

      engine_name :refinery_home_page_sliders

      initializer "register refinerycms_home_page_sliders plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "home_page_sliders"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.home_page_sliders_admin_home_page_sliders_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/home_page_sliders/home_page_slider',
            :title => 'banner_text'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::HomePageSliders)
      end
    end
  end
end
