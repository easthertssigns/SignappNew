source 'https://rubygems.org'

#ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'pg'

gem 'jquery-rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'spree', '1.2'
#gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git'
gem 'spree-refinerycms-authentication', :git => 'git://github.com/adrianmacneil/spree-refinery-authentication.git'
#gem 'spree_promo', "1.1.2.rc1"
# gem "spree_auth"
# gem 'spree_flexi_variants', :git => 'https://github.com/jsqu99/spree_flexi_variants.git'
gem 'spree_related_products', :git => 'git://github.com/spree/spree_related_products.git', :branch => '1-2-stable'
# gem 'spree_minicart' #, '~> 1.1.0'
# gem 'refinerycms-home_sliders', :path => 'vendor/extensions'
#gem 'spree_html_email', :git => 'git://github.com/campbell/spree-html-email.git'
gem 'spree_gateway', github: 'spree/spree_gateway', branch: '1-2-stable'
gem 'spree_sagepayform', github: 'WeAreAlight/spree_sagepayform'

group :production do
  gem 'fog'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'devise'
gem 'acts_as_indexed'
#gem 'awesome_nested_set', "2.1.5"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Refinery CMS
gem 'refinerycms'

# Specify additional Refinery CMS Extensions here (all optional):
gem 'refinerycms-memberships', :path => 'vendor/gems/refinerycms_membership-da0ac8fc44a4'
#gem 'refinerycms-memberships', :path => 'vendor/gems/refinerycms-memberships-2.0'
gem 'refinerycms-inquiries'
# gem 'refinerycms-mailchimp', :github => 'Wirelab/refinerycms-mailchimp', :branch => 'refinery-2.0'
# gem 'refinerycms-i18n', '~> 2.0.0'
# gem 'refinerycms-blog', '~> 2.0.0'
# gem 'refinerycms-search', '~> 2.0.0'
# gem 'refinerycms-page-images', '~> 2.0.0'

gem 'refinerycms-home_page_sliders', :path => 'vendor/extensions'
gem 'omniauth'
gem 'omniauth-facebook'
