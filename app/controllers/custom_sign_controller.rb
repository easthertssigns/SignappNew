class CustomSignController < ApplicationController
  def save_sign
    @message = ""
    if params[:id].nil?
      #create new custom sign
      @new_sign = SignData.new
      @new_sign.base_product_id = params[:product_id]

      @new_sign.height = params[:height].to_i
      @new_sign.width = params[:width].to_i

      @new_sign.shape_id = params[:shapeSelect].to_i

      @new_sign.price = params[:calculated_price].to_f

      @new_sign.account_id = params[:spree_user_id]
      @new_sign.sign_data = params[:custom_data]
      unless params[:name].nil?
        @new_sign.name = params[:name]
      end

      @new_sign.save
      @message = "Custom Sign Created"
    else
      #load, modify and save existing custom sign
      #may have to save other details as well. Height and width aren't changeable as far as I understand, put price certainly is
      @current_sign = SignData.find params[:id]
      @current_sign.price = params[:calculated_price].to_f
      @current_sign.sign_data = params[:sign_data]
      @current_sign.name = params[:name]
      @current_sign.description = params[:description]
      @current_sign.account_id = params[:account_id]
      @current_sign.save
      @message = "Custom Sign Saved"
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_sign
    @sign = SignData.find params[:id]
    @sign.destroy
  end

  def delete_saved_sign
    @sign = SignData.first(:conditions => ["id = ? AND account_id = ? ", params[:custom_sign_id], current_refinery_user.id.to_i])
    unless @sign.nil?
      @sign.deleted_by_user = true
      @sign.save
    end
    redirect_to "/members/profile"
  end

  def load_sign_ajax
    @custom_sign = SignData.find params[:saved_sign_id]
    respond_to do |format|
      format.js
    end
  end

  def load_sign_list
    @custom_signs = SignData.all(:conditions => ["account_id = ?", params[:user_id]])
    render :layout => "modal"
  end

  def save_dialog
    render :layout => "modal"
  end

  def edit_sign
    @sign_data = SignData.find params[:id]
    render :layout => "edit_sign"
  end

  def new_custom_sign
    # Create new sign_data record
    @sign_data = SignData.new()
    @sign_data.spree_product_id = params[:product_id]

    @sign_data.height = params[:height].to_i
    @sign_data.width = params[:width].to_i

    @sign_data.shape_id = params[:shapeSelect].to_i

    @sign_data.price = params[:calculated_price].to_f

    if session[:account_id]
      @sign_data.account_id = params[:account_id]
    end

    @sign_data.save
    render "edit_sign"
  end

  def calculate_sign_base_price
    #raise "got this far"
    height = (params[:height].to_f)/10
    width = (params[:width].to_f)/10
    total_sign_area = width * height

    material = Spree::Product.find params[:product_id]
    base_price = material.price.to_f
    if !material.small_size_threshold.nil? && !material.small_size_price.nil?
      if total_sign_area < material.small_size_threshold
        base_price = material.small_size_price.to_f
      end
    end
    if !material.large_size_threshold.nil? && !material.large_size_price.nil?
      if total_sign_area > material.large_size_threshold
        base_price = material.large_size_price.to_f
      end
    end


    calculated_price = (total_sign_area * base_price).to_f

    render :json => { :result => calculated_price, :base_price => base_price }
  end

end