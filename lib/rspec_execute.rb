module RSpec
  module Core
    class Example
      alias :initialize_without_execute :initialize
      
      def initialize(example_group_class, description, metadata, example_block=nil)
        if example_block
          example_block_with_execute = Proc.new do |*args|
            if @execute_block
              self.instance_variable_set('@execute_result', instance_exec(&@execute_block))
            end
            instance_exec(*args, &example_block)
          end
        end
        
        initialize_without_execute(example_group_class, description, metadata, example_block_with_execute)
      end
    end
    
    class ExampleGroup
      def self.execute(&execute_block)
        before do
          @execute_block = execute_block
        end
      end
    end
  end
end

