class Refinery::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = Refinery::Memberships::Member.find_for_facebook_oauth(request.env["omniauth.auth"], current_refinery_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
                                                            #set_flash_message(:notice, :success, :kind => "Facebook") #if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    fb_data = request.env["omniauth.auth"].to_s
    raise fb_data
  end
end