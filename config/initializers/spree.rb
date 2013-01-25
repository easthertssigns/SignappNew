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
  # config.site_name = "Spree Demo Site"
  config.allow_locale_switching = false

  config.default_locale = 'en'

  config.use_s3 = true
  config.s3_bucket = 'signapp-dev'
  config.s3_access_key = 'AKIAJHMMYZ5GOYGV6OHQ'
  config.s3_secret = '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'
end

Spree.user_class = "Spree::LegacyUser"
