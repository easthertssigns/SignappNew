# -*- encoding: utf-8 -*-
# stub: spree_sample 1.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "spree_sample"
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
  s.rubygems_version = "2.1.9"
  s.summary = "Sample data (including images) for use with Spree."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spree_core>, ["= 1.2.2"])
    else
      s.add_dependency(%q<spree_core>, ["= 1.2.2"])
    end
  else
    s.add_dependency(%q<spree_core>, ["= 1.2.2"])
  end
end
