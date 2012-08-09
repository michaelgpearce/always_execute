require "spec_helper"

describe ".expects" do
  before do
    @object = mock
  end
  
  context "with met expectation" do
    execute do
      @object.call_me
    end
    
    expects "call_me to be called" do
      @object.should_receive(:call_me)
    end
    
    expects "call_me to be called second time" do
      @object.should_receive(:call_me)
    end
  end
  
  context "execution order" do
    before do
      @last_step = :before
    end
    
    context "with 'expects'" do
      execute do
        :expects.should == @last_step
        @last_step = :execute
      end

      expects "to be called before execute" do
        :before.should == @last_step
        @last_step = :expects
      end
    end
    
    context "with 'expects' and 'it'" do
      before do
        @expects_called = false
      end
      
      execute do
        :before.should == @last_step
        @last_step = :execute
      end
      
      expects do
        @expects_called = true
      end
      
      it "should not call 'expects' for 'it'" do
        :execute.should == @last_step
        @expects_called.should be_false
      end
    end
  end
end
