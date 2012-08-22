# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "always_execute/version"

Gem::Specification.new do |s|
  s.name        = "always_execute"
  s.version     = AlwaysExecute::VERSION
  s.authors     = ["Michael Pearce"]
  s.email       = ["michaelgpearce@yahoo.com"]
  s.homepage    = "http://github.com/michaelgpearce/always_execute"
  s.summary     = "Adds execute and expect test blocks for added BDD test clarity"
  s.description = "Adds execute and expect test blocks for added BDD test clarity."

  s.rubyforge_project = "always_execute"

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'shoulda', '~> 2.11.3'
  s.add_development_dependency 'mocha', '~> 0'
  s.add_development_dependency 'minitest', '~> 2.12.1'
  s.add_development_dependency 'shared_should', '~> 0.8.3'
end

