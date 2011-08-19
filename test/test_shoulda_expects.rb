require "helper"

class TestShouldaExpects < Test::Unit::TestCase
  context ".expects" do
    setup do
      @object = mock
    end
    
    context "with met expectation" do
      execute do
        @object.call_me
      end
      
      expects "call_me to be called" do
        @object.expects(:call_me)
      end
      
      expects "call_me to be called second time" do
        @object.expects(:call_me)
      end
    end
    
    context "execution order" do
      setup do
        @last_step = :setup
      end
      
      context "with 'expects'" do
        execute do
          assert_equal :expects, @last_step
          @last_step = :execute
        end

        expects "to be called before execute" do
          assert_equal :setup, @last_step
          @last_step = :expects
        end
      end
      
      context "with 'expects' and 'should'" do
        setup do
          @expects_called = false
        end
        
        execute do
          assert_equal :setup, @last_step
          @last_step = :execute
        end
        
        expects do
          @expects_called = true
        end
        
        should "not call 'expects' for 'should'" do
          assert_equal :execute, @last_step
          assert !@expects_called
        end
      end
    end
  end
end
