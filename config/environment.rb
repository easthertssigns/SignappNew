# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SignappNew::Application.initialize!

ActiveRecord::Base.include_root_in_json = true


ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      'app6036345@heroku.com',
    :password =>       'ORZwM7niZC8a4eQUdBaS9w',
    :domain =>         'heroku.com',
    :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp
