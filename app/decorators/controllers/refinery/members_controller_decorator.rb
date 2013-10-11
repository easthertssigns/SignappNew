Refinery::Memberships::MembersController.class_eval do

  def welcome
    @current_refinery_user = current_refinery_user
  end

  #def order_history
  #  @current_refinery_user = current_refinery_user
  #  @orders = Spree::Orders.where(:user_id => @current_refinery_user.id)
  #end

  def orders
    @current_refinery_user = current_refinery_user
  end

  def create
    @member = Refinery::Memberships::Member.new(params[:member])

    if @member.save

      @member.accept!
      @member.enable!
      @member.extend!
      @member.reload

      #Refinery::Memberships::MembershipMailer::deliver_member_created(@member)
      sign_in(Refinery::Memberships::Member.find(@member.id))
      redirect_to session[:return_to] || welcome_members_path
    else
      @member.errors.delete(:username) # this is set to email
      flash[:error] = "#{@member.errors.first[0]} #{@member.errors.first[1]}"
      render :action => :login
    end
  end

end