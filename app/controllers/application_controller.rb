class ApplicationController < ActionController::Base
  protect_from_forgery
  include Spree::BaseHelper
  include AccountHelper

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      if resource_or_scope.class.name == "Refinery::Memberships::Member"
        "/members/welcome"
      end
                                     #raise resource_or_scope.to_yaml
    end
  end
end
