Rails.application.routes.draw do
  devise_for :customer_account do

  end

  get "static/home", :as=>"customer_account_root"
end