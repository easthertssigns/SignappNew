module Spree
  # Handles checkout logic.  This is somewhat contrary to standard REST convention since there is not actually a
  # Checkout object.  There's enough distinct logic specific to checkout which has nothing to do with updating an
  # order that this approach is waranted.
  class CheckoutController < BaseController
    ssl_required


    before_filter :load_order
    before_filter :ensure_valid_state
    before_filter :associate_user
    rescue_from Spree::Core::GatewayError, :with => :rescue_from_spree_gateway_error

    before_filter :mailing_list_checked, :only => [:update]

    respond_to :html

    # Updates the order and advances to the next state (when possible.)
    def update
      if @order.update_attributes(object_params)
        fire_event('spree.checkout.update')

        if @order.next
          state_callback(:after)
        else
          flash[:error] = t(:payment_processing_failed)
          respond_with(@order, :location => checkout_state_path(@order.state))
          return
        end

        if @order.state == "complete" || @order.completed?
          flash.notice = t(:order_processed_successfully)
          flash[:commerce_tracking] = "nothing special"
          respond_with(@order, :location => completion_route)
        else
          respond_with(@order, :location => checkout_state_path(@order.state))
        end
      else
        respond_with(@order) { |format| format.html { render :edit } }
      end
    end


    private
    def ensure_valid_state
      unless skip_state_validation?
        if (params[:state] && !@order.checkout_steps.include?(params[:state])) ||
            (!params[:state] && !@order.checkout_steps.include?(@order.state))
          @order.state = 'cart'
          redirect_to checkout_state_path(@order.checkout_steps.first)
        end
      end
    end

    # Should be overriden if you have areas of your checkout that don't match
    # up to a step within checkout_steps, such as a registration step
    def skip_state_validation?
      false
    end

    def load_order
      @order = current_order
      redirect_to cart_path and return unless @order and @order.checkout_allowed?
      raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
      redirect_to cart_path and return if @order.completed?
      @order.state = params[:state] if params[:state]
      state_callback(:before)
    end

    # Provides a route to redirect after order completion
    def completion_route
      order_path(@order)
    end


    def mailing_list_checked
      if params[:state] == "address" && params[:action] == "update"
        if params[:mailing_list_email] == "yes"
          # add to mailing list
          if MailingList.where(:email => @order.email.downcase).count == 0
            # add to mailing list
            result = "You have been added to the mailing list"
            MailingList.create(:email => @order.email.downcase, :name => @order.full_name)
          end
        end
      end
    end

    def object_params
      # For payment step, filter order parameters to produce the expected nested attributes for a single payment and its source, discarding attributes for payment methods other than the one selected
      if @order.payment?
        if params[:payment_source].present? && source_params = params.delete(:payment_source)[params[:order][:payments_attributes].first[:payment_method_id].underscore]
          params[:order][:payments_attributes].first[:source_attributes] = source_params
        end
        if (params[:order][:payments_attributes])
          params[:order][:payments_attributes].first[:amount] = @order.total
        end
      end
      params[:order]
    end

    def raise_insufficient_quantity
      flash[:error] = t(:spree_inventory_error_flash_for_insufficient_quantity)
      redirect_to cart_path
    end

    def state_callback(before_or_after = :before)
      method_name = :"#{before_or_after}_#{@order.state}"
      send(method_name) if respond_to?(method_name, true)
    end

    #def before_address
    #  @order.bill_address ||= Address.default
    #  @order.ship_address ||= Address.default
    #end

    def before_address
      if @order.bill_address.blank?
        @order.bill_address ||= Address.default
      end

      if @order.ship_address.blank?
        @order.ship_address ||= Address.default
      end

      if current_refinery_user


        # populate address details
        # name
        unless current_refinery_user.first_name.blank? && !@order.bill_address.firstname.blank?
          @order.bill_address.firstname = current_refinery_user.first_name
        end

        unless current_refinery_user.last_name.blank? && !@order.bill_address.firstname.blank?
          @order.bill_address.lastname = current_refinery_user.last_name
        end

        # email
        unless current_refinery_user.email.blank? && !@order.email.blank?
          @order.email = current_refinery_user.email
        end

        # billing address

        if @order.bill_address.address1.blank? && !current_refinery_user.street_address.blank?
          # raise "sdsdf"
          @order.bill_address.address1 = current_refinery_user.street_address
        end

        if @order.bill_address.address2.blank? && !current_refinery_user.organization.blank?
          # raise "sdsdf"
          @order.bill_address.address2 = current_refinery_user.organization
        end

        if @order.bill_address.city.blank? && !current_refinery_user.city.blank?

          @order.bill_address.city = current_refinery_user.city
        end

        if @order.bill_address.state_name.blank? && !current_refinery_user.province.blank?
          @order.bill_address.state_name = current_refinery_user.province
        end

        if @order.bill_address.zipcode.blank? && !current_refinery_user.postal_code.blank?
          @order.bill_address.zipcode = current_refinery_user.postal_code
        end

        #if
        #  @order.ship_address.firstname = current_refinery_user.ship_address.firstname
        #  @order.ship_address.lastname = current_refinery_user.ship_address.lastname
        #  @order.ship_address.address1 = current_refinery_user.ship_address.address1
        #  @order.ship_address.address2 = current_refinery_user.ship_address.address2
        #  @order.ship_address.city = current_refinery_user.ship_address.city
        #  @order.ship_address.zipcode = current_refinery_user.ship_address.zipcode
        #  @order.ship_address.country_id = current_refinery_user.ship_address.country_id
        #  @order.ship_address.state_id = current_refinery_user.ship_address.state_id
        #  @order.ship_address.country = current_refinery_user.ship_address.country
        #  @order.ship_address.state = current_refinery_user.ship_address.state
        #  @order.ship_address.phone = current_refinery_user.ship_address.phone
        #  @order.ship_address.state_name = current_refinery_user.ship_address.state_name
        #  @order.ship_address.company = current_refinery_user.ship_address.company
        #  @order.ship_address.alternative_phone = current_refinery_user.ship_address.alternative_phone
        #elsif @order.ship_address.blank?
        #
        #
        #
        #  unless current_refinery_user.last_name.blank?
        #    @order.ship_address.lastname = current_refinery_user.last_name
        #  end
        #
        #  unless current_refinery_user.phone.blank?
        #    @order.ship_address.phone = current_refinery_user.phone
        #  end
        #end

        # populate address details
        #if @order.bill_address.blank? && !current_refinery_user.bill_address.blank?
        #
        #  @order.bill_address.firstname = current_refinery_user.bill_address.firstname
        #  @order.bill_address.lastname = current_refinery_user.bill_address.lastname
        #  @order.bill_address.address1 = current_refinery_user.bill_address.address1
        #  @order.bill_address.address2 = current_refinery_user.bill_address.address2
        #  @order.bill_address.city = current_refinery_user.bill_address.city
        #  @order.bill_address.zipcode = current_refinery_user.bill_address.zipcode
        #  @order.bill_address.country_id = current_refinery_user.bill_address.country_id
        #  @order.bill_address.state_id = current_refinery_user.bill_address.state_id
        #  @order.bill_address.country = current_refinery_user.bill_address.country
        #  @order.bill_address.state = current_refinery_user.bill_address.state
        #  @order.bill_address.phone = current_refinery_user.bill_address.phone
        #  @order.bill_address.state_name = current_refinery_user.bill_address.state_name
        #  @order.bill_address.company = current_refinery_user.bill_address.company
        #  @order.bill_address.alternative_phone = current_refinery_user.bill_address.alternative_phone
        #elsif @order.bill_address.blank?
        #
        #  unless current_refinery_user.first_name.blank?
        #    @order.bill_address.firstname = current_refinery_user.first_name
        #  end
        #
        #  unless current_refinery_user.last_name.blank?
        #    @order.bill_address.lastname = current_refinery_user.last_name
        #  end
        #
        #  unless current_refinery_user.phone.blank?
        #    @order.bill_address.phone = current_refinery_user.phone
        #  end
        #end
      end
    end

    def before_delivery
      return if params[:order].present?
      @order.shipping_method ||= (@order.rate_hash.first && @order.rate_hash.first[:shipping_method])
    end

    def before_payment
      current_order.payments.destroy_all if request.put?
    end

    def after_complete
      session[:order_id] = nil
    end

    def rescue_from_spree_gateway_error
      flash[:error] = t(:spree_gateway_error_flash_for_checkout)
      render :edit
    end
  end
end
