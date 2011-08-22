class Shoulda::Context
  def execute(&execute_block)
    setup do
      @execute_block = execute_block
    end
  end

  alias :should_without_execute :should

  def should(name = nil, options = {}, &block)
    if block.nil?
      should_without_execute(name, options)
    else
      should_without_execute(name, options) do
        if @execute_block
          self.instance_variable_set('@execute_result', Shoulda::Context.shoulda_execute_call_block(self, @execute_block))
        end
        Shoulda::Context.shoulda_execute_call_block(self, block)
      end
    end
  end
  
  def self.shoulda_execute_call_block(test, block)
    if should_execute_shared_should_available?
      test.call_block_with_shared_value(block)
    else
      block.bind(test).call
    end
  end
  
  def self.should_execute_shared_should_available?
    Test::Unit::TestCase.respond_to? :share_context
  end
end

