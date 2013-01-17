Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :home_sliders do
    resources :home_sliders, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :home_sliders, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :home_sliders, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
