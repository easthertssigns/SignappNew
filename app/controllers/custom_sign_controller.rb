class CustomSignController < ApplicationController
  def save_sign
    @message = ""
    if params[:id].nil?

      if params[:base64png]
        # create png from string

        File.open('testbase64.png', 'wb') do |f|
          f.write(Base64.decode64(params[:base64png]))
        end

        raise "file saved!"
      end

      #create new custom sign
      @new_sign = SignData.new
      @new_sign.spree_product_id = params[:product_id]
      @new_sign.height = params[:height].to_i
      @new_sign.width = params[:width].to_i
      @new_sign.shape_id = params[:shapeSelect].to_i
      @new_sign.price = params[:calculated_price].to_f
      @new_sign.account_id = params[:account_id]
      @new_sign.sign_data = params[:custom_data]
      @new_sign.deleted_by_admin = false
      @new_sign.deleted_by_user = false

      unless params[:name].nil?
        @new_sign.name = params[:name]
      end

      @new_sign.save
      #raise "sign saved"
      @message = "Custom Sign Created"
    else

      @current_sign = SignData.find params[:id]

      if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id

        if params[:base64png]
          # create png from string

          str = params[:base64png].sub("data:image/png;base64,", "")

          File.open(Rails.root + ('tmp/sign_thumb_' + params[:id] + ".png"), 'wb') do |f|
            f.write(Base64.decode64(str))
          end

          @current_sign.image =

              f = File.new(Rails.root + ('tmp/sign_thumb_' + params[:id] + ".png"))
          @current_sign.image = f
          f.close

        end


        #load, modify and save existing custom sign
        #may have to save other details as well. Height and width aren't changeable as far as I understand, put price certainly is

        @current_sign.price = params[:calculated_price].to_f
        @current_sign.sign_data = params[:sign_data]
        #raise params[:svg_data]
        @current_sign.svg_data = params[:svg_data]
        @current_sign.name = params[:name]
        @current_sign.description = params[:description]
        @current_sign.account_id = params[:account_id]

        @current_sign.deleted_by_admin = false
        @current_sign.deleted_by_user = false

        @current_sign.save
        #svg_data = params[:svg_data]
        ## Saving sign as thumb is locking up the server
        #File.open("#{Rails.root}/tmp/" + params[:id].to_s + ".svg", 'w') {|f| f.write(svg_data)}
        ##@current_sign.image = File.open("#{Rails.root}/tmp/" + params[:id].to_s + ".svg", 'r')
        ##@current_sign.save
        ##raise params.to_yaml + "SignData ID : " + params[:id]
        @message = "Custom Sign Saved"
      else
        raise "Access Denied"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  #def write_file
  #  sign_data = SignData.find 1
  #  sign_data_id = 666
  #  svg_data = '<?xml version="1.0" standalone="no" ?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="611.6778523489933" height="434" xml:space="preserve"><desc>Created with Fabric.js 0.8.41</desc><g transform="translate(336.85 215) scale(4.21 4.21)"><path width="100" height="66.39" d="M 21.117 3.593 c 0 0 -2.713 -4.171 -4.833 -3.525 c -2.333 0.71 -1.137 5.351 -1.137 5.351 c -4.348 0.754 -6.248 7.257 -14.025 7.775 c -2.854 0.19 -0.239 7.377 7.543 8.941 c 10.818 2.175 18.603 7.619 19.69 11.021 c 0.651 2.038 6.502 22.364 4.017 26.057 c 0 0 -4.677 1.088 -2.448 5.443 c 0.586 1.146 10.262 0.785 10.852 -1.378 c 0.233 -0.857 2.553 -8.252 2.553 -8.252 c 2.104 2.418 2.031 5.195 0.319 7.213 c -1.397 1.646 1.72 4.905 6.135 3.477 c 5.298 -1.714 5.565 -16.115 5.565 -21.814 c 0 0 9.972 3.696 20.335 1.877 c 0 0 1.292 12.526 0.705 13.335 c -0.607 0.837 -4.277 2.695 -1.861 5.675 c 1.661 2.049 6.268 1.562 7.709 0.28 c 3.077 -2.736 6.441 -15.158 6.441 -15.158 s 3.025 9.582 2.511 10.094 c -3.21 3.188 -1.162 6.312 2.101 6.312 c 0 0 5.479 0.927 6.712 -4.01 c 0 0 -1.389 -25.691 -0.437 -30.987 c 2.23 -12.41 -23.119 -18.168 -26.654 -18.509 c -6.048 -0.584 -20.316 -0.616 -22.051 -1.197 c -1.59 -0.533 -5.487 -2.761 -8.175 -3.272 c -2.176 -0.414 -5.349 0.502 -7.098 0.202 c -1.994 -0.342 -7.55 -2.912 -7.55 -2.912 s 0.271 -3.868 -2.288 -4.555 C 24.033 0.615 21.117 3.593 21.117 3.593 z" style="stroke: none; stroke-width: 1; fill: #804000; opacity: 1;" transform="translate(-50 -33.195)" /></g></svg>'
  #  File.open("#{Rails.root}/tmp/" + sign_data_id.to_s + ".svg", 'w') {|f| f.write(svg_data)}
  #  sign_data.image = File.open("#{Rails.root}/tmp/" + sign_data_id.to_s + ".svg", 'r')
  #  sign_data.save
  #  #f = File.new(sign_data_id + ".svg")
  #  #f.write(svg_content)
  #end

  def delete_sign
    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id
      @sign = SignData.find params[:id]
      @sign.destroy
    else
      raise "Access Denied"
    end
  end

  def get_sign_svg

    @sign = SignData.find params[:id]

    # check user or admin
    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id

      if @sign.svg_data
        respond_to do |format|
          format.svg {
            render :inline => @sign.get_local_svg
          }
        end
      end
    else
      raise "Access Denied"
    end
  end

  def get_sign
    @sign = SignData.find params[:id]

    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id
      if @sign.svg_data
        respond_to do |format|
          format.svg {
            render :inline => @sign.get_local_svg
          }
        end
      end
    else
      render :text => ""
    end
  end

  def get_sign_shape_svg
    @sign_shape = SignBaseShape.find params[:id]

    headers["Content-Type"] = "image/svg+xml"

    respond_to do |format|
      format.svg {
        render :inline => @sign_shape.get_svg_file
      }
    end

  end

  def get_custom_shape_svg
    @sign_graphic = SignGraphic.find params[:id]

    headers["Content-Type"] = "image/svg+xml"

    respond_to do |format|
      format.svg {
        render :inline => @sign_graphic.svg_file.to_file.read
      }
    end
  end

  def customise_sign
    # get sign from database


    # duplicate to new ID and redirect to edit sign

    sign_data = SignData.find params[:id]

    # check that this is available to capture

    if sign_data.product.is_product != false

      new_sign_data = SignData.new
      new_sign_data.account_id = spree_current_user ? spree_current_user.id : nil #this wants fixing at some point
      new_sign_data.description = sign_data.description
      new_sign_data.height = sign_data.height
      new_sign_data.name = sign_data.name
      new_sign_data.price = sign_data.price
      new_sign_data.shape_id = sign_data.shape_id
      new_sign_data.sign_data = sign_data.sign_data
      new_sign_data.spree_product_id = sign_data.spree_product_id
      new_sign_data.width = sign_data.width
      new_sign_data.image = open(sign_data.image.url)
      new_sign_data.svg_data = sign_data.svg_data
      new_sign_data.show_as_product = false
      new_sign_data.spree_variant_id = sign_data.spree_variant_id

      new_sign_data.save

      # redirect to edit in sign editor
      redirect_to "/custom_sign/edit_sign?id=" + new_sign_data.id.to_s
    else
      raise "Not a product (#{sign_data.product.id})"
    end

  end

  def delete_saved_sign
    @sign = SignData.first(:conditions => ["id = ? AND account_id = ? ", params[:custom_sign_id], current_refinery_user.id.to_i])
    unless @sign.nil?
      @sign.deleted_by_user = true
      @sign.save
    end
    redirect_to "/members/welcome"
  end

  def load_sign_ajax
    @custom_sign = SignData.find params[:saved_sign_id]

    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id
      respond_to do |format|
        format.js
      end
    else
      raise "Access Denied"
    end
  end

  def reset_sign_data_ajax
    @sign_data = SignData.find params[:id]
    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id
      render :json => {:sign_data => @sign_data.sign_data, :price => @sign_data.price}
    end
  end


  def get_graphic_url_ajax
    sign_graphic = SignGraphic.find params[:id]
    image_path = sign_graphic.svg_file.url(:original)
    render :json => {:image_path => image_path}
  end

  def load_sign_list
    @custom_signs = SignData.all(:conditions => ["account_id = ?", params[:user_id]])
    render :layout => "modal"
  end

  def save_dialog
    render :layout => "modal"
  end

  def edit_sign
    if spree_current_user.has_role?(:superuser).to_s || @sign.account_id == spree_current_user.id

      @sign_data = SignData.find params[:id]
      render :layout => "edit_sign"
    end
  end

  def edit_sign_from_product
    @old_sign_data = SignData.find params[:id]
    @sign_data = SignData.new
    if current_refinery_user
      @sign_data.account_id = current_refinery_user.id.to_i
    end
    @sign_data.description = @old_sign_data.description
    @sign_data.height = @old_sign_data.height
    @sign_data.name = @old_sign_data.name
    @sign_data.price = @old_sign_data.price
    @sign_data.shape_id = @old_sign_data.shape_id
    @sign_data.sign_data = @old_sign_data.sign_data
    @sign_data.spree_product_id = @old_sign_data.spree_product_id
    @sign_data.width = @old_sign_data.width
    @sign_data.based_on = @old_sign_data.id
    @sign_data.save
    redirect_to "/custom_sign/edit_sign?id=" + @sign_data.id.to_s
  end

  def get_sign_shape_sizes #This is the controller action called by your ajax
    sign_shape = SignBaseShape.find(params[:id])
    product = Spree::Product.find(params[:product_id])

    # sign sizes are in mm
    # variants are in CM

    @sign_sizes = sign_shape.sign_sizes.where("width > ? AND width < ? AND height > ? AND height < ?", product.master.minimum_width * 10, product.master.maximum_width * 10, product.master.minimum_height * 10, product.master.maximum_height * 10)
    @custom_sign_size = sign_shape.custom_size
    render :partial => "size_select"
  end

  def new_custom_sign
    # Create new sign_data record
    @sign_data = SignData.new()
    @sign_data.spree_product_id = params[:product_id]
    @sign_data.spree_variant_id = params[:variant_id]

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

    # CM sq
    total_sign_area = width * height

    width_to_small = false
    width_to_large = false
    height_to_small = false
    height_to_large = false

    material = Spree::Product.find params[:product_id]

    # checks im minimum and maximum
    if height > material.master.maximum_height
      height_to_large = true
    elsif height < material.master.minimum_height
      height_to_small = true
    end

    if width > material.master.maximum_width
      width_to_large = true
    elsif width < material.master.minimum_width
      width_to_small = true
    end

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

    render :json => {
        :result => calculated_price,
        :base_price => base_price,
        :width_to_small => width_to_small,
        :width_to_large => width_to_large,
        :height_to_small => height_to_small,
        :height_to_large => height_to_large
    }
  end

end