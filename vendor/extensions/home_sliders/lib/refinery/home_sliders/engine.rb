module Refinery
  module HomeSliders
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::HomeSliders

      engine_name :refinery_home_sliders

      initializer "register refinerycms_home_sliders plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "home_sliders"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.home_sliders_admin_home_sliders_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/home_sliders/home_slider'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::HomeSliders)
      end
    end
  end
end
