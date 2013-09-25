module Refinery
  module Memberships
    class MembersController < ::ApplicationController

      # Protect these actions behind member login - do we need to check out not signing up when signed in?
      before_filter :redirect?, :except => [:new, :create, :login, :index, :welcome, :activate, :password, :password_reset]

      #before_filter :find_page, :except => [:activate, :login]

      # GET /member/:id
      def profile
        @member = current_refinery_user
        @saved_signs = SignData.all(:conditions => ["account_id = ?", current_refinery_user.id.to_s])
        @orders = Spree::Order.all(:conditions => ["user_id = ?", current_refinery_user.id.to_s])
      end

      def overview
        @member = current_refinery_user
        @saved_signs = SignData.all(:conditions => ["account_id = ?", current_refinery_user.id.to_s])
        @orders = Spree::Order.all(:conditions => ["user_id = ?", current_refinery_user.id.to_s])
      end

      def new
        @member = Member.new
      end

      def password
        #raise "dfgdfg"

        #raise                    params[:refinery_user]
        if params[:member].present? and Refinery::Memberships::Member.where(:email => params[:member][:login]).count > 0

          @user = Refinery::Memberships::Member.where(:email => params[:member][:login]).first
          # Call devise reset function.
          @user.send(:generate_reset_password_token!)

          #TestMailer.welcome_email.deliver
          #MembershipMailer::deliver_member_accepted(user)
          Refinery::Memberships::MembershipMailer.deliver_member_password_reset(@user)

          flash[:info] = "Password Reset Email Send"
          redirect_to "/members/login",
                      :notice => t('email_reset_sent', :scope => 'refinery.users.forgot')
        else
          if params[:member][:login].blank?
            flash[:error] = t('blank_email', :scope => 'refinery.users.forgot')
          else
            flash[:error] = t('email_not_associated_with_account_html', :email => ERB::Util.html_escape(params[:member][:login]), :scope => 'refinery.users.forgot').html_safe
          end
          redirect_to "/members/login"
        end
      end

      def password_reset
        #raise "dfgdfdfg"

        # get member
        @member = Refinery::Memberships::Member.reset_password_by_token({:reset_password_token => params[:token]})

        if @member.nil? or @member.id.nil?
          flash[:error] = "Invalid Token, not recognised."
          redirect_to "/members/login"
        else
          sign_in(Refinery::Memberships::Member.find(@member.id))
          # sign in, and tell them to go to thair profile to edit the password
          flash[:notice] = "please update your password"
          redirect_to "/members/edit"
        end
      end


      # GET /members/:id/edit
      def edit
        @member = current_refinery_user
      end

      # PUT /members/:id
      def update
        @member = current_refinery_user

        user_id = @member.id

        if params[:member][:password].blank? and params[:member][:password_confirmation].blank?
          params[:member].delete(:password)
          params[:member].delete(:password_confirmation)
        end

        if @member.update_attributes(params[:member])
          flash[:notice] = t('successful', :scope => 'members.update', :email => @member.email)
          #MembershipMailer.deliver_member_profile_updated(@member).deliver unless @member.has_role?(:admin)
          #sign_in(Refinery::Memberships::Member.find(@member.id))
          redirect_to "/members/welcome"
        else
          render :action => 'edit'
        end
      end

      def create
        @member = Member.new(params[:member])
        if @member.save
          #MembershipMailer::deliver_member_created(@member)
          redirect_to welcome_members_path
        else
          @member.errors.delete(:username) # this is set to email
          render :action => :new
        end
      end

      def searching?
        params[:search].present?
      end

      def login
        find_page('/members/login')
      end

      def index
        @member = current_refinery_user
        @saved_signs = SignData.all(:conditions => ["account_id = ?", current_refinery_user.id.to_s])
        @orders = Spree::Order.all(:conditions => ["user_id = ?", current_refinery_user.id.to_s])
        render :action => 'index'
      end

      def welcome
        @member = current_refinery_user
        @saved_signs = SignData.all(:conditions => ["account_id = ?", current_refinery_user.id.to_s])
        @orders = Spree::Order.all(:conditions => ["user_id = ?", current_refinery_user.id.to_s])
        render :action => 'welcome'
      end

      def activate
        find_page('/members/activate')
        resource = Member.confirm_by_token(params[:confirmation_token])

        if resource.errors.present?
          error_404
        end
      end

      private

      protected

      def redirect?
        if current_refinery_user.nil?
          #redirect_to new_user_session_path
          redirect_to "/members/login"
        end
      end

      def find_page(uri = nil)
        uri = uri ? uri : request.fullpath
        uri.gsub!(/\?.*/, '')
        @page = Page.find_by_link_url(uri, :include => [:parts])
      end
    end
  end
end
