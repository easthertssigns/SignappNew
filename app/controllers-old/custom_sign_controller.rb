class CustomSignController < ApplicationController
  def save_sign
    @message = ""
    if params[:id].nil?
      #create new custom sign
      @new_sign = CustomSign.new
      @new_sign.spree_user_id = params[:spree_user_id]
      @new_sign.custom_data = params[:custom_data]
      unless params[:name].nil?
        @new_sign.name = params[:name]
      end
      unless params[:spree_product_id].nil?
        @new_sign.spree_product_id = params[:spree_product_id]
      end
      @new_sign.save
      @message = "Custom Sign Created"
    else
      #load, modify and save existing custom sign
      @current_sign = CustomSign.find params[:id]
      @current_sign.custom_data = params[:custom_data]
      @current_sign.save
      @message = "Custom Sign Saved"
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_sign
    @sign = CustomSign.find params[:id]
    @sign.destroy
  end

  def load_sign_ajax
    @custom_sign = CustomSign.find params[:saved_sign_id]
    respond_to do |format|
      format.js
    end
  end

  def load_sign_list
    @custom_signs = CustomSign.all(:conditions => ["spree_user_id = ?", params[:user_id]])
    render :layout => "modal"
  end

  def save_dialog
    render :layout => "modal"
  end

  def edit_sign
    render :layout => "edit_sign"
  end

end