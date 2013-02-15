SignappNew::Application.routes.draw do

  match "choose_material" => "choose_material#index"

  # devise_for :customer_account

  get "account/overview"
  get "account/create"
  get "account/edit"
  get "account/login"
  get "account/logout"
  match "account/login" => "account#sign_in_user", :via => :post
  match "account/create" => "account#create_new_user", :via => :post

  match "/orders/add_saved_sign_to_basket" => "spree/orders#add_saved_sign_to_basket"

  # devise_for :customer_accounts, :controllers => { :sessions => "account_sessions" }

  # match "/user." => "spree/users#create", :via => :post
  match "admin/users/:id/add_note" => "spree/admin/users#add_note"
  match "admin/users/save_note" => "spree/admin/users#save_note"
  match "admin/users/update_note" => "spree/admin/users#update_note"
  match "admin/users/:user_id/:note_id/delete_note" => "spree/admin/users#delete_note"
  match "admin/users/:user_id/:note_id/edit_note" => "spree/admin/users#edit_note"

  match "custom_sign/save_sign" => "custom_sign#save_sign"
  match "custom_sign/save_dialog" => "custom_sign#save_dialog"
  match "custom_sign/load_sign_list/:user_id" => "custom_sign#load_sign_list"
  match "custom_sign/load_sign_ajax" => "custom_sign#load_sign_ajax"
  match "custom_sign/edit_sign" => "custom_sign#edit_sign"
  match "custom_sign/new_custom_sign" => "custom_sign#new_custom_sign"
  match "custom_sign/calculate_sign_base_price" => "custom_sign#calculate_sign_base_price"
  match "custom_sign/delete_saved_sign" => "custom_sign#delete_saved_sign", :via => :post

  match "admin/sign_shapes" => "spree/admin#sign_shapes"
  match "admin/add_sign_shape" => "spree/admin/products#add_sign_shape"
  match "admin/new_sign_shape" => "spree/admin/products#new_sign_shape"
  match "admin/edit_sign_shape" => "spree/admin/products#edit_sign_shape"
  match "admin/show_sign_shape" => "spree/admin/products#show_sign_shape"
  match "admin/delete_sign_shape" => "spree/admin/products#delete_sign_shape"
  match "admin/upload_sign_shape" => "spree/admin/products#upload_sign_shape", :via => :post
  match "admin/update_sign_shape" => "spree/admin/products#update_sign_shape", :via => :put
  #match "admin/sign_graphics" => "sign_graphics#index"

  match "admin/sign_data/filter_product_list_ajax" => "spree/admin/sign_data#filter_product_list_ajax"
  match "admin/sign_data/filter_results_ajax" => "spree/admin/sign_data#filter_results_ajax"
  match "admin/sign_data/set_show_as_product_ajax" => "spree/admin/sign_data#set_show_as_product_ajax"
  match "admin/sign_data/delete_sign" => "spree/admin/sign_data#delete_sign"

  match "/admin/update_editor_bg_image" => "spree/admin/products#update_editor_bg_image"

  match "admin/users/:id/log_in_as" => "spree/admin/users#log_in_as"
  root :to => "refinery/pages#home"

  # match "choose_material" => "refinery/pages#choose_material"

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, :at => '/'

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, :at => '/'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  #root :to => "static#home"



end

Spree::Core::Engine.routes.draw do
  get "choose_material/show"

  get "choose_material/index"

  get "account/overview"

  namespace :admin do
    resources :sign_graphics
    resources :sign_shape
    resources :sign_graphic_category
    resources :sign_category
    resources :sign_data
    resources :sign_size
  end
end