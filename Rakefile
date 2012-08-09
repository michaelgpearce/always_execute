require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "always_execute"
  gem.homepage = "http://github.com/michaelgpearce/always_execute"
  gem.license = "MIT"
  gem.summary = %Q{Adds execute and expect test blocks for added BDD test clarity.}
  gem.description = %Q{Adds execute and expect test blocks for added BDD test clarity.}
  gem.email = "michael.pearce@bookrenter.com"
  gem.authors = ["Michael Pearce"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'shoulda', '>= 0'
  gem.add_development_dependency 'shoulda', '>= 2.11.3'
  gem.add_development_dependency 'rspec', '>= 2.9.0'
  gem.add_development_dependency 'shared_should', '>= 0.8.3'
  gem.add_development_dependency 'rcov', '>= 0'
  gem.add_development_dependency 'mocha', '>= 0'
  gem.add_development_dependency 'minitest', '>= 2.12.1'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'rspec/core/rake_task'
desc "Run Rspecs"
RSpec::Core::RakeTask.new(:spec)

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "always_execute #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => [:test, :spec]

