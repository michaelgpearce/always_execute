
# Shoulda Examples

## Without Always Execute

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

## With Always Execute

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
    
# Other Features

## execute_result

Often in unit tests, you are testing the returned value of a single function.  For connivence, the returned value of an execute block is stored in a variable called `@execute_result`.

```ruby
  class DvdPlayerTest
    context "#current_dvd" do
      setup do
        @dvd_player = DvdPlayer.new
      end

      execute do
        @dvd_player.current_dvd
      end

      context "without any dvd in the player" do
        should "return no dvd" do
          assert_nil @execute_result
        end
      end

      context "with a dvd in the player" do
        setup do
          @dvd = Dvd.new
          @dvd_player.insert(@dvd)
        end

        should "return the dvd in the player" do
          assert_equal @dvd, @execute_result
        end
      end
    end
  end
```

## expects

Expectations belong in the **_assert_** step of testing, but because of the nature of mocha expectations they need to be called in your `setup` block.  The `expects` block allows you to set your expectations without needing to create a new context.

```ruby
  class DvdPlayerTest
    context "#menu" do
      setup do
        @dvd_player = DvdPlayer.new
      end

      execute do
        @dvd_player.menu
      end

      expects do
        @dvd_player.expects(:display_menu_options)
      end    
    end
  end
```

