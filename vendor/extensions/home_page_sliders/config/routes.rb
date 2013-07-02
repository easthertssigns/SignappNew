Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :home_page_sliders do
    resources :home_page_sliders, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :home_page_sliders, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :home_page_sliders, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
