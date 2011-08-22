require "helper"

class ShouldaExecuteTest < Test::Unit::TestCase  
  context ".execute" do
    context "with execute_result on execute" do
      execute do
        :success
      end
      
      context "with shared_should library" do
        setup do
          assert ShouldaExecuteTest.respond_to? :share_should
        end
        
        should "set execute_result to execute block return value" do
          assert_equal :success, @execute_result
        end
      end
      
      context "without shared_should library" do
        setup do
          Shoulda::Context.expects(:should_execute_shared_should_available?).at_least_once.returns(false)
        end
        
        should "set execute_result to execute block return value" do
          assert_equal :success, @execute_result
        end
      end
    end
    
    context "execute in nested contexts" do
      setup do
        @last_step = :setup_level1
      end
      
      execute do
        assert_equal :setup_level1, @last_step
        @last_step = :execute_level1
      end
      
      should "execute execute_level1" do
        assert_equal @last_step, :execute_level1
      end
      
      context "with nested context with no execute" do
        should "execute execute_level1" do
          assert_equal @last_step, :execute_level1
        end
      end
      
      context "with nested context with execute override" do
        setup do
          assert_equal :setup_level1, @last_step
          @last_step = :setup_level2
        end
        
        execute do
          assert_equal :setup_level2, @last_step
          @last_step = :execute_level2
        end

        should "execute execute_level2" do
          assert_equal @last_step, :execute_level2
        end
      end
    end
  end  
end
