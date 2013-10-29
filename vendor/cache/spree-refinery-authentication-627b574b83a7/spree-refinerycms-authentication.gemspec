# -*- encoding: utf-8 -*-
# stub: spree-refinerycms-authentication 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "spree-refinerycms-authentication"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Macneil"]
  s.date = "2013-10-29"
  s.description = "Configure Spree to use RefineryCMS for authentication"
  s.email = ["adrian@crescendo.net.nz"]
  s.files = [".gitignore", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "db/migrate/20120830045627_add_spree_fields_to_refinery_users_table.rb", "lib/spree-refinerycms-authentication.rb", "lib/spree/authentication_helpers.rb", "lib/spree_refinery_authentication/engine.rb", "spree-refinerycms-authentication.gemspec"]
  s.homepage = "https://github.com/adrianmacneil/spree-refinerycms-authentication"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.9"
  s.summary = "Spree has a pluggable authentication system. This gem will tell Spree to use the built in RefineryCMS user model and authentication."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spree>, ["~> 1.2"])
      s.add_runtime_dependency(%q<refinerycms>, ["~> 2.0"])
    else
      s.add_dependency(%q<spree>, ["~> 1.2"])
      s.add_dependency(%q<refinerycms>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<spree>, ["~> 1.2"])
    s.add_dependency(%q<refinerycms>, ["~> 2.0"])
  end
end
