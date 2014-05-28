# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cando"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Bornkessel"]
  s.date = "2014-05-28"
  s.description = "CanDo is a small gem to implement a simple user access system based on users, roles & capabilites, where:\n\n    each user can have 0, 1 or many roles\n    each role can have 0, 1 or many capabilites\n\nUsers have capabilities by getting roles assigned (role == collection of capabilities). Within the code, the can helper method can be used to test whether a user has a certain capability or not (see below for a working code example)."
  s.email = "daniel@soundcloud.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "cando.gemspec",
    "contrib/initial_schema.rb",
    "lib/cando.rb",
    "lib/models/capability.rb",
    "lib/models/role.rb",
    "lib/models/user.rb",
    "lib/tasks/cando.rake",
    "spec/cando_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/kesselborn/cando"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Simple roles helper"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sequel>, ["~> 4.10.0"])
      s.add_runtime_dependency(%q<rake>, ["~> 10.3.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.1.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.8.1"])
    else
      s.add_dependency(%q<sequel>, ["~> 4.10.0"])
      s.add_dependency(%q<rake>, ["~> 10.3.2"])
      s.add_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_dependency(%q<rdoc>, ["~> 4.1.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, ["~> 0.8.1"])
    end
  else
    s.add_dependency(%q<sequel>, ["~> 4.10.0"])
    s.add_dependency(%q<rake>, ["~> 10.3.2"])
    s.add_dependency(%q<rspec>, ["~> 2.14.1"])
    s.add_dependency(%q<rdoc>, ["~> 4.1.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, ["~> 0.8.1"])
  end
end

