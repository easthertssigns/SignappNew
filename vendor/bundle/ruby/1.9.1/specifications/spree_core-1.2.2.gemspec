# -*- encoding: utf-8 -*-
# stub: spree_core 1.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "spree_core"
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Schofield"]
  s.date = "2012-11-19"
  s.description = "Required dependency for Spree"
  s.email = "sean@spreecommerce.com"
  s.homepage = "http://spreecommerce.com"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.requirements = ["none"]
  s.rubyforge_project = "spree_core"
  s.rubygems_version = "2.1.9"
  s.summary = "Core e-commerce functionality for the Spree project."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<acts_as_list>, ["= 0.1.4"])
      s.add_runtime_dependency(%q<awesome_nested_set>, ["= 2.1.4"])
      s.add_runtime_dependency(%q<jquery-rails>, ["~> 2.0"])
      s.add_runtime_dependency(%q<select2-rails>, ["~> 3.0"])
      s.add_runtime_dependency(%q<highline>, ["= 1.6.11"])
      s.add_runtime_dependency(%q<state_machine>, ["= 1.1.2"])
      s.add_runtime_dependency(%q<ffaker>, ["~> 1.12.0"])
      s.add_runtime_dependency(%q<paperclip>, ["~> 2.8"])
      s.add_runtime_dependency(%q<aws-sdk>, ["~> 1.3.4"])
      s.add_runtime_dependency(%q<ransack>, ["~> 0.7.0"])
      s.add_runtime_dependency(%q<activemerchant>, ["= 1.28.0"])
      s.add_runtime_dependency(%q<rails>, ["~> 3.2.9"])
      s.add_runtime_dependency(%q<kaminari>, ["= 0.13.0"])
      s.add_runtime_dependency(%q<deface>, [">= 0.9.0"])
      s.add_runtime_dependency(%q<stringex>, ["~> 1.3.2"])
      s.add_runtime_dependency(%q<cancan>, ["= 1.6.7"])
      s.add_runtime_dependency(%q<money>, ["= 5.0.0"])
      s.add_runtime_dependency(%q<rabl>, ["= 0.7.2"])
    else
      s.add_dependency(%q<acts_as_list>, ["= 0.1.4"])
      s.add_dependency(%q<awesome_nested_set>, ["= 2.1.4"])
      s.add_dependency(%q<jquery-rails>, ["~> 2.0"])
      s.add_dependency(%q<select2-rails>, ["~> 3.0"])
      s.add_dependency(%q<highline>, ["= 1.6.11"])
      s.add_dependency(%q<state_machine>, ["= 1.1.2"])
      s.add_dependency(%q<ffaker>, ["~> 1.12.0"])
      s.add_dependency(%q<paperclip>, ["~> 2.8"])
      s.add_dependency(%q<aws-sdk>, ["~> 1.3.4"])
      s.add_dependency(%q<ransack>, ["~> 0.7.0"])
      s.add_dependency(%q<activemerchant>, ["= 1.28.0"])
      s.add_dependency(%q<rails>, ["~> 3.2.9"])
      s.add_dependency(%q<kaminari>, ["= 0.13.0"])
      s.add_dependency(%q<deface>, [">= 0.9.0"])
      s.add_dependency(%q<stringex>, ["~> 1.3.2"])
      s.add_dependency(%q<cancan>, ["= 1.6.7"])
      s.add_dependency(%q<money>, ["= 5.0.0"])
      s.add_dependency(%q<rabl>, ["= 0.7.2"])
    end
  else
    s.add_dependency(%q<acts_as_list>, ["= 0.1.4"])
    s.add_dependency(%q<awesome_nested_set>, ["= 2.1.4"])
    s.add_dependency(%q<jquery-rails>, ["~> 2.0"])
    s.add_dependency(%q<select2-rails>, ["~> 3.0"])
    s.add_dependency(%q<highline>, ["= 1.6.11"])
    s.add_dependency(%q<state_machine>, ["= 1.1.2"])
    s.add_dependency(%q<ffaker>, ["~> 1.12.0"])
    s.add_dependency(%q<paperclip>, ["~> 2.8"])
    s.add_dependency(%q<aws-sdk>, ["~> 1.3.4"])
    s.add_dependency(%q<ransack>, ["~> 0.7.0"])
    s.add_dependency(%q<activemerchant>, ["= 1.28.0"])
    s.add_dependency(%q<rails>, ["~> 3.2.9"])
    s.add_dependency(%q<kaminari>, ["= 0.13.0"])
    s.add_dependency(%q<deface>, [">= 0.9.0"])
    s.add_dependency(%q<stringex>, ["~> 1.3.2"])
    s.add_dependency(%q<cancan>, ["= 1.6.7"])
    s.add_dependency(%q<money>, ["= 5.0.0"])
    s.add_dependency(%q<rabl>, ["= 0.7.2"])
  end
end
