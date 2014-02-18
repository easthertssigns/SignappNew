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
  config[:address_requires_state] = false
  config.default_country_id = 213
  config.address_requires_state = false
  config.logo = "/assets/header-logo.png"
  config.searcher_class=(Spree::Core::Search::Modified)
end

#Spree.user_class = "Spree::LegacyUser"
Spree.user_class = "Refinery::User"