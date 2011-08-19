class Shoulda::Context
  def expects(name = nil, &expects_block)
    context nil do
      setup do
        expects_block.bind(self).call
      end
      
      should "meet expectation #{name}" do
        # empty body
      end
    end
  end
end

