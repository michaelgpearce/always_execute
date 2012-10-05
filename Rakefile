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

task 'testversions' do
  ENV['SHOULDA_VERSION'] = '2.11.3'
  fail unless system "bundle update"
  fail unless system "rake test"
  ENV['SHOULDA_VERSION'] = '3.1.1'
  fail unless system "bundle update"
  fail unless system "rake test"
end

task :default => [:testversions, :spec]
