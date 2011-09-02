# Always Execute - Change the way you test!

Always Execute extends [Shoulda](https://github.com/thoughtbot/shoulda) by adding an execute block, which is the natural home for the actual code you are testing.  Why would you ever need that? The answer is simple, the execute block provides a clear separation of concerns in your test structure making it easier to read and write.  

All good tests have 3 separate and equally important steps:

1. **_Setup_** the environment in a known state
2. **_Execute_** the code you want to test
3. **_Assert_** that your code changed the environment in the way you expected

Shoulda by default provides blocks to encapsulate the **_setup_** and **_assert_** steps with the `setup` and `should` blocks, but there is no built-in block for the **_execute_** step. This leads to muddled `should` blocks that often contain bits of **_setup_**, **_execute_**, and **_assert_** code, making the test difficult to understand.  


## Examples

### Without Always Execute

Notice in the test below there is **_setup_**, **_execute_**, and **_assert_** code all in the `should` blocks.  Different test cases are not separated by contexts, instead they're all just strewn together; it may not be immediately obvious, but we're really testing 3 different cases below (not 4 - the first 2 shoulds describe the default behavior of the dvd\_player).  It's easy to see how these problems could be much worse given a less trivial example and how these tests would not serve as the best documentation of how dvd_player#play works.

```ruby
  class DvdPlayerTest
    context "dvd player" do
      setup do
        @dvd_player = DvdPlayer.new
        @dvd = Dvd.new
      end

      should "play movie" do
        @dvd_player.play(@dvd)
        assert @dvd_player.movie_playing?
      end
    
      should "not allow another disc to be inserted" do
        @dvd_player.play(@dvd)
        assert_equal false, @dvd_player.allows_disc_insert?
      end

      should "not play movie with invalid region code" do
        @dvd.region_code = 'invalid'
        @dvd_player.play(@dvd)
        assert_equal false, @dvd_player.movie_playing?
      end

      should "resume from last played postiion with previously played dvd" do
        @dvd.last_played_position = 123
        @dvd_player.play(@dvd)
        assert @dvd_player.movie_playing?
        assert_equal 123, @dvd_player.current_position
      end
    end
  end
```

### With Always Execute

When using always execute, you'll notice it's a lot DRYer, but more importantly all the **_setup_**, **_execute_**, and **_assert_** code is cleanly separated.  Furthermore, test cases are cleanly separated by contexts.  This makes it much easier to see that the first two should blocks apply to the default case, whereas the following contexts apply to exception cases.  It's also much easier to see what makes the exception cases different, since their **_setup_** code is cleanly spelled out, rather than lumped in with other code.

```ruby
  class DvdPlayerTest
    context "#play" do
      setup do
        @dvd_player = DvdPlayer.new
        @dvd = Dvd.new
      end

      execute do
        @dvd_player.play(@dvd)
      end


      should "play movie" do
        assert @dvd_player.movie_playing?
      end
    
      should "not allow another disc to be inserted" do
        assert_equal false, @dvd_player.allows_disc_insert?
      end

      context "with invalid region code" do
        setup do
          @dvd.region_code = 'invalid'
        end
  
        should "not play movie" do
          assert_equal false, @dvd_player.movie_playing?
        end
      end

      context "with previously played dvd" do
        setup do
          @dvd.last_played_position = 123
        end
  
        should "resume from last played position" do
          assert @dvd_player.movie_playing?
          assert_equal 123, @dvd_player.current_position
        end
      end    
    end
  end
```
    

# Credits

Always Execute was developed by [Michael Pearce](http://github.com/michaelgpearce) in conjunction with [Philippe Huibonhoa](http://github.com/phuibonhoa) and is funded by [BookRenter.com](http://www.bookrenter.com "BookRenter.com"). 

![BookRenter.com Logo](http://assets0.bookrenter.com/images/header/bookrenter_logo.gif "BookRenter.com")


# Copyright

Copyright (c) 2011 Michael Pearce, Bookrenter.com. See LICENSE.txt for further details.