require 'always_execute/version'

if defined?(Shoulda::Context::Context)
  require 'always_execute/shoulda_execute'
  require 'always_execute/shoulda_expects'

  class Shoulda::Context::Context
    include AlwaysExecute::ShouldaExecute
    include AlwaysExecute::ShouldaExpects
  end
elsif defined?(Shoulda::Context) && Shoulda::Context.instance_methods.include?(:should)
  require 'always_execute/shoulda_execute'
  require 'always_execute/shoulda_expects'

  class Shoulda::Context
    include AlwaysExecute::ShouldaExecute
    include AlwaysExecute::ShouldaExpects
  end
end

if defined?(RSpec)
  require 'always_execute/rspec_execute'
  require 'always_execute/rspec_expects'

  RSpec.configure do |config|
    config.backtrace_exclusion_patterns ||= []
    config.backtrace_exclusion_patterns << /always_execute/
  end
end
