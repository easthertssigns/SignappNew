module Refinery
  module Memberships
    class Member < Refinery::User
      devise :confirmable

      acts_as_indexed :fields => [:first_name, :last_name]

      has_many :plugins, :class_name => "UserPlugin", :foreign_key => "user_id", :order => "position ASC", :dependent => :destroy

      has_many :spree_orders, :class_name => 'Spree::Order', :foreign_key => "user_id", :order => "created_at ASC"

      has_and_belongs_to_many :spree_roles, :join_table => 'spree_roles_users', :class_name => Spree::Role.to_s, :foreign_key => "user_id"

      #has_many :spree_roles, :class_name => 'Spree::Role', :foreign_key => "user_id"

      validates :first_name, :last_name, :presence => true
      validates_acceptance_of :member_terms_and_conditions

      attr_accessible :membership_level, :first_name, :last_name, :title, :organization, :provider, :uid, :rejected, :member_until,
                      :street_address, :city, :province, :postal_code, :phone, :fax, :website,
                      :enabled, :add_to_member_until, :role_ids, :biography, :gender, :photo_attributes, :terms_and_conditions, :plugins, :username

      self.inheritance_column = :membership_level

      after_create :set_default_enabled
      after_create :set_default_rejected
      after_create :set_default_roles

      before_save :ensure_member_role       # always needs to be a Member or can't sign in, see is_member?

      def to_param
        id
      end

      def self.per_page
        12
      end

      def full_name
        "#{self.first_name} #{last_name}"
      end

      def add_to_member_until
        @add_to_member_until || ''
      end

      def add_to_member_until=(n)
        @add_to_member_until = n
        extend_membership n.to_i if n && n.to_i > 0
      end

      def email=(e)
        write_attribute(:email, e)
        write_attribute(:username, e)
      end

      def add_role(title)
        raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(::Refinery::Role)
        roles << ::Refinery::Role[title] unless has_role?(title)
      end

      def has_role?(title)
        raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(::Refinery::Role)
        roles.any?{|r| r.title == title.to_s.camelize}
      end

      def enabled=(e)
        write_attribute(:enabled, e)
        e = read_attribute(:enabled)
        e ? ensure_member_role : remove_member_role
        e
      end

      def mail_data
        allowed_attributes = %w(email first_name last_name title organization
        street_address city province postal_code phone fax website)
        d = attributes.to_hash
        d.reject!{|k,v| !allowed_attributes.include?(k.to_s)}
        d[:activation_url] = Rails.application.routes.url_helpers.activate_members_url(:confirmation_token => self.confirmation_token) if Refinery::Setting::find_or_set('memberships_confirmation', 'admin') == 'email'
        d[:member_until] = ::I18n.localize(member_until.to_date, :format => :long) if member_until && Refinery::Setting::find_or_set('memberships_timed_accounts', true)
        d
      end

      def plugins=(plugin_names)
        if persisted? # don't add plugins when the user_id is nil.
          UserPlugin.delete_all(:user_id => id)

          plugin_names.each_with_index do |plugin_name, index|
            plugins.create(:name => plugin_name, :position => index) if plugin_name.is_a?(String)
          end
        end
      end

      def authorized_plugins
        plugins.collect(&:name) | ::Refinery::Plugins.always_allowed.names
      end

      def is_member?
        has_role?(:member)
      end

      def active_for_authentication?
        a = self.enabled && self.is_member?

        if Refinery::Setting::find_or_set('memberships_timed_accounts', true)
          if member_until.nil?
            a = false
          else
            a = a && member_until.future?
          end
        end
        a
      end

      alias :active? :active_for_authentication?

      def confirmed?
        Refinery::Setting::find_or_set('memberships_confirmation', 'admin') != 'email' || !!confirmed_at
      end

      def unconfirmed?
        !self.confirmed?
      end

      def seen?
        self.seen == true
      end

      def unseen?
        !self.seen?
      end

      def enabled?
        self.enabled == true
      end

      def disabled?
        !self.enabled?
      end

      def rejected?
        self.rejected == 'YES'
      end

      def accepted?
        self.rejected == 'NO'
      end

      def undecided?
        self.rejected == 'UNDECIDED'
      end

      def lapsed?
        if Refinery::Setting::find_or_set('memberships_timed_accounts', true)
          if member_until.nil?
            false
          else
            member_until.past?
          end
        else
          false
        end
      end

      def almost_lapsed?
        !lapsed? && member_until.present? && (member_until-7.days).past?
      end

      def never_member?
        !Refinery::Setting::find_or_set('memberships_timed_accounts', true) || member_until.nil?
      end

      def confirm!
        unless_confirmed do
          self.enabled = true
        end
        super
      end

      def seen!
        self.update_attribute(:seen, true)
      end

      def enable!
        self.enabled = true
        save
      end

      def disable!
        self.enabled = false
        save
      end

      def extend!
        extend_membership if Refinery::Setting::find_or_set('memberships_timed_accounts', true)
      end

      def reject!
        update_attribute(:rejected, 'YES')
      end

      def accept!
        update_attribute(:rejected, 'NO')
        enable!
      end

      def inactive_message
        self.seen? ? ::I18n.translate('devise.failure.locked') : super
      end

      # devise confirmable

      # override... the token was sent with the welcome email
      def send_confirmation_instructions
        generate_confirmation_token! if self.confirmation_token.nil?
      end

      # resend the welcome email
      def resend_confirmation_token
        unless_confirmed do
          generate_confirmation_token! if self.confirmation_token.nil?
          member_email('member_created', member).deliver if Refinery::Setting.find_or_set("memberships_deliver_mail_on_member_created", true)
        end
      end

      protected

      def confirmation_required?
        Refinery::Setting::find_or_set('memberships_confirmation', 'admin') == 'email' && !confirmed?
      end

      def set_default_enabled
        update_attribute(:enabled, Refinery::Setting::find_or_set('memberships_confirmation', 'admin') == 'no')
      end

      def set_default_rejected
        update_attribute(:rejected, 'NO') if Refinery::Setting::find_or_set('memberships_confirmation', 'admin') != 'admin'
      end

      def set_default_roles

        if roles = Refinery::Setting.find_or_set('memberships_default_roles', [])
          self.roles = Refinery::Role.where(:title => roles)
          save
        end

      end

      def extend_membership(amount = 1)

        step = Refinery::Setting.find_or_set("memberships_default_account_validity", 12) # months
        amount = amount*step
        if amount && amount > 0
          self.member_until = member_until.nil? || lapsed? ? amount.month.from_now : member_until + amount.month
          save
        end
      end

      def ensure_member_role
        self.add_role(:member) unless has_role?(:member)
      end

      def remove_member_role
        self.roles.delete(Refinery::Role[:member]) if has_role?(:member)
      end
    end
  end
end