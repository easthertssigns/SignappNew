Refinery::User.class_eval do
  def get_saved_signs
    SignData.where("account_id = ?", id)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = Refinery::Memberships::Member.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = Refinery::Memberships::Member.create(first_name: auth.extra.raw_info.first_name,
                                                  last_name: auth.extra.raw_info.last_name,
                                                  username: auth.info.email,
                                                  membership_level: "Refinery::Memberships::Member",
                                                  enabled: true,
                                                  rejected: "NO",
                                                  member_until: Time.now + 10.years,
                                                  provider: auth.provider,
                                                  uid: auth.uid,
                                                  email: auth.info.email,
                                                  password: Devise.friendly_token[0, 20]
      )
      user.accept!
      user.enable!
      user.extend!
      user.reload
    end
    user
  end
end

