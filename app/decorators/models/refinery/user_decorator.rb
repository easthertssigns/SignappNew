Refinery::User.class_eval do
  #has_many :followed_authors
  #has_many :authors, :foreign_key => "user_id"

  if self.respond_to?(:devise)
    devise :database_authenticatable, :registerable, :recoverable, :rememberable,
           :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook],
           :authentication_keys => [:login]
  end

  attr_accessible :provider, :uid

  def mail_data
    allowed_attributes = %w(email first_name last_name title organization
          street_address city province postal_code phone fax website)
    d = attributes.to_hash
    d.reject! { |k, v| !allowed_attributes.include?(k.to_s) }
    #d[:activation_url] = Rails.application.routes.url_helpers.activate_members_url(:confirmation_token => self.confirmation_token) if Refinery::Setting::find_or_set('memberships_confirmation', 'admin') == 'email'
    #d[:member_until] = ::I18n.localize(member_until.to_date, :format => :long) if member_until && Refinery::Setting::find_or_set('memberships_timed_accounts', true)
    d
  end
end