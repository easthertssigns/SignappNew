## encoding: utf-8
Refinery::Core.configure do |config|
  # Configures the path of login used on redirected nonmembers users
  # config.new_user_path = <%= Refinery::Memberships.new_user_path.inspect %>
  # Configures the "from" email
  config.admin_email = "doug@wearealight.com"
  # config.memberships_deliver_notification_to_users = ""
end