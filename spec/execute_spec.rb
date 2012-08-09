require 'spec_helper'

describe ".execute" do
  context "with execute_result on execute" do
    execute do
      :success
    end
    
    it "should set execute_result to execute block return value" do
      :success.should == @execute_result
    end
  end
  
  context "execute in nested contexts" do
    before do
      @last_step = :before_level1
    end
    
    execute do
      :before_level1.should == @last_step
      @last_step = :execute_level1
    end
    
    it "should execute execute_level1" do
      @last_step.should == :execute_level1
    end
    
    context "with nested context with no execute" do
      it "should execute execute_level1" do
        @last_step.should == :execute_level1
      end
    end
    
    context "with nested context with execute override" do
      before do
        :before_level1.should == @last_step
        @last_step = :before_level2
      end
      
      execute do
        :before_level2.should == @last_step
        @last_step = :execute_level2
      end

      it "should execute execute_level2" do
        @last_step.should == :execute_level2
      end
    end
  end
end  
