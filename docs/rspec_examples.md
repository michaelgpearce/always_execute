
# RSpec Examples

## Without Always Execute

Notice in the test below there is **_setup_**, **_execute_**, and **_assert_** code all in the `it` blocks.  Different test cases are not separated by contexts, instead they're all just strewn together; it may not be immediately obvious, but we're really testing 3 different cases below (not 4 - the first 2 `it`s describe the default behavior of the dvd\_player).  It's easy to see how these problems could be much worse given a less trivial example and how these tests would not serve as the best documentation of how dvd_player#play works.

```ruby
  describe "dvd player" do
    before do
      @dvd_player = DvdPlayer.new
      @dvd = Dvd.new
    end

    it "should play movie" do
      @dvd_player.play(@dvd)
      @dvd_player.movie_playing?.should be_true
    end
  
    it "should not allow another disc to be inserted" do
      @dvd_player.play(@dvd)
      @dvd_player.allows_disc_insert?.should be_false
    end

    it "should not play movie with invalid region code" do
      @dvd.region_code = 'invalid'
      @dvd_player.play(@dvd)
      @dvd_player.movie_playing?.should be_false
    end

    it "should resume from last played postiion with previously played dvd" do
      @dvd.last_played_position = 123
      @dvd_player.play(@dvd)
      @dvd_player.movie_playing?.should be_true
      @dvd_player.current_position.should == 123
    end
  end
```

## With Always Execute

When using always execute, you'll notice it's a lot DRYer, but more importantly all the **_setup_**, **_execute_**, and **_assert_** code is cleanly separated.  Furthermore, test cases are cleanly separated by contexts.  This makes it much easier to see that the first two should blocks apply to the default case, whereas the following contexts apply to exception cases.  It's also much easier to see what makes the exception cases different, since their **_setup_** code is cleanly spelled out, rather than lumped in with other code.

```ruby
  describe "dvd player" do
    context "#play" do
      before do
        @dvd_player = DvdPlayer.new
        @dvd = Dvd.new
      end

      execute do
        @dvd_player.play(@dvd)
      end


      it "should play movie" do
        @dvd_player.movie_playing?.should be_true
      end
    
      it "should not allow another disc to be inserted" do
        @dvd_player.allows_disc_insert?.should be_false
      end

      context "with invalid region code" do
        before do
          @dvd.region_code = 'invalid'
        end
  
        it "should not play movie" do
          @dvd_player.movie_playing?.should be_false
        end
      end

      context "with previously played dvd" do
        before do
          @dvd.last_played_position = 123
        end
  
        it "should resume from last played position" do
          @dvd_player.movie_playing?.should be_true
          @dvd_player.current_position.should == 123
        end
      end    
    end
  end
```
    
# Other Features

## execute_result

Often in specs, you are testing the returned value of a single function.  For connivence, the returned value of an execute block is stored in a variable called `@execute_result`.

```ruby
  describe "dvd player" do
    context "#current_dvd" do
      before do
        @dvd_player = DvdPlayer.new
      end

      execute do
        @dvd_player.current_dvd
      end

      context "without any dvd in the player" do
        it "should return no dvd" do
          @execute_result.should be_nil
        end
      end

      context "with a dvd in the player" do
        before do
          @dvd = Dvd.new
          @dvd_player.insert(@dvd)
        end

        it "should return the dvd in the player" do
          @execute_result.should == @dvd
        end
      end
    end
  end
```

