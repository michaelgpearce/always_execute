# Always Execute - Change the way you test!

Always Execute extends [RSpec](http://rspec.info) or [Shoulda](https://github.com/thoughtbot/shoulda) by adding an execute block, which is the natural home for the actual code you are testing.  Why would you ever need that? The answer is simple, the execute block provides a clear separation of concerns in your test structure making it easier to read and write.  

All good tests have 3 separate and equally important steps:

1. **_Setup_** the environment in a known state
2. **_Execute_** the code you want to test
3. **_Assert_** that your code changed the environment in the way you expected

Both RSpec and Shoulda by default provide blocks to encapsulate the **_setup_** and **_assert_** steps with the `before` / `setup` and `it` / `should` blocks, but there is no built-in block for the **_execute_** step. This leads to muddled blocks for your assertions that often contain bits of **_setup_**, **_execute_**, and **_assert_** code, making the test difficult to understand.  

Checkout the examples:

* [RSpec Examples](http://github.com/michaelgpearce/always_execute/blob/master/docs/rspec_examples.md)
* [Shoulda Examples](http://github.com/michaelgpearce/always_execute/blob/master/docs/shoulda_examples.md)

# Credits

Always Execute was developed by [Michael Pearce](http://github.com/michaelgpearce) in conjunction with [Philippe Huibonhoa](http://github.com/phuibonhoa) and is funded by [Rafter](http://www.rafter.com "Rafter").

![Rafter Logo](http://rafter-logos.s3.amazonaws.com/rafter_github_logo.png "Rafter")


# Copyright

Copyright (c) 2011-2012 Michael Pearce, Bookrenter.com. See LICENSE.txt for further details.