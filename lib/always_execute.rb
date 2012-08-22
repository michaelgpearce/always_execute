if defined?(Shoulda)
  require 'shoulda_execute'
  require 'shoulda_expects'
end

if defined?(RSpec)
  require 'rspec_execute'
  require 'rspec_expects'
end

require 'always_execute/version'
