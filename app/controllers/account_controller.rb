class AccountController < ApplicationController
  # before_filter :authenticate_customer_account!

  def overview
    @member = current_refinery_user
    @saved_signs = SignData.all(:conditions => ["account_id = ?", current_refinery_user.id.to_s])
    @orders = Spree::Order.all(:conditions => ["user_id = ?", current_refinery_user.id.to_s])
    render :action => 'overview'
  end

  def sign_in
  end

  def sign_in_user
    raise "woo hoo, got as far as this at least"
  end

  def sign_out
  end

  def create
  end

  def create_new_user
    raise "this is the bit where a new user will be created"
  end

end
