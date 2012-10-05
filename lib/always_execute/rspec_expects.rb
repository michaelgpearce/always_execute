module RSpec
  module Core
    class ExampleGroup
      def self.expects(name = nil, &expects_block)
        describe nil do
          before do
            instance_exec(&expects_block)
          end

          it "should meet expectation #{name}" do
            # empty body
          end
        end
      end
    end
  end
end

