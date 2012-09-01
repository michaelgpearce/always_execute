if defined?(Shoulda) && defined?(Shoulda::Context) && Shoulda::Context.instance_methods.include?(:should)
  require 'shoulda_execute'
  require 'shoulda_expects'
end

if defined?(RSpec)
  require 'rspec_execute'
  require 'rspec_expects'
end

require 'always_execute/version'
