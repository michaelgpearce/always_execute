require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'rspec/core/rake_task'
desc "Run Rspecs"
RSpec::Core::RakeTask.new(:spec)

task :default => [:test, :spec]

