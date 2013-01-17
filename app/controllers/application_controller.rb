class ApplicationController < ActionController::Base
  protect_from_forgery
  include Spree::BaseHelper
  include AccountHelper

  #def after_sign_in_path_for(resource)
  #  if resource.class == CustomerAccount
  #    # raise resource.to_yaml
  #  else
  #        # redirect_to "/refinery"
  #  end
  #end
end
