# -*- encoding: utf-8 -*-
# stub: globalize3 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "globalize3"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sven Fuchs", "Joshua Harvey", "Clemens Kofler", "John-Paul Bader", "Tomasz Stachewicz", "Philip Arndt", "Chris Salzberg"]
  s.date = "2013-10-24"
  s.description = "Rails I18n de-facto standard library for ActiveRecord 3 model/data translation."
  s.email = "nobody@globalize-rails.org"
  s.homepage = "http://github.com/svenfuchs/globalize3"
  s.post_install_message = "\nHEADS UP! Globalize3 has been renamed \"Globalize\" and now supports both\nActiveRecord 3.x and ActiveRecord 4. To use the new gem with ActiveRecord\n3.x, replace \"gem 'globalize3'\" with \"gem 'globalize', '~> 3.0.0'\" in your\nGemfile.\n\nAll future updates to the ActiveRecord 3.x version of Globalize will happen\nin versions 3.x of the new gem (globalize). globalize3 is deprecated and will\nno longer be updated.\n\n"
  s.require_paths = ["lib"]
  s.rubyforge_project = "[none]"
  s.rubygems_version = "2.1.9"
  s.summary = "Rails I18n de-facto standard library for ActiveRecord 3 model/data translation"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<paper_trail>, ["~> 2"])
      s.add_development_dependency(%q<database_cleaner>, ["~> 0.6.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<pathname_local>, [">= 0"])
      s.add_development_dependency(%q<test_declarative>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_dependency(%q<paper_trail>, ["~> 2"])
      s.add_dependency(%q<database_cleaner>, ["~> 0.6.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<pathname_local>, [">= 0"])
      s.add_dependency(%q<test_declarative>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<activemodel>, [">= 3.0.0"])
    s.add_dependency(%q<paper_trail>, ["~> 2"])
    s.add_dependency(%q<database_cleaner>, ["~> 0.6.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<pathname_local>, [">= 0"])
    s.add_dependency(%q<test_declarative>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
