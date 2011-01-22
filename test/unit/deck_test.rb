#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../test_helper')

class DeckTest < Test::Unit::TestCase
  context "a deck" do
    setup do
      @deck = Deck.new
    end

    context "#draw" do
      should "be between an Ace and a King" do
        @card = @deck.draw
        assert @card >= 0
        assert @card <= 13
      end

      should "work an infinite number of times" do
        1000.times {@deck.draw}
      end
    end
  end
end
