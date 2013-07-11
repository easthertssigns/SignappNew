# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  config.site_name = "SignApp"
  config.use_s3 = true
  config.s3_bucket = 'signapp-production'
  config.s3_access_key = "AKIAJSZTTNHJIAPK672A"
  config.s3_secret = "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"
  config.attachment_url = ":s3_eu_url"
  config.s3_host_alias = "s3-eu-west-1.amazonaws.com"
end

#Spree.user_class = "Spree::LegacyUser"
Spree.user_class = "Refinery::Memberships::Member"


Paperclip.interpolates(:s3_eu_url) do |att, style|
  "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end

