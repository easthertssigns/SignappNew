module AccountHelper
  def account_logged_in
    # check for session user_id
    if session[:account_id]
      true
    else
      false
    end
  end


end
