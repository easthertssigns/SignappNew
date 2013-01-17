class AccountSessionsController < Devise::SessionsController

  prepend_before_filter :require_no_authentication, :only => [:new, :create]
  # prepend_before_filter :allow_params_authentication!, :only => :create

  # GET /resource/sign_in
  def new
    resource = build_resource
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    # raise auth_options.to_yaml
    logger.info "### Called Create"
    # raise auth_options.to_yaml
    resource = warden.authenticate!(auth_options)
    # raise resource.to_yaml
    logger.info "### warden.authenticate"
    # raise "yo mama"
    raise "here"
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_customer_account_in(resource_name, resource)
    respond_with resource, :location => "/account/overview"
    # raise "yo mama"
  end

  # DELETE /resource/sign_out
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        method = "to_#{request_format}"
        text = {}.respond_to?(method) ? {}.send(method) : ""
        render :text => text, :status => :ok
      end
    end
  end

  protected

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    {:methods => methods, :only => [:password]}
  end

  def auth_options
    {:scope => resource_name, :recall => "#{controller_path}#new"}
  end

  def sign_customer_account_in(resource_or_scope, *args)
    # raise "getting here"
    options = args.extract_options!
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource = args.last || resource_or_scope

    expire_session_data_after_sign_in!

    if options[:bypass]
      warden.session_serializer.store(resource, scope)
    elsif warden.user(scope) == resource && !options.delete(:force)
      # Do nothing. User already signed in and we are not forcing it.
      true
    else
      # warden.set_user(resource, options.merge!(:scope => scope))
    end
  end

end
