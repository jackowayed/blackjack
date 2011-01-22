#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../test_helper')

class GameTest < Test::Unit::TestCase
  context "a game" do
    setup do
      @game = Game.new
    end

    should "start with 500 chips" do
      assert_equal 500, @game.chips
    end
  end
end
