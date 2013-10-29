# -*- encoding: utf-8 -*-
# stub: refinerycms-settings 2.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "refinerycms-settings"
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip Arndt", "U\u{123}is Ozols"]
  s.date = "2013-06-18"
  s.description = "Adds programmer creatable, user editable settings."
  s.email = "info@refinerycms.com"
  s.homepage = "http://refinerycms.com"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "refinerycms"
  s.rubygems_version = "2.1.9"
  s.summary = "Settings engine for Refinery CMS"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<refinerycms-core>, ["~> 2.0.10"])
      s.add_runtime_dependency(%q<acts_as_indexed>, ["~> 0.7.7"])
    else
      s.add_dependency(%q<refinerycms-core>, ["~> 2.0.10"])
      s.add_dependency(%q<acts_as_indexed>, ["~> 0.7.7"])
    end
  else
    s.add_dependency(%q<refinerycms-core>, ["~> 2.0.10"])
    s.add_dependency(%q<acts_as_indexed>, ["~> 0.7.7"])
  end
end
